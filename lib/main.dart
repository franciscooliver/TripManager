import 'package:flutter/material.dart';
import 'package:checked_list/router/route_generator.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primaryColor: Colors.green,
        fontFamily: 'Google'
      ),
     initialRoute: '/',
     onGenerateRoute: RouteGenerator.generateRoute,
    );
  }
}
