import 'package:repairo_app_new/presentation/widgets/login_form.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  String? deviceToken;

  @override
  void initState() {
    super.initState();
    getToken();
  }

  void getToken() async {
    String? token = await FirebaseMessaging.instance.getToken();
    setState(() {
      deviceToken = token;
    });
    print("🔥 Device Token: $token");
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false, // يمنع تحريك العناصر عند ظهور
      body: LoginForm(),
    );
  }
}
