import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:loginsignup/screens/feed.dart';
import 'package:loginsignup/screens/manage_clubs.dart';
import 'package:loginsignup/screens/profile.dart';
import 'package:loginsignup/screens/signin.dart';
import 'package:loginsignup/screens/signin_admin.dart';
import 'package:loginsignup/screens/splash_screen.dart';
import 'package:loginsignup/screens/timeline.dart';
import 'package:loginsignup/services/authentication_service.dart';
import 'package:provider/provider.dart';
import 'layout/navigator.dart';
import 'screens/add_club.dart';
import 'screens/admin_homepage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'services/fire_store_services.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => Signin(),
  "/admin": (BuildContext context) => AdminHomePage(),
  "/create": (BuildContext context) => addClub(),
  "/manage": (BuildContext context) => ManageClubs(),
  "/feed": (BuildContext context) => Feed(),
  "/adminlogin": (BuildContext context) => SigninAdmin(),
  "/profile": (BuildContext context) => ClubProfile(),
  "/timeline": (BuildContext context) => Timeline(),
};
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  var _fbApp = await Firebase.initializeApp();
  runApp(myapp(_fbApp));
}

class myapp extends StatelessWidget {
  Future<FirebaseApp>? _fbApp = null;
  myapp(var _fbApp) {
    this._fbApp = _fbApp;
  }
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<AuthenticationService>(
          create: (_) => AuthenticationService(FirebaseAuth.instance),
        ),
        StreamProvider(
            create: (context) =>
                context.read<AuthenticationService>().authStateChanges,
            initialData: null)
      ],
      child: MaterialApp(
          theme: ThemeData(
              primaryColor: Colors.red, accentColor: Colors.yellowAccent),
          debugShowCheckedModeBanner: false,
          home: FutureBuilder(
            future: _fbApp,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                log('1');
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                log('2');
                log(snapshot.data.toString());
                return addClub();
              } else {
                log('3');
                return SplashScreen();
              }
            },
          ),
          routes: routes),
    );
  }
}
