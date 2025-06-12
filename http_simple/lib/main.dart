import 'package:flutter/material.dart';
import 'package:dio/dio.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int reponseNumber = 0;
  int number = 0;

  Future<dynamic> getHttp(int number) async {
    try {
      var response = await Dio().get('https://fourn6-mobile-prof.onrender.com/exos/long/double/$number');
      return response.data;
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32.0),
              child: TextField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Entrez un nombre',
                ),
                onChanged: (value) {
                  setState(() {
                    number = int.tryParse(value) ?? 0;
                  });
                },
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () async {
                var result = await getHttp(number);
                setState(() {
                  reponseNumber = result ?? 0;
                });
              },
              child: const Text('Envoyer'),
            ),
            const SizedBox(height: 16),
            Text('Résultat: $reponseNumber'),
          ],
        ),
      ),
    );
  }
}