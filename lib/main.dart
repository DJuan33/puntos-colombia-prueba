import 'package:beamer/beamer.dart';
import 'package:flutter/material.dart';
import 'package:puntos_colombia_prueba/app/dependency_injector.dart';
import 'package:puntos_colombia_prueba/view/home/home_screen.dart';

void main() {
  AppInjector.setup();
  runApp(PuntosColombiaPrueba());
}

class PuntosColombiaPrueba extends StatelessWidget {
  PuntosColombiaPrueba({super.key});

  final Color primaryColor = const Color(0xFF782b90);
  final Color secondaryColor = const Color(0xFFEB1573);

  final BeamerDelegate _routerDelegate = BeamerDelegate(
    locationBuilder: RoutesLocationBuilder(
      routes: {
        '/': (_, __, ___) => HomeScreen(),
      },
    ).call,
  );

  @override
  Widget build(BuildContext context) => MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          fontFamily: 'Nunito',
          colorScheme: ColorScheme.fromSeed(
            seedColor: primaryColor,
            secondary: secondaryColor,
          ),
        ),
        routeInformationParser: BeamerParser(),
        routerDelegate: _routerDelegate,
      );
}
