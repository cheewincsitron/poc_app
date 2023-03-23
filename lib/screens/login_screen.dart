import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:go_router/go_router.dart';
import 'package:poc_app/constants/route_constant.dart';
import 'package:poc_app/presentations/bloc/auth_bloc/auth_bloc.dart';
import 'package:poc_app/presentations/cubit/login/login_cubit.dart';
import 'package:poc_app/size_config.dart';
import 'package:poc_app/widgets/app_text.dart';
import 'package:poc_app/widgets/circle_button.dart';
import 'package:poc_app/widgets/default_button.dart';
import 'package:sizer/sizer.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isFacebookLogin = false;
  Map facebookData = {};

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return BlocListener<AuthenticationBloc, AuthenticationState>(
      listener: (_, state) {
        if (state is AuthenticationAuthenticated) {
          context.goNamed(RouteConstants.main);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text(
            "Sign in",
          ),
        ),
        body: BlocListener<LoginCubit, LoginState>(
          listener: (context, state) {
            if (state is LoginFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text("Login failed."),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.pink[50],
                ),
                // color: Colors.amber[50],
                margin: const EdgeInsets.all(32),
                padding: const EdgeInsets.all(24),
                child: Column(
                  // mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    buildTextFieldEmail(),
                    buildTextFieldPassword(),
                    buildButtonSignIn(),
                    const SizedBox(height: 16),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CircleButton(
                          icon: Icons.facebook_sharp,
                          onPressed: () {
                            _facebookSignIn();
                          },
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CircleButton(
                          icon: Icons.login_outlined,
                          onPressed: () {},
                          color: Colors.blue,
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        CircleButton(
                          icon: Icons.apple,
                          onPressed: () {},
                          // color: Colors.blue,
                        ),
                      ],
                    ),
                    isFacebookLogin
                        ? Column(
                            children: [
                              const Text("facebook data"),
                              Text(facebookData["name"].toString()),
                              Text(facebookData["email"].toString()),
                              DefaultButton(
                                text: "Sign out",
                                press: () {
                                  _facebookSignOut();
                                },
                              )
                            ],
                          )
                        : const SizedBox.shrink(),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildButtonSignIn() {
    return InkWell(
      child: Container(
          constraints: const BoxConstraints.expand(height: 50),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              color: Colors.green[200]),
          margin: const EdgeInsets.only(top: 16),
          padding: const EdgeInsets.all(12),
          child: const Text("Sign in",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 18, color: Colors.white))),
      onTap: () {
        singIn();
      },
    );
  }

  Container buildTextFieldEmail() {
    return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: emailController,
            decoration: const InputDecoration.collapsed(hintText: "Email"),
            style: const TextStyle(fontSize: 18)));
  }

  Container buildTextFieldPassword() {
    return Container(
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.only(top: 12),
        decoration: BoxDecoration(
            color: Colors.yellow[50], borderRadius: BorderRadius.circular(16)),
        child: TextField(
            controller: passwordController,
            obscureText: true,
            decoration: const InputDecoration.collapsed(hintText: "Password"),
            style: const TextStyle(fontSize: 18)));
  }

  void singIn() {
    try {
      String email = emailController.text.trim();
      String password = passwordController.text.trim();
      // context.read<LoginBloc>().add(LoginButtonPressed(
      //       email: "eve.holt@reqres.in",
      //       password: "cityslicka",
      //     ));
      context.read<LoginCubit>().onLoginButtonPressed(
          email: "eve.holt@reqres.in", password: "cityslicka");
      // Navigator.of(context).pop();
      context.canPop()
          ? context.pop()
          : context.pushReplacementNamed(RouteConstants.main);
    } catch (e) {
      print(e);
    }
  }

  void _facebookSignIn() async {
    FacebookAuth.instance
        .login(permissions: ["public_profile", "email"])
        .then((value) => {
              FacebookAuth.instance.getUserData().then((userData) => {
                    setState(
                      () {
                        isFacebookLogin = true;
                        facebookData = userData;
                      },
                    )
                  })
            })
        .catchError((onError) => {print(onError)});
  }

  void _facebookSignOut() async {
    FacebookAuth.instance.logOut().then((value) => {
          setState(
            () {
              isFacebookLogin = false;
              facebookData = {};
            },
          )
        });
  }
}
