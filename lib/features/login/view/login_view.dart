import 'package:bloc_post/core/init/cache/cache_manager.dart';
import 'package:bloc_post/features/login/model/request_model.dart';
import 'package:bloc_post/features/login/service/Login_service.dart';
import 'package:bloc_post/features/login/viewmodel/Login_viewmodel.dart';
import 'package:bloc_post/product/constants/string_constants.dart';
import 'package:bloc_post/product/mixin/form_validate.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LoginView extends StatelessWidget with FormValidate {
  LoginView({Key? key}) : super(key: key);

  final LoginService _loginService = LoginService();
  final CacheManager _cacheManager = CacheManager.instance;

  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _emailEditTextController =
      TextEditingController();
  final TextEditingController _passwordEditTextController =
      TextEditingController();

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
            appBar: _buildAppBar(),
            body: _buildBody(state, context),
          );
        },
      ),
    );
  }

  AppBar _buildAppBar() {
    return AppBar(
      title: const Text("Login View"),
    );
  }

  Column _buildBody(LoginState state, BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (state is LoginSuccess) ...[
          _buildLoginSuccessText(state, context),
          _buildSuccessLogOutButton(context),
        ] else if (state is LoginLoading) ...[
          _buildProgressBar(),
        ] else if (state is LoginError) ...[
          _buildLoginErrorText(state, context),
          _buildErrorTryLoginButton(context),
        ] else if (state is LoginCache) ...[
          _buildCacheLoginText(state, context),
          _buildCacheLogOutButton(context),
        ] else if (state is LoginInitial) ...{
          _buildLoginForm(context),
        },
      ],
    );
  }

  Center _buildLoginSuccessText(LoginSuccess state, BuildContext context) {
    return Center(
      child: Text(
        "Giriş Başarılı: " + state.token,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildSuccessLogOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        context.read<LoginCubit>().logOut();
      }),
      child: const Text("Çıkış Yap"),
    );
  }

  Center _buildProgressBar() {
    return const Center(
      child: CircularProgressIndicator(),
    );
  }

  Center _buildLoginErrorText(LoginError state, BuildContext context) {
    return Center(
      child: Text(
        state.error ?? "Giriş Hatası",
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildErrorTryLoginButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        context.read<LoginCubit>().tryLogin();
      }),
      child: const Text("Tekrar Giriş Yap"),
    );
  }

  Center _buildCacheLoginText(LoginCache state, BuildContext context) {
    return Center(
      child: Text(
        "Kullanıcı Cacheden Geldi: " + state.token,
        style: Theme.of(context).textTheme.bodyText1,
        textAlign: TextAlign.center,
      ),
    );
  }

  ElevatedButton _buildCacheLogOutButton(BuildContext context) {
    return ElevatedButton(
      onPressed: (() {
        context.read<LoginCubit>().logOut();
      }),
      child: const Text("Çıkış Yap"),
    );
  }

  Form _buildLoginForm(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          _buildEmailTextformField(),
          _buildPasswordTextFormField(),
          _buildLoginButton(context)
        ],
      ),
    );
  }

  Padding _buildEmailTextformField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        controller: _emailEditTextController,
        validator: emailValidation,
        autocorrect: true,
        decoration: InputDecoration(
          hintText: email,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  Padding _buildPasswordTextFormField() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextFormField(
        obscureText: true,
        controller: _passwordEditTextController,
        validator: passwordControl,
        autocorrect: true,
        decoration: InputDecoration(
          hintText: password,
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }

  ElevatedButton _buildLoginButton(BuildContext context) {
    return ElevatedButton(
        onPressed: (() {
          if (_formKey.currentState!.validate()) {
            _formKey.currentState!.save();
            context.read<LoginCubit>().login(
                  requestUserModel: RequestUserModel(
                    email: _emailEditTextController.text.trim(),
                    password: _passwordEditTextController.text.trim(),
                  ),
                );
          }
        }),
        child: Text(girisYap));
  }
}
