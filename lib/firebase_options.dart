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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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
    apiKey: 'AIzaSyD7M56TjLPlsU1z2hcoGpi3awJ3Nz2TsDs',
    appId: '1:930853569454:android:14ad6b0a5626be239efe3f',
    messagingSenderId: '930853569454',
    projectId: 'electronicsrent-aa920',
    storageBucket: 'electronicsrent-aa920.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCg1CF4Gr4J0lXayuPrWVhi5Zx_MZc8tmI',
    appId: '1:930853569454:ios:98674e45d1df36189efe3f',
    messagingSenderId: '930853569454',
    projectId: 'electronicsrent-aa920',
    storageBucket: 'electronicsrent-aa920.appspot.com',
    androidClientId: '930853569454-ageqtg0ek7k0eromhlojtov2tdcd7c6b.apps.googleusercontent.com',
    iosClientId: '930853569454-qvvshrlv03kqg3c82a4pab4m0tia2pj9.apps.googleusercontent.com',
    iosBundleId: 'com.example.electronicsrent',
  );

}