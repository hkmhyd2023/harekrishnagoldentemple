import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:harekrishnagoldentemple/Bottom_Navigation/Bottom_Navigation.dart';
import 'package:harekrishnagoldentemple/Home/controller/carousel_controller.dart';
import 'package:harekrishnagoldentemple/Login/Login.dart';
import 'package:harekrishnagoldentemple/NoInternet.dart';
import 'package:harekrishnagoldentemple/Notifications.dart';
import 'package:harekrishnagoldentemple/Settings/EditProfile.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:no_context_navigation/no_context_navigation.dart';
 
void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
FirebaseMessaging.instance.getToken().then((value) {
  String? token = value;
  print (token);
});

Get.put(CarouselController());
      runApp(const MyApp());
  }
  
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message: ${message.messageId}');
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    if (FirebaseAuth.instance.currentUser == null) {
      return MaterialApp(
        
        title: 'Hare Krishna Golden Temple',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/notifications':
            return MaterialPageRoute(builder: (_) => const Notifications());

          default:
            return null;
        }
      },
        theme: ThemeData(
          primarySwatch: Colors.orange,
        ),
        home: LogIn(),
      );
    } else {
      return MaterialApp(
        title: 'Hare Krishna Golden Temple',
        debugShowCheckedModeBanner: false,
        navigatorKey: NavigationService.navigationKey,
      onGenerateRoute: (RouteSettings settings) {
        switch (settings.name) {
          case '/notifications':
            return MaterialPageRoute(builder: (_) => const Notifications());

          default:
            return null;
        }
      },
        theme: ThemeData(
          primarySwatch: Colors.deepOrange,
        ),
        home: NaviBottomNavBar(),
      );
    }
  }
}
