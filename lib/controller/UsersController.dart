import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:http/http.dart' as http;
import 'package:e_park/data/models/users.dart';
import '../controller/Shared/user_local_shared_prefs.dart';

import 'dart:developer';
import 'dart:async';
import 'dart:convert';

class UserController extends GetxController {
  static const apiURL = 'http://backendunapp.eastus.cloudapp.azure.com:3000/';
  static const headers = {"Content-type": "application/json"};
  static const apiURLLocal = 'http://localhost:3000';

  var _logged = false.obs;
  var _storeUser = false.obs;
  var _storeUserEmail = "".obs;
  var _storeUserPassword = "".obs;

  late UserLocalSharedPrefs userLocalSharedPrefs;

  @override
  onInit() {
    userLocalSharedPrefs = UserLocalSharedPrefs();
    super.onInit();
  }

  String get storeUserPassword => _storeUserPassword.value;
  String get storeUserEmail => _storeUserEmail.value;
  bool get storeUser => _storeUser.value;

  Future<bool> logout() async {
    _logged.value = false;
    _storeUserEmail = "".obs;
    _storeUserPassword = "".obs;
    userLocalSharedPrefs.deleteAll();
    return true;
  }

  Future<bool> login(String email, String pass) async {
    Map data = {
      'email': email,
      'password': pass,
    };

    var body = json.encode(data);
    var response = await http.post(Uri.parse(apiURL + 'login'),
        headers: headers, body: body);
    if (response.statusCode == 201) {
      var jsonResponse = json.decode(response.body);
      var accessToken = jsonResponse['data']['accessToken'];
      var refreshToken = jsonResponse['data']['refreshToken'];

      var user = User(email: email, password: pass);

      await userLocalSharedPrefs.storeUserInfo(user, accessToken, refreshToken);
      log('UserController login success');
      return true;
    } else {
      Get.snackbar('Error', 'Usuario o contraseña incorrectos');
      return false;
    }
  }

  Future<bool> register(
      String name, String lastname, String email, String pass) async {
    Map data = {
      'name': name,
      'lastname': lastname,
      'email': email,
      'password': pass,
    };

    log('UserController register data: $data');
    var body = json.encode(data);

    var initialResponse = await http.post(Uri.parse(apiURL + 'users/'),
        headers: headers, body: body);

    if (initialResponse.statusCode == 201) {
      Map loginData = {
        'email': email,
        'password': pass,
      };

      body = json.encode(loginData);

      var loginResponse = await http.post(Uri.parse(apiURL + 'login/'),
          headers: headers, body: body);

      if (loginResponse.statusCode == 201) {
        var jsonResponse = json.decode(loginResponse.body);
        var accessToken = jsonResponse['data']['accessToken'];
        var refreshToken = jsonResponse['data']['refreshToken'];

        var user =
            User(email: email, password: pass, name: name, lastname: lastname);

        await userLocalSharedPrefs.storeUserInfo(
            user, accessToken, refreshToken);
        log('UserController login success');
        return true;
      }
    } else {
      log(initialResponse.body);
      return false;
    }
    return false;
  }
}
