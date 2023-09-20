import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/firebase_options.dart';
import 'package:flutter_application_1/screens/navigation_side_screen/navigation_home_screen.dart';
import 'package:flutter_application_1/screens/log_in/login_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var auth = FirebaseAuth.instance;

    // return FutureBuilder(
    //     future: _initialization,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasError) {
    //         print('something went wrong');
    //       }
    //       if (snapshot.connectionState == ConnectionState.done) ;
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: HomeScreen()
        // StreamBuilder(
        //     stream: auth.authStateChanges(),
        //     builder: (context, usersnapshot) {
        //       if (usersnapshot.hasData) {
        //         return const HomeScreen();
        //       } else {
        //         return const Login();
        //       }
        //     }),
        );
  }
}
