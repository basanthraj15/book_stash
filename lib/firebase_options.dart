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
    apiKey: 'AIzaSyB0mnEBhjTH_h5I4vrx3BYXd7-Ijr-yptg',
    appId: '1:47484564757:web:e0c81b71a08a8b392de51c',
    messagingSenderId: '47484564757',
    projectId: 'mybookstash-3ff6c',
    authDomain: 'mybookstash-3ff6c.firebaseapp.com',
    storageBucket: 'mybookstash-3ff6c.appspot.com',
    measurementId: 'G-N80RDR8WRG',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB0_FALFmHo7qwrxL-x5nNv-7m6aLHkGIA',
    appId: '1:47484564757:android:d7efcbe071b7c4ff2de51c',
    messagingSenderId: '47484564757',
    projectId: 'mybookstash-3ff6c',
    storageBucket: 'mybookstash-3ff6c.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyDIfqBHx5w3qV7LQ1YMDDYNGxZDcsxcilc',
    appId: '1:47484564757:ios:1208849100cecd2f2de51c',
    messagingSenderId: '47484564757',
    projectId: 'mybookstash-3ff6c',
    storageBucket: 'mybookstash-3ff6c.appspot.com',
    iosBundleId: 'com.example.bookStash',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDIfqBHx5w3qV7LQ1YMDDYNGxZDcsxcilc',
    appId: '1:47484564757:ios:1208849100cecd2f2de51c',
    messagingSenderId: '47484564757',
    projectId: 'mybookstash-3ff6c',
    storageBucket: 'mybookstash-3ff6c.appspot.com',
    iosBundleId: 'com.example.bookStash',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyB0mnEBhjTH_h5I4vrx3BYXd7-Ijr-yptg',
    appId: '1:47484564757:web:89561f39638de1aa2de51c',
    messagingSenderId: '47484564757',
    projectId: 'mybookstash-3ff6c',
    authDomain: 'mybookstash-3ff6c.firebaseapp.com',
    storageBucket: 'mybookstash-3ff6c.appspot.com',
    measurementId: 'G-SKYFM1CPJ9',
  );
}
