import 'package:ecommorce/themes/theme.dart';
import 'package:ecommorce/ui/home/home_page.dart';
import 'package:ecommorce/ui/login/loginpage.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.lightTheme.copyWith(
        textTheme: GoogleFonts.muliTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      routes: <String, WidgetBuilder>{
        '/login': (context) => Login(),
        '/home': (context) => Home(),
      },
      initialRoute: '/login',
      title: 'Ecommerce Test',
    );
  }
}
