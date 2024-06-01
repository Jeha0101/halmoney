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
    apiKey: 'AIzaSyD1N3zYHxTGL-YekrarKNPSKKR0B-hSTGA',
    appId: '1:687960876390:web:360c1ae0c4280ef95c14a7',
    messagingSenderId: '687960876390',
    projectId: 'halmoney20-398d5',
    authDomain: 'halmoney20-398d5.firebaseapp.com',
    storageBucket: 'halmoney20-398d5.appspot.com',
    measurementId: 'G-YP3LJ7BQFP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCG9yaBdCiZVbe4L-IsJTpjtSIa3hI64Ls',
    appId: '1:687960876390:android:6f4dc9a2e82013615c14a7',
    messagingSenderId: '687960876390',
    projectId: 'halmoney20-398d5',
    storageBucket: 'halmoney20-398d5.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB202xflfrIyJMIUSMdl6kc6YEwiWwItv4',
    appId: '1:687960876390:ios:30e20cb3c0d5694e5c14a7',
    messagingSenderId: '687960876390',
    projectId: 'halmoney20-398d5',
    storageBucket: 'halmoney20-398d5.appspot.com',
    iosBundleId: 'com.example.halmoney',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyB202xflfrIyJMIUSMdl6kc6YEwiWwItv4',
    appId: '1:687960876390:ios:30e20cb3c0d5694e5c14a7',
    messagingSenderId: '687960876390',
    projectId: 'halmoney20-398d5',
    storageBucket: 'halmoney20-398d5.appspot.com',
    iosBundleId: 'com.example.halmoney',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyD1N3zYHxTGL-YekrarKNPSKKR0B-hSTGA',
    appId: '1:687960876390:web:bbec70567495fbf85c14a7',
    messagingSenderId: '687960876390',
    projectId: 'halmoney20-398d5',
    authDomain: 'halmoney20-398d5.firebaseapp.com',
    storageBucket: 'halmoney20-398d5.appspot.com',
    measurementId: 'G-XV6HG5Y36J',
  );
}
