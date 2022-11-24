import 'package:flutter/material.dart';
import 'package:e_park/ui/autenticacion/login.dart';
import 'package:e_park/services/local_storage.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await LocalStorage.configurePrefs();
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Park',
      home: LoginPage(),
    );
  }
}
