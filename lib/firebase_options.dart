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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBPvu6aqFVPNmlTWIkQj8IYo_kzdfz6d4k',
    appId: '1:189901341773:android:2c68b3a328ab7179ab8804',
    messagingSenderId: '189901341773',
    projectId: 'todolist-8c843',
    storageBucket: 'todolist-8c843.firebasestorage.app',
  );

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyABG-eoXXQz2HKW97rYUPpgGDnbsMZDuAQ',
    appId: '1:189901341773:web:f1802593173320a4ab8804',
    messagingSenderId: '189901341773',
    projectId: 'todolist-8c843',
    authDomain: 'todolist-8c843.firebaseapp.com',
    storageBucket: 'todolist-8c843.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD8ZXuF6nOTly3LLHwISydCqC_wUFWEWPY',
    appId: '1:189901341773:ios:742f8471305ce6dbab8804',
    messagingSenderId: '189901341773',
    projectId: 'todolist-8c843',
    storageBucket: 'todolist-8c843.firebasestorage.app',
    iosBundleId: 'com.kiettruong208.todo',
  );

}