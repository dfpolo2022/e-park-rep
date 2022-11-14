import 'package:flutter/material.dart';
import 'package:flutter_bottom_navigation_with_nested_routing_tutorial/data/app_data.dart';
import 'package:flutter_bottom_navigation_with_nested_routing_tutorial/widgets.dart';
import 'package:flutter_bottom_navigation_with_nested_routing_tutorial/settings/settings_page.dart';
import 'dart:io';

class PostsPage extends StatelessWidget {
  PostsPage({Key? key}) : super(key: key);
  final posts = Post.posts;
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
                  'SELECCIONAR UN MÉTODO DE PAGO',
                  style: TextStyle(
                      color: Color(0xFFC4261D), fontWeight: FontWeight.bold),
                ),
                for (int i = 0; i < posts.length; i++)
                  PostTile(
                      tileColor: posts[i].color,
                      postTitle: posts[i].title,
                      onTileTap: () {
                        _showMyDialog(context);
                      }),
              ],
            ),
          ),
        ));
  }
}

Future<void> _showMyDialog(BuildContext context) async {
  return showDialog<void>(
    context: context,
    builder: (_) => popupConfirmacion(context),
  );
}

Widget popupConfirmacion(BuildContext context) {
  return AlertDialog(
    title: const Text(
      'Pago exitoso',
      style: TextStyle(fontWeight: FontWeight.bold),
    ),
    content: const Text('El pago ha sido realizado exitosamente.'),
    actions: <Widget>[
      TextButton(
        child: const Text(
          'Terminar',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        onPressed: () {
          Navigator.of(context).pop();
          Navigator.of(context).pop();
          Navigator.of(context).pop();
        },
      ),
    ],
    elevation: 24.0,
  );
}
