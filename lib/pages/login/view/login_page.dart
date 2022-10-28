import 'package:demo_login/models/requests/login_request.dart';
import 'package:demo_login/utils/routers/routers.dart';
import 'package:demo_login/view_models/profile_view_model.dart';
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
                      const FlutterLogo(),
                      const Spacer(),
                      TextFormField(
                        validator: MyValidator.isValidEmail,
                        focusNode: emailFocus,
                        controller: emailController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          labelText: 'Email',
                        ),
                      ),
                      const Spacer(),
                      TextFormField(
                        validator: MyValidator.isValidPassword,
                        controller: passwordController,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          labelText: 'Password',
                        ),
                      ),
                      const Spacer(),
                      TextButton(
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
                              (p0) =>
                                  ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  backgroundColor: Colors.red,
                                  content: Text('Error: $p0'),
                                ),
                              ),
                              (p0) => showDialog<void>(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  title: const Text(
                                      'User name password not found!'),
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
                              ),
                              () => showDialog(
                                context: context,
                                builder: (_) => const Center(
                                  child: CircularProgressIndicator(),
                                ),
                              ),
                              () => Navigator.of(context).pop(),
                            )
                                .then((_) {
                              if (profileViewModel.isLogin) {
                                context.pushNamed(Routers.profile.name);
                              }
                            });
                          }
                        },
                        child: const Text('Login'),
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
}
