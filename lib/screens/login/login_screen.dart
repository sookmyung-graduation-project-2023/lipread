import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:lipread/components/base_alert_dialog.dart';
import 'package:lipread/models/user_model.dart';
import 'package:lipread/routes/routing_constants.dart';
import 'package:lipread/services/google_service.dart';
import 'package:lipread/services/login_service.dart';
import 'package:lipread/storage/secure_storage.dart';
import 'package:lipread/utilities/app_color_scheme.dart';
import 'package:permission_handler/permission_handler.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isLoggining = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _checkLoggedIn();
    });
  }

  void _checkLoggedIn() async {
    final isLogginedIn =
        await SecureStorage.storage.read(key: StorageKey.isLoggedIn);
    if (isLogginedIn == StorageValue.login) {
      _routeToHomeScreen();
    }
  }

  void _routeToHomeScreen() {
    Navigator.pushReplacementNamed(context, RoutesName.initialScreen);
  }

  void _handleLoginBtnPressed() async {
    final status = await _requestPermission();
    await _checkStatus(status);
  }

  Future<AuthorizationStatus> _requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;
    NotificationSettings settings = await messaging.requestPermission(
      alert: true, // 디바이스 알림
      badge: true, // 읽지 않은 알림 아이콘
      sound: true, // 소리 권한
    );
    debugPrint('[test] status: ${settings.authorizationStatus}');
    return settings.authorizationStatus;
  }

  Future<void> _checkStatus(AuthorizationStatus status) async {
    if (status == AuthorizationStatus.authorized ||
        status == AuthorizationStatus.provisional) {
      await _signInWithGoogle();
      _routeToHomeScreen();
    }
    if (status == AuthorizationStatus.denied) {
      _showPermissionAlertDialog();
    }
  }

  Future<void> _signInWithGoogle() async {
    final googleAccount = await GoogleService.signin();
    if (googleAccount != null) {
      setState(() {
        _isLoggining = true;
      });
      final user = await _createUserWith(googleAccount);
      await LoginService.saveUser(user);
    }
  }

  Future<UserModel> _createUserWith(GoogleSignInAccount googleAccount) async {
    return UserModel(
      id: googleAccount.id,
      name: googleAccount.displayName ?? '이름없음',
      email: googleAccount.email,
      deviceToken: await _getToken(),
    );
  }

  Future<String?> _getToken() async {
    final String? deviceToken = await FirebaseMessaging.instance.getToken();
    await SecureStorage.storage.write(
      key: StorageKey.deviceToken,
      value: deviceToken,
    );

    return deviceToken;
  }

  Future<BaseAlertDialog?> _showPermissionAlertDialog() {
    return showDialog<BaseAlertDialog>(
        context: context,
        builder: (context) {
          return BaseAlertDialog(
            title: '알림 권한 요청',
            description: '알림을 받으려면 알림 권한이 필요합니다.\n설정에서 알림 권한을 허용해주세요.',
            actions: [
              TextButton(
                onPressed: () async {
                  await openAppSettings();
                  Navigator.pop(context);
                },
                child: const Text('설정 열기'),
              ),
              const SizedBox(
                height: 4,
              ),
              TextButton(
                style: TextButton.styleFrom(
                    backgroundColor: Colors.transparent,
                    foregroundColor: AppColor.grayScale.g600),
                onPressed: () {
                  Navigator.pop(context); // 다이얼로그 닫기
                },
                child: const Text('취소'),
              ),
            ],
          );
        });
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
                        'LipRead.',
                        style: Theme.of(context).textTheme.displayMedium,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        '나에게 필요한 대화로\n구어를 연습해요',
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 60,
                  ),
                  TextButton(
                    style: TextButton.styleFrom(
                      disabledBackgroundColor: AppColor.primaryColor,
                      disabledForegroundColor: AppColor.primaryLightColor,
                    ),
                    onPressed: _isLoggining ? null : _handleLoginBtnPressed,
                    child: Text(
                      _isLoggining ? 'Google 로그인 중' : 'Google로 시작하기',
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
