import 'package:e_park/data/models/vehicle.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;
import 'package:e_park/data/models/users.dart';
import 'package:e_park/data/models/vehicle.dart';
import '../controller/Shared/user_local_shared_prefs.dart';

import 'dart:developer';
import 'dart:async';
import 'dart:convert';

class VehicleController extends GetxController {
  static const apiURL = 'http://backendunapp.eastus.cloudapp.azure.com:3000/';
  static const headers = {"Content-type": "application/json"};
  static const apiURLLocal = 'http://localhost:3000';

  @override
  onInit() {
    super.onInit();
  }

  Future<bool> addVehicle(Vehicle v) async {
    Map data = v.toJson();
    var body = json.encode(data);
    var response = await http.post(Uri.parse(apiURL + 'login'),
        headers: headers, body: body);
    if (response.statusCode == 201) {
      
    }
  }

  Future<bool> deleteVehicle(Vehicle v) async {}

  Future<bool> getMyVehicles() async {}

  Future<bool> updateVehicle(Vehicle v) async {}
}
