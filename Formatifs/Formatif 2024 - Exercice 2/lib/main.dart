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
      title: 'Recherche Animaux',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const SearchPage(),
    );
  }
}

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  final TextEditingController _continentController = TextEditingController();
  final TextEditingController _familleController = TextEditingController();
  bool _loading = false;
  String? _error;
  List<dynamic> _results = [];

  Future<void> _sendRequest() async {
    final continent = _continentController.text.trim().isEmpty
        ? 'monde'
        : _continentController.text.trim();
    final famille = _familleController.text.trim();
    String url = 'http://10.0.2.2:8080/exam/animaux/$continent';
    if (famille.isNotEmpty || continent == 'monde') {
      url += '?famille=$famille';
    }
    setState(() {
      _loading = true;
      _error = null;
      _results = [];
    });
    try {
      final dio = Dio();
      final res = await dio.get(url);
      setState(() {
        if (res.data is List) {
          _results = res.data;
        } else {
          _results = [];
          _error = 'Aucun résultat';
        }
      });
    } catch (e) {
      setState(() {
        _results = [];
        _error = 'Erreur: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  Icon _getIcon(String continent) {
    if (continent.toLowerCase() == 'océans' || continent.toLowerCase() == 'oceans') {
      return const Icon(Icons.water, color: Colors.blue);
    }
    return const Icon(Icons.landscape, color: Colors.green);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche Animaux')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _continentController,
              decoration: const InputDecoration(
                labelText: 'Continent (ex: afrique, monde, océans...)',
              ),
              onSubmitted: (_) => _sendRequest(),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _familleController,
              decoration: const InputDecoration(
                labelText: 'Famille (optionnel, ex: felidae)',
              ),
              onSubmitted: (_) => _sendRequest(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _sendRequest,
              child: _loading
                  ? const SizedBox(
                width: 20,
                height: 20,
                child: CircularProgressIndicator(strokeWidth: 2),
              )
                  : const Text('Rechercher'),
            ),
            const SizedBox(height: 24),
            if (_error != null)
              Text(_error!, style: const TextStyle(color: Colors.red)),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final item = _results[index];
                    final nom = item['nom'] ?? 'Inconnu';
                    final continent = item['continent'] ?? '';
                    return ListTile(
                      leading: _getIcon(continent),
                      title: Text(nom),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}