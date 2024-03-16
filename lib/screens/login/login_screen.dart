import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/screens/home/home_screen.dart';
import 'package:lipread/services/google_service.dart';
import 'package:lipread/services/login_service.dart';
import 'package:lipread/utilities/app_color_scheme.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _onloginBtnPressed = false;

  void _signInWithGoogle() async {
    debugPrint('sign in with Google');
    final googleAccount = await GoogleService.signin();
    debugPrint('googleAccount: $googleAccount');

    if (googleAccount != null) {
      final user = await _createUserWith(googleAccount);
      await LoginService.saveUser(user);
    }
  }

  Future<UserModel> _createUserWith(GoogleSignInAccount googleAccount) async {
    return UserModel(
      id: googleAccount.id,
      name: googleAccount.displayName ?? 'name',
      email: googleAccount.email,
      deviceToken: await _getToken(),
    );
  }

  Future<String?> _getToken() async {
    _requestPermission();
    return await FirebaseMessaging.instance.getToken();
  }

  void _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('no');
    }
  }

  void _routeToHomeScreen(BuildContext context) {
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => const HomeScreen()));
  }

  void _handleLoginBtnPressed() {
    _signInWithGoogle();
    _routeToHomeScreen(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColor.grayScale.g900,
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: -40,
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
                    onPressed: _onloginBtnPressed
                        ? null
                        : () {
                            setState(() {
                              _onloginBtnPressed = true;
                              _handleLoginBtnPressed();
                            });
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
