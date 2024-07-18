// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
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
        return windows;
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
    apiKey: 'AIzaSyDlZeoFnQDhXvPNFTOpDQRodi7mB7-Mbo0',
    appId: '1:656651651643:web:ae55737101344354b3ea1e',
    messagingSenderId: '656651651643',
    projectId: 'flutter-auth-tutorial-aaace',
    authDomain: 'flutter-auth-tutorial-aaace.firebaseapp.com',
    storageBucket: 'flutter-auth-tutorial-aaace.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBILhTGiVXFpi1D5uBb3qRY7lTU4hbAJo0',
    appId: '1:656651651643:android:a6da7bdc49ee3cb8b3ea1e',
    messagingSenderId: '656651651643',
    projectId: 'flutter-auth-tutorial-aaace',
    storageBucket: 'flutter-auth-tutorial-aaace.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAMIo5VAdJ3zAeTNmBn_cSLO6Feibo0Uig',
    appId: '1:656651651643:ios:ee11458b60d4b6f6b3ea1e',
    messagingSenderId: '656651651643',
    projectId: 'flutter-auth-tutorial-aaace',
    storageBucket: 'flutter-auth-tutorial-aaace.appspot.com',
    iosBundleId: 'com.example.authTest',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAMIo5VAdJ3zAeTNmBn_cSLO6Feibo0Uig',
    appId: '1:656651651643:ios:ee11458b60d4b6f6b3ea1e',
    messagingSenderId: '656651651643',
    projectId: 'flutter-auth-tutorial-aaace',
    storageBucket: 'flutter-auth-tutorial-aaace.appspot.com',
    iosBundleId: 'com.example.authTest',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDlZeoFnQDhXvPNFTOpDQRodi7mB7-Mbo0',
    appId: '1:656651651643:web:45f1265209774bcfb3ea1e',
    messagingSenderId: '656651651643',
    projectId: 'flutter-auth-tutorial-aaace',
    authDomain: 'flutter-auth-tutorial-aaace.firebaseapp.com',
    storageBucket: 'flutter-auth-tutorial-aaace.appspot.com',
  );
}
