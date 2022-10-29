import 'dart:async';

import 'package:demo_login/api/models/requests/login_request.dart';
import 'package:demo_login/utils/routers/routers.dart';
import 'package:demo_login/api/view_models/profile_view_model.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../utils/validator/validator.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  late ProfileViewModel profileViewModel;
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final emailFocus = FocusNode();
  final passwordController = TextEditingController();
  final validateMode = ValueNotifier(AutovalidateMode.disabled);
  @override
  void initState() {
    super.initState();
    profileViewModel = ProfileViewModel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Login'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: ValueListenableBuilder<AutovalidateMode>(
              valueListenable: validateMode,
              builder: (context, value, _) {
                return Form(
                  autovalidateMode: value,
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Spacer(flex: 6),
                      const FlutterLogo(
                        size: 100,
                      ),
                      const Spacer(),
                      TextFormField(
                        validator: MyValidator.isValidEmail,
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        focusNode: emailFocus,
                        controller: emailController,
                        decoration: InputDecoration(
                          hintText: 'Input Email',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const Spacer(),
                      TextFormField(
                        style: const TextStyle(
                          fontSize: 18,
                        ),
                        validator: MyValidator.isValidPassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          hintText: 'Input Password',
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                      const Spacer(),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                        ),
                        onPressed: () {
                          if (validateMode.value == AutovalidateMode.disabled) {
                            validateMode.value =
                                AutovalidateMode.onUserInteraction;
                          }
                          if (formKey.currentState?.validate() ?? false) {
                            profileViewModel
                                .login(
                                  LoginRequestModel(
                                    email: emailController.text,
                                    password: passwordController.text,
                                  ),
                                  _onError,
                                  _onUserPassFound,
                                  _onLoading,
                                  _onSuccess,
                                )
                                .then(_onLoginSuccess);
                          }
                        },
                        child: const Text(
                          'Login',
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const Spacer(flex: 6),
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _onError(String p0) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        backgroundColor: Colors.red,
        content: Text('Error: $p0'),
      ),
    );
  }

  _onUserPassFound(String p0) {
    showDialog<void>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('User name password not found!'),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
              emailFocus.requestFocus();
            },
            child: const Text('Ok'),
          ),
          TextButton(
            onPressed: () {},
            child: const Text('Cancel'),
          ),
        ],
      ),
    );
  }

  _onLoading() {
    showDialog(
      context: context,
      builder: (_) => const Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  _onSuccess() {
    Navigator.of(context).pop();
  }

  FutureOr _onLoginSuccess(void value) {
    if (profileViewModel.isLogin) {
      context.pushNamed(Routers.profile.name);
    }
  }
}
