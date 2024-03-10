// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCoHAEKN0N-WLAqiY5b6vP-zHWDgfjsXlM',
    appId: '1:907368680143:web:3906814e385097e04d45ba',
    messagingSenderId: '907368680143',
    projectId: 'lipread-1e487',
    authDomain: 'lipread-1e487.firebaseapp.com',
    storageBucket: 'lipread-1e487.appspot.com',
    measurementId: 'G-RWE01LX43B',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDm57jeOXpjLIpt_75cULu1_jDMgCusXak',
    appId: '1:907368680143:android:40c0514253e398954d45ba',
    messagingSenderId: '907368680143',
    projectId: 'lipread-1e487',
    storageBucket: 'lipread-1e487.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD3zvtXA3UVAwQZRoaeew8BG6LOU5UgH3o',
    appId: '1:907368680143:ios:46a440b74ca8853f4d45ba',
    messagingSenderId: '907368680143',
    projectId: 'lipread-1e487',
    storageBucket: 'lipread-1e487.appspot.com',
    iosBundleId: 'com.example.lipread',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD3zvtXA3UVAwQZRoaeew8BG6LOU5UgH3o',
    appId: '1:907368680143:ios:550586ccce3b7d8b4d45ba',
    messagingSenderId: '907368680143',
    projectId: 'lipread-1e487',
    storageBucket: 'lipread-1e487.appspot.com',
    iosBundleId: 'com.example.lipread.RunnerTests',
  );
}
