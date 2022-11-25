import 'dart:developer';

import 'package:e_park/ui/parqueos/parqueos_page.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:e_park/ui/autenticacion/login.dart';
import 'package:e_park/data/models/users.dart';
import 'package:e_park/data/models/vehicle.dart';
import 'package:e_park/controller/UsersController.dart';
import 'package:get/get.dart';

class VehicleRegistration extends StatefulWidget {
  const VehicleRegistration({Key? key}) : super(key: key);

  @override
  State<VehicleRegistration> createState() => _VehicleRegistrationState();
}

class _VehicleRegistrationState extends State<VehicleRegistration> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  UserController userController = Get.find();

  final TextEditingController brandController = TextEditingController();
  final TextEditingController modelController = TextEditingController();
  final TextEditingController yearController = TextEditingController();
  final TextEditingController colorController = TextEditingController();
  final TextEditingController registrationController = TextEditingController();

  bool isNumeric(String s) {
    if (int.parse(s) <= 2022) {
      if (int.parse(s) > 1900) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4261D),
        title: const Text('E-Park'),
        leading: const Icon(Icons.local_parking_outlined),
      ),
      body: Container(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const Text(
              'Registrar vehiculo',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 40,
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: brandController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese la marca';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Marca',
                            prefixIcon: const Icon(Icons.logo_dev),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: modelController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el modelo';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Modelo',
                            prefixIcon: const Icon(Icons.model_training),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: yearController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el año';
                            }
                            if (!isNumeric(value)) {
                              return 'Por favor ingrese un año valido';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Año',
                            prefixIcon: const Icon(Icons.calendar_month),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: TextFormField(
                          maxLines: 1,
                          controller: colorController,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Por favor ingrese el color';
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            hintText: 'Color',
                            prefixIcon: const Icon(Icons.color_lens),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Por favor, ingresar una placa';
                      }
                      return null;
                    },
                    maxLines: 1,
                    controller: registrationController,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      hintText: 'Placa',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        var userId = userController.storeUserEmail;

                        Vehicle myVehicle = Vehicle(
                            brand: brandController.text,
                            model: modelController.text,
                            year: yearController.text,
                            color: colorController.text,
                            registration: registrationController.text,
                            userid: userId);
                        log(myVehicle.toJson().toString());
                        bool register =
                            true; /*await userController.register(
                            user.name.toString(),
                            user.lastname.toString(),
                            user.email.toString(),
                            user.password.toString());*/
                        if (register) {
                          Navigator.of(context).pop();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Error al registrar'),
                            ),
                          );
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                      primary: const Color(0xFFC4261D),
                    ),
                    child: const Text(
                      'Registrar vehiculo',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
