import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:gap/gap.dart';
import 'package:imtihon_5/features/presentation/pages/home_page.dart';
import 'package:imtihon_5/features/presentation/pages/sign_up.dart';

import '../../assets/colors.dart';
import '../../assets/icons.dart';
import 'bloc/login_bloc.dart';

class LoginScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(
        builder: (_) => const LoginScreen(),
      );

  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool isLoginDataValid = false;
  final mailTextEditingController = TextEditingController();
  final passwordTextEditingController = TextEditingController();

  final mailFocusNode = FocusNode();
  final passwordFocusNode = FocusNode();

  final textFieldContentStyle = const TextStyle(
    color: textFieldColor,
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  final formKey = GlobalKey<FormState>();

  bool isObscure = true;

  InputDecoration decoration({
    required String hintText,
    Widget? suffixIcon,
  }) =>
      InputDecoration(
        hintText: hintText,
        suffixIcon: suffixIcon,
        contentPadding:
            const EdgeInsets.symmetric(horizontal: 12, vertical: 13.5),
        hintStyle: TextStyle(
          color: textFieldColor.withOpacity(.6),
          fontSize: 14,
          fontWeight: FontWeight.w400,
        ),
        fillColor: textFieldBackground,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorder.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorder.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: BorderSide(
            width: 1,
            color: textFieldBorder.withOpacity(.1),
            style: BorderStyle.solid,
          ),
        ),
      );

  @override
  void initState() {
    mailTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });

    passwordTextEditingController.addListener(() {
      if (formKey.currentState!.validate()) {
        if (!isLoginDataValid) {
          setState(() {
            isLoginDataValid = true;
          });
        }
      } else {
        if (isLoginDataValid) {
          setState(() {
            isLoginDataValid = false;
          });
        }
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    mailTextEditingController.dispose();
    passwordTextEditingController.dispose();
    mailFocusNode.dispose();
    passwordFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      resizeToAvoidBottomInset: false,
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () {
          if (FocusScope.of(context).hasFocus) {
            FocusScope.of(context).unfocus();
          }
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const Gap(67),
                SvgPicture.asset(AppIcons.logo),
                const Gap(44),
                TextFormField(
                  style: textFieldContentStyle,
                  cursorColor: cursorColor,
                  focusNode: mailFocusNode,
                  controller: mailTextEditingController,
                  decoration: decoration(hintText: 'Email'),
                  textInputAction: TextInputAction.next,
                  keyboardType: TextInputType.emailAddress,
                  onEditingComplete: () {
                    passwordFocusNode.requestFocus();
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, mail kiriting!';
                    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Iltimos, yaroqli mail manzilini kiriting';
                    }

                    return null;
                  },
                ),
                const Gap(16),
                TextFormField(
                  style: textFieldContentStyle,
                  cursorColor: cursorColor,
                  focusNode: passwordFocusNode,
                  controller: passwordTextEditingController,
                  decoration: decoration(
                    hintText: 'Password',
                    suffixIcon: GestureDetector(
                      onTap: () {
                        setState(() {
                          isObscure = !isObscure;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 13.5),
                        child: SvgPicture.asset(
                          isObscure ? AppIcons.eyeOff : AppIcons.eyeOn,
                        ),
                      ),
                    ),
                  ),
                  onEditingComplete: () {
                    // TODO: Login
                  },
                  textInputAction: TextInputAction.done,
                  keyboardType: TextInputType.visiblePassword,
                  obscureText: isObscure,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Iltimos, parolingizni kiriting!';
                    } else if (value.length < 7) {
                      return 'Parol eng kamida 8ta belgidan tashkil topgan bo\'lishi kerak';
                    }

                    return null;
                  },
                ),
                const Gap(12),
                Align(
                  alignment: Alignment.centerRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.of(context).pushNamed("/ForgotPassword");
                    },
                    child: const Text(
                      'Forgot password?',
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w400,
                        color: textButtonColor,
                      ),
                    ),
                  ),
                ),
                const Gap(16),
                ElevatedButton(
                    onPressed: () {
                      context
                          .read<AuthBloc>()
                          .add(AuthenticationLoginRequestedEvent(
                            email: mailTextEditingController.text.trim(),
                            password: passwordTextEditingController.text.trim(),
                            onSuccess: () {
                              Navigator.of(context).push(MaterialPageRoute(builder: (_) => HomePage()));
                            },
                            onFailure: (message) {
                              print(message);
                            },
                          ));
                    },
                    child: Text('Login')),
                const SizedBox(height: 56),
                const Row(
                  children: [
                    Expanded(child: Divider()),
                    Gap(6),
                    Text(
                      'OR',
                      style: TextStyle(
                        color: white,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Gap(5),
                    Expanded(child: Divider()),
                  ],
                ),
                const Gap(24),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ElevatedButton(
                        onPressed: () {},
                        child: SvgPicture.asset(AppIcons.facebook)),
                    const Gap(32),
                    ElevatedButton(
                        onPressed: () {},
                        child: SvgPicture.asset(AppIcons.google)),
                    const Gap(32),
                    ElevatedButton(
                        onPressed: () {},
                        child: SvgPicture.asset(AppIcons.apple)),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).padding.bottom + 18, right: 4),
            child: const Text(
              "Don’t have an account ?",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: white,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (_) => SignUp()));
            },
            child: Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).padding.bottom + 18),
              child: const Text(
                "Sign up",
                style: TextStyle(fontSize: 15, color: singUpTextColor),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
