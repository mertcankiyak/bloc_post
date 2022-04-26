import 'package:bloc_post/core/init/cache/cache_manager.dart';
import 'package:bloc_post/features/login/model/request_model.dart';
import 'package:bloc_post/features/login/model/response_model.dart';
import 'package:bloc_post/features/login/service/Login_service.dart';
import 'package:bloc_post/product/enums/preferences_key.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';

class LoginCubit extends Cubit<LoginState> {
  LoginCubit({required this.loginService, required this.cacheManager})
      : super(LoginInitial());

  final LoginService loginService;
  final CacheManager cacheManager;

  bool isLoading = false;

  Future<void> login({required RequestUserModel requestUserModel}) async {
    changeLoadingStatus();
    final data = await loginService.login(requestModel: requestUserModel);
    await cacheManager.setStringValue(
        key: PreferencesKey.token, value: data?.token ?? "");
    changeLoadingStatus();
    if (data != null) {
      String token = cacheManager.getStringValue(key: PreferencesKey.token);
      emit(LoginSuccess(token: token));
    } else {
      emit(LoginError(error: "Bir Sorunla Karşılaşıldı"));
    }
  }

  Future<void> currentUser() async {
    changeLoadingStatus();
    String token = cacheManager.getStringValue(key: PreferencesKey.token);
    changeLoadingStatus();
    if (token != "") {
      emit(LoginCache(token: token));
    } else {
      emit(LoginInitial());
    }
  }

  void changeLoadingStatus() {
    isLoading = !isLoading;
    emit(LoginLoading(isLoading: isLoading));
  }
}

abstract class LoginState {}

class LoginInitial extends LoginState {}

class LoginLoading extends LoginState {
  LoginLoading({required this.isLoading});
  bool isLoading = false;
}

class LoginSuccess extends LoginState {
  LoginSuccess({required this.token});
  final String token;
}

class LoginError extends LoginState {
  LoginError({required this.error});
  String? error;
}

class LoginCache extends LoginState {
  LoginCache({required this.token});
  final String token;
}
