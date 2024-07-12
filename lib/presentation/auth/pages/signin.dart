import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:spotify_clone/common/widgets/appbar/app_bar.dart';
import 'package:spotify_clone/common/widgets/button/basic_app_button.dart';
import 'package:spotify_clone/core/config/assets/app_vectors.dart';
import 'package:spotify_clone/core/config/theme/app_colors.dart';
import 'package:spotify_clone/presentation/auth/pages/signup.dart';

class SigninPage extends StatelessWidget {
  const SigninPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30),
        child: _signupText(
          context,
          "Not A Member?",
          "Register Now",
          const Color(0xff288CE9),
          () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => const SignupPage(),
              ),
            );
          },
        ),
      ),
      appBar: BasicAppbar(
        title: SvgPicture.asset(
          AppVectors.logo,
          height: 40,
          width: 40,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _registerText(),
            const SizedBox(height: 22),
            _signupText(
              context,
              "If You Need Any Support",
              "Click Here",
              AppColors.primary,
              () {},
            ),
            const SizedBox(height: 38),
            _emailField(context),
            const SizedBox(height: 16),
            _passwordField(context),
            const SizedBox(height: 33),
            BasicAppButton(
              onPressed: () {},
              title: "Sign In",
            ),
          ],
        ),
      ),
    );
  }

  Widget _registerText() {
    return const Text(
      "Sign In",
      style: TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 25,
      ),
      textAlign: TextAlign.center,
    );
  }

  Widget _emailField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Enter Username or Email",
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _passwordField(BuildContext context) {
    return TextField(
      decoration: const InputDecoration(
        hintText: "Password",
      ).applyDefaults(
        Theme.of(context).inputDecorationTheme,
      ),
    );
  }

  Widget _signupText(BuildContext context, String textTitle, String buttonTitle,
      Color textColor, VoidCallback onPressed) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textTitle,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 4),
        TextButton(
          onPressed: onPressed,
          style: ButtonStyle(
            padding: WidgetStateProperty.all<EdgeInsets>(EdgeInsets.zero),
            minimumSize: WidgetStateProperty.all<Size>(Size.zero),
          ),
          child: Text(
            buttonTitle,
            style: TextStyle(
              color: textColor,
            ),
          ),
        ),
      ],
    );
  }
}
