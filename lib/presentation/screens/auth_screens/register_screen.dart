import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/blocs/auth_bloc/auth_bloc.dart';
import 'package:webapp/presentation/screens/auth_screens/login_screen.dart';
import 'package:webapp/presentation/screens/home.dart';
import 'package:webapp/presentation/widgets/custom_text_feild.dart';

import '../../../const.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => RegisterScreenState();
}

class RegisterScreenState extends State<RegisterScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  // Validators
  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
    }
    return null;
  }

  String? nameValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your name';
    }
    return null;
  }

  String? passwordValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your password';
    }
    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthSuccess) {
          setState(() {
            myToken = state.token;
          });
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const Home()),
          );
        } else if (state is AuthFail) {
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
        } else if (state is AuthLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        print(state);
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
                          "Register",
                          style: TextStyle(
                              color: Color.fromARGB(255, 176, 138, 190),
                              fontWeight: FontWeight.bold,
                              fontSize: 40),
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.2),
                        CustomTextFeild(
                          validator: nameValidator,
                          controller: nameController,
                          iconData: Icons.person,
                          text: "Name",
                        ),
                        SizedBox(
                            height: MediaQuery.sizeOf(context).height * 0.03),
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
                              Radius.circular(50),
                            ),
                          ),
                          width: MediaQuery.sizeOf(context).width * 0.2,
                          child: MaterialButton(
                            color: const Color.fromARGB(255, 176, 138, 190),
                            onPressed: () async {
                              // Check if form is valid
                              if (myKey.currentState?.validate() ?? false) {
                                // String message = await RegisterServices()
                                //     .register(
                                //         nameController.text,
                                //         passwordController.text,
                                //         emailController.text);
                                // if (!message.contains('Error')) {
                                //   setState(() {
                                //     myToken = message;
                                //   });
                                //   Navigator.of(context).push(
                                //     MaterialPageRoute(
                                //         builder: (context) => const Home()),
                                //   );
                                // }
                                BlocProvider.of<AuthBloc>(context).add(
                                  RegisterEvent(
                                    email: emailController.text,
                                    password: passwordController.text,
                                    name: nameController.text,
                                  ),
                                );
                              }
                            },
                            child: const Text(
                              "Register",
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
                                builder: (context) => const LoginScreen(),
                              ),
                            );
                          },
                          child: const Text(
                            "Already have an account? Login",
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
