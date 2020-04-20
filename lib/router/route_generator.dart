import 'package:flutter/material.dart';
import 'package:checked_list/models/trip.dart';
import 'package:checked_list/pages/home_page.dart';
import 'package:checked_list/pages/trip_details.dart/trip_details.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    //Pegando os argumentos passados ao chamar o Navigator.pushNamed
    final args = settings.arguments;

    switch (settings.name) {
      case '/':
        return MaterialPageRoute(builder: (_) => HomePage());
      case '/tripDetails':
        if (args is Trip) {
          return MaterialPageRoute(
            builder: (_) => TripDetails(trip: args),
          );
        }

        return _errorRoute();

      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) => 
      Scaffold(
        appBar: AppBar(
          title: Text("Error"),
        ),
        body: Center(
          child: Text("ERROR"),
        ),
      )
    );
  }
}
