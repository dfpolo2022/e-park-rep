import 'package:flutter/material.dart';
import 'package:connectivity/connectivity.dart';

import 'package:e_park/core/network_info.dart';
import 'package:e_park/services/local_storage.dart';
import 'package:e_park/controller/UsersController.dart';
import 'package:e_park/ui/autenticacion/login.dart';
import 'package:e_park/ui/registerVehicle/vehicle_form.dart';

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
  Get.put(UserController());
  Get.put(Connectivity());
  Connectivity c = Get.find();
  Get.put(NetworkInfo(connectivity: c));
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Park',
      home: VehicleRegistration(),
    );
  }
}
