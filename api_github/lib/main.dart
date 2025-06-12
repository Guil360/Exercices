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
      home: const MyHomePage(title: 'GitHub Repositories'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class Repository {
  final String name;
  final bool isPrivate;

  Repository(this.name, this.isPrivate);
}

class _MyHomePageState extends State<MyHomePage> {
  String user = "";
  List<Repository> repositories = [];

  Future<dynamic> getHttp(String user) async {
    try {
      var response = await Dio().get('https://api.github.com/users/$user/repos');
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
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              decoration: const InputDecoration(
                labelText: 'Entrez un utilisateur GitHub',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                setState(() {
                  user = value;
                });
              },
            ),
          ),
          ElevatedButton(
            onPressed: () async {
              var result = await getHttp(user);
              setState(() {
                repositories = result != null
                    ? (result as List).map((repo) => Repository(
                  repo['name'] as String,
                  repo['private'] as bool,
                )).toList()
                    : [];
              });
            },
            child: const Text('Rechercher'),
          ),
          const SizedBox(height: 16),
          Text('Résultat: ${repositories.length} repositories'),
          Expanded(
            child: ListView.builder(
              itemCount: repositories.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(repositories[index].name),
                  subtitle: Text(repositories[index].isPrivate ? 'Privé' : 'Public'),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}