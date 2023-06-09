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
    apiKey: 'AIzaSyAX8H22E5UfT4TrgR6rGqpo3w9KXfLXhuU',
    appId: '1:417701020381:android:803c40bcfe7adfb28b1134',
    messagingSenderId: '417701020381',
    projectId: 'hare-krishna-golden-temp-b1785',
    storageBucket: 'hare-krishna-golden-temp-b1785.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCuPxMmmt_gcP8_9KuJQfxHoy8njV1orss',
    appId: '1:417701020381:ios:59b22ef7e01ef1c28b1134',
    messagingSenderId: '417701020381',
    projectId: 'hare-krishna-golden-temp-b1785',
    storageBucket: 'hare-krishna-golden-temp-b1785.appspot.com',
    androidClientId: '417701020381-v5fqc0ok8aii79ehbthh87l3hepetd0v.apps.googleusercontent.com',
    iosClientId: '417701020381-g37ubj0fo7d4cvve3ej7vtl1e00kkcc3.apps.googleusercontent.com',
    iosBundleId: 'com.hkmhyderabad.harekrishnagoldentemple',
  );
}
