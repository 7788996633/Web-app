import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:webapp/cubits/login_cubit/login_cubit.dart';
import 'package:webapp/presentation/screens/auth_screens/register_screen.dart';
import 'package:webapp/presentation/screens/home.dart';
import 'package:webapp/presentation/widgets/custom_text_feild.dart';

import '../../../const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final GlobalKey<FormState> myKey = GlobalKey<FormState>();

  /// التحقق من البريد الإلكتروني
  String? emailValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value.trim())) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  /// التحقق من كلمة المرور
  String? passwordValidator(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  /// استدعاء تسجيل الدخول مع التحقق
  void handleLogin() {
    if (myKey.currentState?.validate() ?? false) {
      BlocProvider.of<LoginCubit>(context).login(
        emailController.text.trim(),
        passwordController.text.trim(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          setState(() {
            myToken = state.token;
          });
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => const Home(),
            ),
          );
        } else if (state is LoginFail) {
          Navigator.of(context).pop();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              backgroundColor: const Color.fromARGB(255, 146, 100, 239),
              content: Text(
                state.errmsg,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          );
        } else if (state is LoginLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: Row(
          children: [
            if (kIsWeb)
              Image.asset(
                'images/1.jpg',
              ),
            Expanded(
              child: Container(
                padding: const EdgeInsets.all(8),
                child: Form(
                  key: myKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Text(
                          "Login",
                          style: TextStyle(
                              color: Color.fromARGB(255, 176, 138, 190),
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.2),
                        CustomTextFeild(
                          validator: emailValidator,
                          controller: emailController,
                          iconData: Icons.email,
                          text: "Email",
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03),
                        CustomTextFeild(
                          validator: passwordValidator,
                          controller: passwordController,
                          iconData: Icons.lock,
                          text: "Password",
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.07),
                        Container(
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(
                              Radius.circular(
                                50,
                              ),
                            ),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 176, 138, 190),
                            onPressed: handleLogin,
                            child: const Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 25,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.02),
                        InkWell(
                          onTap: () {
                            Navigator.of(context).pushReplacement(
                              MaterialPageRoute(
                                builder: (context) => BlocProvider(
                                  create: (context) => AuthBloc(),
                                  child: const RegisterScreen(),
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            "don't have an account ? register",
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
