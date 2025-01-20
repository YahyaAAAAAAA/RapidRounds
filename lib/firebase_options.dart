// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;
import 'package:flutter_dotenv/flutter_dotenv.dart';

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

  static FirebaseOptions web = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_WEB')}',
    appId: '1:347374153394:web:88b5fe803007a2715ea3ab',
    messagingSenderId: '347374153394',
    projectId: 'rapidrounds-65d29',
    authDomain: 'rapidrounds-65d29.firebaseapp.com',
    storageBucket: 'rapidrounds-65d29.firebasestorage.app',
    measurementId: 'G-TRNEWWKYHN',
  );

  static FirebaseOptions android = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_ANDROID')}',
    appId: '1:347374153394:android:3a4e1566e024a7485ea3ab',
    messagingSenderId: '347374153394',
    projectId: 'rapidrounds-65d29',
    storageBucket: 'rapidrounds-65d29.firebasestorage.app',
  );

  static FirebaseOptions ios = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_IOS')}',
    appId: '1:347374153394:ios:d416112b20f947b05ea3ab',
    messagingSenderId: '347374153394',
    projectId: 'rapidrounds-65d29',
    storageBucket: 'rapidrounds-65d29.firebasestorage.app',
    iosBundleId: 'com.example.rapidRounds',
  );

  static FirebaseOptions macos = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_IOS')}',
    appId: '1:347374153394:ios:d416112b20f947b05ea3ab',
    messagingSenderId: '347374153394',
    projectId: 'rapidrounds-65d29',
    storageBucket: 'rapidrounds-65d29.firebasestorage.app',
    iosBundleId: 'com.example.rapidRounds',
  );

  static FirebaseOptions windows = FirebaseOptions(
    apiKey: '${dotenv.get('APIKEY_WIND')}',
    appId: '1:347374153394:web:2de13393720a82bd5ea3ab',
    messagingSenderId: '347374153394',
    projectId: 'rapidrounds-65d29',
    authDomain: 'rapidrounds-65d29.firebaseapp.com',
    storageBucket: 'rapidrounds-65d29.firebasestorage.app',
    measurementId: 'G-ZK9LFPT68F',
  );
}
