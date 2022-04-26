import 'package:bloc_post/core/init/cache/cache_manager.dart';
import 'package:bloc_post/features/login/model/request_model.dart';
import 'package:bloc_post/features/login/service/Login_service.dart';
import 'package:bloc_post/features/login/viewmodel/Login_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget {
  LoginView({Key? key}) : super(key: key);

  LoginService _loginService = LoginService();
  final CacheManager _cacheManager = CacheManager.instance;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final cubit = LoginCubit(
            loginService: _loginService, cacheManager: _cacheManager);
        cubit.currentUser();
        return cubit;
      },
      child: BlocConsumer<LoginCubit, LoginState>(
        listener: (context, state) {},
        builder: (context, state) {
          return Scaffold(
            floatingActionButton: FloatingActionButton(
              onPressed: () {
                context.read<LoginCubit>().login(
                    requestUserModel: RequestUserModel(
                        email: "eve.holt@reqres.in", password: "cityslicka"));
              },
              child: Text("Tıkla"),
            ),
            appBar: AppBar(
              title: Text("Login View"),
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (state is LoginSuccess) ...[
                  Text("Giriş başarılı" + state.token)
                ] else if (state is LoginLoading) ...[
                  Text("Giriş Yükleniyor")
                ] else if (state is LoginError) ...[
                  Text("Giriş Hatası")
                ] else if (state is LoginCache) ...[
                  Text("Kullanıcı Cacheden Geldi: " + state.token)
                ] else if (state is LoginInitial) ...{
                  Text("Lütfen Giriş yapınız"),
                },
              ],
            ),
          );
        },
      ),
    );
  }
}
// Form kısmını yapıp kullanıcıdan email ve şifre al