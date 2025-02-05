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
    apiKey: 'AIzaSyAo2k4Kd02VHNd_h0ZfBxcNGYn1YoJjsp4',
    appId: '1:1099496854876:web:7412a403b2cc8b2b5c1d99',
    messagingSenderId: '1099496854876',
    projectId: 'chc-aesthetics',
    authDomain: 'chc-aesthetics.firebaseapp.com',
    storageBucket: 'chc-aesthetics.firebasestorage.app',
    measurementId: 'G-FEBHN3J8GJ',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAf8znk8fKNR-om3cyMD4sjKfYtb4qdcCU',
    appId: '1:1099496854876:android:2dc9bf22c42abb1e5c1d99',
    messagingSenderId: '1099496854876',
    projectId: 'chc-aesthetics',
    storageBucket: 'chc-aesthetics.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBOfV9Gkcko_7Xc1-U6gZ1q1_0vExhlmk4',
    appId: '1:1099496854876:ios:d2cd744ad71eccbe5c1d99',
    messagingSenderId: '1099496854876',
    projectId: 'chc-aesthetics',
    storageBucket: 'chc-aesthetics.firebasestorage.app',
    iosBundleId: 'com.example.chcAesthetics',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBOfV9Gkcko_7Xc1-U6gZ1q1_0vExhlmk4',
    appId: '1:1099496854876:ios:d2cd744ad71eccbe5c1d99',
    messagingSenderId: '1099496854876',
    projectId: 'chc-aesthetics',
    storageBucket: 'chc-aesthetics.firebasestorage.app',
    iosBundleId: 'com.example.chcAesthetics',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAo2k4Kd02VHNd_h0ZfBxcNGYn1YoJjsp4',
    appId: '1:1099496854876:web:6ae8fbf9da5543665c1d99',
    messagingSenderId: '1099496854876',
    projectId: 'chc-aesthetics',
    authDomain: 'chc-aesthetics.firebaseapp.com',
    storageBucket: 'chc-aesthetics.firebasestorage.app',
    measurementId: 'G-PPV1LVFJ24',
  );
}
