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
      title: 'Recherche Artiste',
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
  final TextEditingController _controller = TextEditingController();
  bool _loading = false;
  String? _response;
  List<dynamic> _results = [];

  Future<void> _sendRequest() async {
    final terme = _controller.text.trim();
    if (terme.isEmpty) return;
    setState(() {
      _loading = true;
      _response = null;
      _results = [];
    });
    final url = 'https://examen-intra-a23.azurewebsites.net/exam/artiste/recherche/$terme';
    try {
      final dio = Dio();
      final res = await dio.get(url);
      setState(() {
        _response = null;
        if (res.data is List) {
          _results = res.data;
        } else {
          _results = [];
          _response = res.data.toString();
        }
      });
    } catch (e) {
      setState(() {
        _results = [];
        _response = 'Erreur: $e';
      });
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Recherche Artiste')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: const InputDecoration(
                labelText: 'Terme de recherche',
              ),
              onSubmitted: (_) => _sendRequest(),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _loading ? null : _sendRequest,
              child: _loading ? const CircularProgressIndicator() : const Text('Rechercher'),
            ),
            const SizedBox(height: 24),
            if (_response != null)
              Expanded(child: SingleChildScrollView(child: Text(_response!))),
            if (_results.isNotEmpty)
              Expanded(
                child: ListView.builder(
                  itemCount: _results.length,
                  itemBuilder: (context, index) {
                    final item = _results[index];
                    String name = '';
                    if (item is Map && item.containsKey('titre')) {
                      name = item['titre'].toString();
                    } else {
                      name = item.toString();
                    }
                    return ListTile(
                      title: Text(name),
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
