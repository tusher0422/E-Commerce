import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';

import 'package:get/get.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:firebase_core/firebase_core.dart';

import 'controller/login_controller.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);


  if (!kIsWeb) {

    Stripe.publishableKey = 'pk_test_51Rs7RvBrOUWOP0BOqG8REJmK2VsG5dMxm2E42jlz2xtlsUtNWbcwqSYvyM8AmjZ0aHLI1OjxSNWyWaPt6HbwkdAl00pLAa6Op7';
  }
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final loginController = Get.put(LoginController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Simple E-Commerce',
      builder: EasyLoading.init(),
      home: LoginScreen(),
    );
  }
}

class LoginScreen extends StatelessWidget {
  final loginController = Get.find<LoginController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Login')),
      body: Center(
        child: ElevatedButton.icon(
          icon: Icon(Icons.login),
          label: Text('Sign in with Google'),
          onPressed: () {
            loginController.signInWithGoogle();
          },
        ),
      ),
    );
  }
}
