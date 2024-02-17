import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/services/google_service.dart';
import 'package:lipread/services/login_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  Future<void> _signInWithGoogle() async {
    debugPrint('sign in with Google');
    final googleAccount = await GoogleService.signin();
    debugPrint('googleAccount: $googleAccount');

    if (googleAccount != null) {
      final user = _createUserWith(googleAccount);
      await LoginService.saveUser(user);
    }
  }

  UserModel _createUserWith(GoogleSignInAccount googleAccount) {
    return UserModel(
      id: googleAccount.id,
      name: googleAccount.displayName ?? 'name',
      email: googleAccount.email,
    );
  }

  void _routeToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grayScale.g900,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -60,
              left: 80,
              child: Stack(
                children: [
                  Positioned(
                    top: 120,
                    left: 40,
                    child: Container(
                      width: 400,
                      height: 400,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(120, 25, 121, 255),
                            Colors.transparent,
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                  ),
                  Image.asset(
                    'assets/images/img_video.png',
                    fit: BoxFit.contain,
                    width: 520,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'LipRead',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '나에게 필요한 대화로\n구화를 연습해요',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextButton(
                    onPressed: () async {
                      await _signInWithGoogle();
                      _routeToHomeScreen(context);
                    },
                    child: const Text(
                      'Google로 시작하기',
                    ),
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
