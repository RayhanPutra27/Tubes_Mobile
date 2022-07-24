import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tubes_mobile/Views/home_page.dart';
import 'package:tubes_mobile/firebase_options.dart';
import 'package:tubes_mobile/Views/sign_in_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final SharedPreferences prefs;
  String? notificationText;

  // This widget is the root of your application.

  @override
  void initState() {
    super.initState();
    // messaging = FirebaseMessaging.instance;
    // messaging.getToken().then((value) => print("Tokenn: $value"));
    // FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    //   print("asdasd");
    //   LandingPage lp = LandingPage();
    //   Navigator.pushReplacement(
    //       context, MaterialPageRoute(builder: (context) => LandingPage()));
    // });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      // home: SigninPage(),
      // home: HomePage(),
      home: StreamBuilder<User?>(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return HomePage();
            } else {
              return SigninPage();
            }
          })
    );
  }
}
