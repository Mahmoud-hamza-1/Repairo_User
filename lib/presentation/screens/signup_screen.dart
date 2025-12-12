import 'package:repairo_app_new/presentation/widgets/login_form.dart';
import 'package:repairo_app_new/presentation/widgets/signup_form.dart';
import 'package:flutter/material.dart';

class SignupScreen extends StatelessWidget {
  const SignupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: SignupForm());
  }
}
