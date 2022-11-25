import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:e_park/ui/data/app_data.dart';
import 'package:email_validator/email_validator.dart';

const List<String> list = <String>['PSE', 'Bancolombia', 'Visa'];

class PaymentPage extends StatefulWidget {
  const PaymentPage({Key? key}) : super(key: key);

  @override
  State<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends State<PaymentPage> {
  final _formKey = GlobalKey<FormState>();
  var rememberValue = false;
  String dropdownValue = list.first;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'E-Park',
      home: Scaffold(
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
                'Realizar pago',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 40,
                ),
                textAlign: TextAlign.left,
              ),
              const SizedBox(
                height: 60,
              ),
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    const Text(
                      'Tipo de tarjeta',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    DropdownButton<String>(
                      value: dropdownValue,
                      icon: const Icon(Icons.arrow_downward),
                      elevation: 16,
                      underline: Container(
                        height: 2,
                        color: Colors.grey,
                      ),
                      onChanged: (String? value) {
                        // This is called when the user selects an item.
                        setState(() {
                          dropdownValue = value!;
                        });
                      },
                      items: list.map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Datos de tarjeta',
                      textAlign: TextAlign.left,
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresar un numero de tarjeta.';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                        hintText: '1234 1234 1234 1234',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10)),
                        ),
                      ),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresar una fecha de expiracion.';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: const InputDecoration(
                          hintText: 'Fecha de Expiracion (MM/AA)',
                          border: OutlineInputBorder()),
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresar una clave de seguridad.';
                        }
                        return null;
                      },
                      maxLines: 1,
                      obscureText: true,
                      decoration: const InputDecoration(
                        hintText: 'Clave de seguridad',
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(10),
                              bottomRight: Radius.circular(10)),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    const Text(
                      'Nombre del titular',
                      style:
                          TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
                      textAlign: TextAlign.left,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextFormField(
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresar el nombre del titular.';
                        }
                        return null;
                      },
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    CheckboxListTile(
                      title: const Text("Recordar datos"),
                      contentPadding: EdgeInsets.zero,
                      value: rememberValue,
                      activeColor: Theme.of(context).colorScheme.primary,
                      onChanged: (newValue) {
                        setState(() {
                          rememberValue = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    TextButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          _showMyDialog(context);
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.fromLTRB(40, 15, 40, 15),
                        primary: const Color(0xFFC4261D),
                      ),
                      child: const Text(
                        'Confirmar pago',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: const Text(
                            'Regresar',
                            style: TextStyle(color: Color(0xFFC4261D)),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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
