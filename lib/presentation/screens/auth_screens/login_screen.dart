import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webapp/cubits/login_cubit/login_cubit.dart';
import 'package:webapp/presentation/screens/home.dart';
import 'package:webapp/presentation/widgets/custom_text_feild.dart';

import '../../../const.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  FocusNode emailFocusNode = FocusNode();
  FocusNode passwordFocusNode = FocusNode();
  GlobalKey<FormState> myKey = GlobalKey<FormState>();

  String? emailValidator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter your email';
    }
    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(value)) {
      return 'Please enter a valid email';
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
    return BlocConsumer<LoginCubit, LoginState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          setState(
            () {
              myToken = state.token;
            },
          );
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
                            onPressed: () {
                              BlocProvider.of<LoginCubit>(context).login(
                                emailController.text,
                                passwordController.text,
                              );
                            },
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
                        const Text(
                          "don't have an account ? register",
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
    // return BlocConsumer<LoginCubit, LoginState>(
    //   builder: (context, state) {
    //     return Home(
    //       appBarTitle: "",
    //       appBarActions: const Text(""),
    //       body: SizedBox(
    //         height: MediaQuery.of(context).size.height,
    //         child: Form(
    //           key: myKey,
    //           child: SingleChildScrollView(
    //             child: Column(
    //               children: [
    //                 const Text(
    //                   'Baader',
    //                   style: TextStyle(
    //                     fontSize: 50,
    //                     fontWeight: FontWeight.bold,
    //                     color: Colors.white,
    //                   ),
    //                 ),
    //                 SizedBox(
    //                   height: MediaQuery.of(context).size.height * 0.1,
    //                 ),
    //                 CustomContainar(
    //                   child: SingleChildScrollView(
    //                     child: Column(
    //                       children: [
    //                         const Text(
    //                           'Login',
    //                           style: TextStyle(
    //                             fontSize: 50,
    //                             fontWeight: FontWeight.bold,
    //                             color: Colors.white,
    //                           ),
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height * 0.01,
    //                         ),
    //                         CustomTextField(
    //                           icon: const Icon(
    //                             Icons.email,
    //                             color: Colors.white,
    //                           ),
    //                           myController: emailController,
    //                           hintText: "Enter Your Email",
    //                           labelText: "email",
    //                           validator: emailValidator,
    //                           focusNode: emailFocusNode,
    //                           textInputAction: TextInputAction.next,
    //                           onEditingComplete: () {
    //                             FocusScope.of(context)
    //                                 .requestFocus(passwordFocusNode);
    //                           },
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height * 0.02,
    //                         ),
    //                         CustomTextField(
    //                           icon: const Icon(
    //                             Icons.lock,
    //                             color: Colors.white,
    //                           ),
    //                           myController: passwordController,
    //                           hintText: "Enter Your Password",
    //                           labelText: "password",
    //                           validator: passwordValidator,
    //                           focusNode: passwordFocusNode,
    //                           textInputAction: TextInputAction.done,
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height * 0.03,
    //                         ),
    //                         CustomMaterialButton(
    //                           text: "Login",
    //                           onPressed: () {
    //                             if (myKey.currentState?.validate() ?? false) {
    //                               BlocProvider.of<LoginCubit>(context)
    //                                   .loginCubit(emailController.text,
    //                                       passwordController.text);
    //                             }
    //                           },
    //                         ),
    //                         SizedBox(
    //                           height: MediaQuery.of(context).size.height * 0.01,
    //                         ),
    //                         Row(
    //                           mainAxisAlignment: MainAxisAlignment.center,
    //                           children: [
    //                             const Text(
    //                               "Don't have an account? ",
    //                               style: TextStyle(
    //                                 color: Colors.white,
    //                               ),
    //                             ),
    //                             InkWell(
    //                               onTap: () {
    //                                 Navigator.of(context).push(
    //                                   MaterialPageRoute(
    //                                     builder: (context) =>
    //                                         const RegisterScreen(),
    //                                   ),
    //                                 );
    //                               },
    //                               child: const Text(
    //                                 "Register",
    //                                 style: TextStyle(
    //                                   color: Colors.white,
    //                                 ),
    //                               ),
    //                             ),
    //                           ],
    //                         ),
    //                       ],
    //                     ),
    //                   ),
    //                 ),
    //               ],
    //             ),
    //           ),
    //         ),
    //       ),
    //     );
    //   },
    // );
  }
}
