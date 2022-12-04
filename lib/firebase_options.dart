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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for android - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.iOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for ios - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDx9bh08H5nSZqHQSNAm9zjpnHCYPfd2mI',
    appId: '1:336327040934:web:2d84e0efb2621fc9d7b967',
    messagingSenderId: '336327040934',
    projectId: 'whatsapp-clone-backend-f95ee',
    authDomain: 'whatsapp-clone-backend-f95ee.firebaseapp.com',
    storageBucket: 'whatsapp-clone-backend-f95ee.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyDFY-hTuhH50nhHNmVyFYn8F2iz4P89xJ8',
    appId: '1:336327040934:ios:33e7a400ebaa8f7dd7b967',
    messagingSenderId: '336327040934',
    projectId: 'whatsapp-clone-backend-f95ee',
    storageBucket: 'whatsapp-clone-backend-f95ee.appspot.com',
    iosClientId: '336327040934-elbeh4hcbjqdp7lvti5i61iu82jq7c4t.apps.googleusercontent.com',
    iosBundleId: 'com.example.whatsappClone',
  );
}
