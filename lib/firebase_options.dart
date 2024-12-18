// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
import 'package:firebase_core/firebase_core.dart';

// ...


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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyC02DEd0_uuaV5V3fwxaxeOL1IdLKd1plI',
    appId: '1:367264806367:web:6a4501b279482fcd01806a',
    messagingSenderId: '367264806367',
    projectId: 'testeflutter-4c7c0',
    authDomain: 'testeflutter-4c7c0.firebaseapp.com',
    storageBucket: 'testeflutter-4c7c0.appspot.com',
    measurementId: 'G-DL5G65J8BM',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDlg0pXTX-4hqwjtwz5vxVwCkIc6YEExf8',
    appId: '1:367264806367:android:95e125960670b32c01806a',
    messagingSenderId: '367264806367',
    projectId: 'testeflutter-4c7c0',
    storageBucket: 'testeflutter-4c7c0.appspot.com',
  );
}

