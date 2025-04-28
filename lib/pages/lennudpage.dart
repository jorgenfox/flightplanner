import 'package:flutter/material.dart';

class LennudPage extends StatelessWidget {
  const LennudPage({super.key});

  @override
  Widget build(BuildContext context) {

    final Map<String, String> args = ModalRoute.of(context)?.settings.arguments as Map<String, String>;

    return Scaffold(
      appBar: AppBar(title: const Text("Lennud")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Alguspunkt: ${args['departure']}'),
            Text('Sihtkoht: ${args['destination']}'),
            Text('Kuupäev: ${args['date']}'),
            Text('Hind: ${args['price']}'),
            //
          ],
        ),
      ),
    );
  }
}
