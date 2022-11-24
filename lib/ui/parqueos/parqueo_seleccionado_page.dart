import 'dart:async';
import 'package:flutter/material.dart';
import 'package:e_park/ui/data/app_data.dart';
import 'package:e_park/services/local_storage.dart';
import 'package:e_park/widgets.dart';
import 'package:e_park/ui/settings/settings_page.dart';
import 'package:e_park/ui/posts/posts_page.dart';

class SelectedParqueoPage extends StatefulWidget {
  final int selectedId;
  const SelectedParqueoPage({
    Key? key,
    required this.selectedId,
  }) : super(key: key);

  @override
  _SelectedParqueoState createState() => _SelectedParqueoState();
}

class _SelectedParqueoState extends State<SelectedParqueoPage> {
  Duration duration = Duration();
  Timer? timer;

  @override
  void initState() {
    super.initState();

    startTimer();
  }

  void addTime() {
    final addSeconds = 1;

    setState(() {
      final seconds = duration.inSeconds + addSeconds;

      duration = Duration(seconds: seconds);
    });
  }

  void startTimer() {
    timer = Timer.periodic(Duration(seconds: 1), (_) => addTime());
  }

  @override
  Widget build(BuildContext context) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours.remainder(60));
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    final parqueo = Parqueo.parqueos[LocalStorage.prefs.getInt('parqueoId')!];
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
                ParqueoWidget(
                  parqueoColor: parqueo.parqueoColor,
                  parqueoId: parqueo.parqueoId,
                  numeroParqueo: parqueo.numeroParqueo,
                  cupoParqueo: parqueo.cupoParqueo,
                  tiempoParqueo: parqueo.tiempoParqueo,
                  onParqueoTap: () {
                    null;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'Tiempo transcurrido: $hours:$minutes:$seconds',
                  style: const TextStyle(
                      color: Color(0xFFC4261D), fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 30),
                const CodigoQR(),
                SizedBox(height: 30),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => PostsPage(),
                        ));
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                    primary: const Color(0xFFC4261D),
                  ),
                  child: const Text(
                    'Pagar parqueadero',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ));
  }
}
