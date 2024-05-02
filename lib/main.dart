import 'package:didon/constants.dart';
import 'package:didon/signup.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyBNLx7odpLznHP-KxHYtyLw7H32-4MgUuU",
          projectId: "didon-b2dc3",
          messagingSenderId: "290203050551",
          appId: "1:290203050551:web:1ee9116a439b09b3ddd5b2"));

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Didon',
      theme: ThemeData(
        primaryColor: Color.fromARGB(255, 81, 45, 10),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        textTheme: GoogleFonts.secularOneTextTheme(),
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Option selectedOption = Option.LogIn;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Scaffold(
      body: Stack(
        children: [
          // Background Image with Opacity
          Opacity(
            opacity: 1.0,
            child: Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/bg.jpg'),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),

          // Content Stack
          Container(
            width: size.width,
            height: size.height,
            child: Stack(
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Image.asset(
                      'assets/images/lg.png',
                      width: 200,
                      height: 200,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.centerLeft,
                  child: Padding(
                    padding: EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Bienvenue à Didon",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          "Un magasin spécialisé dédié à l'art \n de la table et de la décoration!",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                // Additional Widgets Here...
                AnimatedSwitcher(
                  duration: Duration(milliseconds: 500),
                  transitionBuilder: (widget, animation) => ScaleTransition(
                    child: widget,
                    scale: animation,
                  ),
                  child: SignUp(
                    onLogInSelected: () {
                      setState(() {
                        selectedOption = Option.LogIn;
                      });
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
