import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:unitrade_website/authentication/authenticate.dart';
import 'package:unitrade_website/authentication/sign_in.dart';
import 'package:unitrade_website/models/users.dart';
import 'package:unitrade_website/screens/company/photo_gallery_form.dart';
import 'package:unitrade_website/screens/home.dart';
import 'package:unitrade_website/services/auth.dart';
import 'shared/string.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Users>.value(
      value: AuthServices().user,
      child: MaterialApp(
        title: MAIN_TITLE,
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primaryColor: Colors.brown,
          accentColor: Colors.amberAccent,
        ),
        routes: {
          '/home': (context) => Authentication(),
          '/add_photo': (context) => PhotoGalleryForm(),
          '/sign_in': (context) => SignIn(),
        },
        home: MyHomePage(title: HOME_TITLE),
      ),
    );
  }
}
