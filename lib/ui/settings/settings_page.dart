import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  TextStyle headingStyle = const TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: const Color(0xFFC4261D),
  );

  bool lockAppSwitchVal = true;
  bool fingerprintSwitchVal = false;
  bool changePassSwitchVal = true;

  TextStyle headingStyleIOS = const TextStyle(
    fontWeight: FontWeight.w600,
    fontSize: 16,
    color: CupertinoColors.inactiveGray,
  );
  TextStyle descStyleIOS = const TextStyle(color: CupertinoColors.inactiveGray);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFFC4261D),
        title: const Text(
          "Configuración",
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "General",
                    style: headingStyle,
                  ),
                ],
              ),
              const ListTile(
                leading: Icon(Icons.language),
                title: Text("Idioma"),
                subtitle: Text("Español"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.cloud),
                title: Text("Modo"),
                subtitle: Text("Claro"),
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Perfil", style: headingStyle),
                ],
              ),
              const ListTile(
                leading: Icon(Icons.phone),
                title: Text("Nombre"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.mail),
                title: Text("E-Mail"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.car_rental),
                title: const Text("Vehículos asociados"),
                onTap: () {
                  Navigator.pushNamed(context, "/vehicles");
                },
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.attach_money),
                title: Text("Historial de pagos"),
              ),
              const Divider(),
              const ListTile(
                leading: Icon(Icons.lock),
                title: Text("Cambiar contraseña"),
              ),
              const Divider(),
              ListTile(
                leading: const Icon(Icons.exit_to_app),
                title: const Text("Cerrar sesión"),
                onTap: () async {
                  await showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text("Cerrar sesión"),
                      content: const Text("¿Está seguro de cerrar sesión?"),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text("Cancelar"),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                            Navigator.of(context).pop();
                          },
                          child: const Text("Aceptar"),
                        ),
                      ],
                    ),
                  );
                },
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text("Seguridad", style: headingStyle),
                ],
              ),
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text("Mantener perfil guardado"),
                trailing: Switch(
                    value: changePassSwitchVal,
                    activeColor: const Color(0xFFC4261D),
                    onChanged: (val) {
                      setState(() {
                        changePassSwitchVal = val;
                      });
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
