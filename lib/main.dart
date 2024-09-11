import 'package:book_stash/Home.dart';
import 'package:book_stash/Services/auth_services.dart';
import 'package:book_stash/auth/ui/login_screen.dart';
import 'package:book_stash/auth/ui/signup_screen.dart';
import 'package:book_stash/firebase_options.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "BOOK STASH",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.amber,
        ),
        useMaterial3: true,
      ),
      routes: {
        "/": (context) => checkUserBookStash(),
        "/login": (context) => LoginScreen(),
        "/home": (context) => HomeScreen(),
        "/signup": (context) => SignupScreen(),
      },
    );
  }
}

class checkUserBookStash extends StatefulWidget {
  const checkUserBookStash({super.key});

  @override
  State<checkUserBookStash> createState() => _checkUserBookStashState();
}

class _checkUserBookStashState extends State<checkUserBookStash> {
  @override
  void initState() {
    AuthServicesHelper.isUserLoggedIn().then((value) {
      if (value) {
        Navigator.pushReplacementNamed(context, "/home");
      } else {
        Navigator.pushNamed(context, "/login");
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
