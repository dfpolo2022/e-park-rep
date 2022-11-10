import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_with_nested_routing_tutorial/routes/router.gr.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:loggy/loggy.dart';
import 'settings/configuration.dart';

// void main() => runApp(AppWidget());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: Configuration.apiKey,
      authDomain: Configuration.authDomain,
      databaseURL: Configuration.databaseURL,
      projectId: Configuration.projectId,
      messagingSenderId: Configuration.messagingSenderId,
      appId: Configuration.appId,
  ));
  runApp(AppWidget());
}


class AppWidget extends StatelessWidget {
  AppWidget({Key? key}) : super(key: key);
  final _appRouter = AppRouter();
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'E-Park',
      routerDelegate: _appRouter.delegate(),
      routeInformationParser: _appRouter.defaultRouteParser(),
    );
  }
}
