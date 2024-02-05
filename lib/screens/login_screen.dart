import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/services/google_service.dart';
import 'package:lipread/services/login_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:lipread/utilities/font_type.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  void signInWithGoogle() async {
    final googleAccount = await GoogleService.signin();
    if (googleAccount != null) {
      final user = createUserWith(googleAccount);
      await LoginService.saveUser(user);
    }
  }

  UserModel createUserWith(GoogleSignInAccount googleAccount) {
    return UserModel(
      id: googleAccount.id,
      name: googleAccount.displayName ?? 'name',
      email: googleAccount.email,
    );
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
                    top: 60,
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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'LipRead',
                        style: TextStyle(
                          color: Colors.white,
                          fontFamily: 'bronova',
                          fontSize: 40,
                        ),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Text(
                        '나에게 필요한 대화로\n구화를 연습해요',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          height: 1.5,
                          fontVariations: [
                            FontVariation('wght', 500),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextButton(
                    onPressed: signInWithGoogle,
                    style: TextButton.styleFrom(
                      minimumSize: const Size(382, 56),
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      backgroundColor: AppColor.primaryColor,
                      foregroundColor: Colors.white,
                      disabledBackgroundColor: AppColor.grayScale.g200,
                      disabledForegroundColor: AppColor.grayScale.g400,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Google로 시작하기',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontVariations: [
                          FontVariation('wght', 700),
                        ],
                      ),
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
