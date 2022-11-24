import 'package:flutter/material.dart';
import 'package:e_park/ui/data/app_data.dart';
import 'package:e_park/ui/parqueos/parqueo_seleccionado_page.dart';
import 'package:e_park/services/local_storage.dart';
import 'package:e_park/widgets.dart';
import 'package:e_park/ui/settings/settings_page.dart';

class ParqueosPage extends StatelessWidget {
  ParqueosPage({Key? key}) : super(key: key);
  final parqueos = Parqueo.parqueos;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFFC4261D),
          title: const Text('E-Park'),
          leading: const Icon(Icons.local_parking_outlined),
          shadowColor: Colors.black,
          actions: <Widget>[
            IconButton(
              icon: const Icon(Icons.settings),
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SettingsPage(),
                    ));
              },
            ),
            Container(
              margin: const EdgeInsets.all(5.0),
              color: const Color(0xFFC4261D),
              width: 5.0,
            ),
          ],
        ),
        body: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'SELECCIONAR UN PARQUEADERO',
                  style: TextStyle(
                      color: Color(0xFFC4261D), fontWeight: FontWeight.bold),
                ),
                for (int i = 0; i < parqueos.length; i++)
                  ParqueoWidget(
                    parqueoColor: parqueos[i].parqueoColor,
                    parqueoId: parqueos[i].parqueoId,
                    numeroParqueo: parqueos[i].numeroParqueo,
                    cupoParqueo: parqueos[i].cupoParqueo,
                    tiempoParqueo: parqueos[i].tiempoParqueo,
                    onParqueoTap: () {
                      _showMyDialog(context, parqueos[i].numeroParqueo,
                          parqueos[i].parqueoId);
                    },
                  ),
                SizedBox(height: 30),
                const Text(
                  'Recuerde solo seleccionar el parqueadero una vez que ha terminado de parquearse.',
                  style: TextStyle(color: Color(0xFFC4261D)),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ));
  }
}

Future<void> _showMyDialog(
    BuildContext context, int index, int numParqueo) async {
  return showDialog<void>(
    context: context,
    builder: (_) => popupConfirmacion(context, index, numParqueo),
  );
}

Widget popupConfirmacion(BuildContext context, int index, int numParqueo) {
  return AlertDialog(
    title: const Text(
      'Confirmación',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: Text(
        'Usted ha seleccionado el parqueadero #${index.toString()}, ¿Desea confirmar?'),
    actions: <Widget>[
      TextButton(
        child: const Text(
          'Si',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
          LocalStorage.prefs.setInt('parqueoId', numParqueo);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => SelectedParqueoPage(
                  selectedId: numParqueo,
                ),
              ));
        },
      ),
      TextButton(
        child: const Text(
          'No',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context, rootNavigator: true).pop('dialog');
        },
      ),
    ],
    elevation: 24.0,
  );
}
