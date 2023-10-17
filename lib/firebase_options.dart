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
    apiKey: 'AIzaSyAp90lgO9yYGGKluswEboXBrPWuQE4Nyfg',
    appId: '1:85478361501:web:d0b510e361549015148774',
    messagingSenderId: '85478361501',
    projectId: 'breakout-revival',
    authDomain: 'breakout-revival.firebaseapp.com',
    storageBucket: 'breakout-revival.appspot.com',
    measurementId: 'G-KSBW0SSWNF',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCvXSuswE9ixrZD1c4ahGi0gZsHWv5RRq8',
    appId: '1:85478361501:android:385935c02605c06f148774',
    messagingSenderId: '85478361501',
    projectId: 'breakout-revival',
    storageBucket: 'breakout-revival.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCViD1nZuXrLqHthEMiiR0i-14AA22iUNM',
    appId: '1:85478361501:ios:cca8264b6de8dbad148774',
    messagingSenderId: '85478361501',
    projectId: 'breakout-revival',
    storageBucket: 'breakout-revival.appspot.com',
    iosBundleId: 'com.example.breakoutRevival',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCViD1nZuXrLqHthEMiiR0i-14AA22iUNM',
    appId: '1:85478361501:ios:fb4bba7b24d08fe4148774',
    messagingSenderId: '85478361501',
    projectId: 'breakout-revival',
    storageBucket: 'breakout-revival.appspot.com',
    iosBundleId: 'com.example.breakoutRevival.RunnerTests',
  );
}