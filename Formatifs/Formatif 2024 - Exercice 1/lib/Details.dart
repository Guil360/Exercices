import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Accueil.dart';
import '../../../../../navigation_drawer.dart' as CustomNavigationDrawer;

class Details extends StatelessWidget {
  Details({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Détails'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.deepPurple,

      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width - 100,
              color: Colors.deepOrange,
              child: const Center(
                child: Text(
                  "C'est réussi!",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => Accueil()),
                );
              },
              child: const Text("Revenir à l'accueil"),
            ),
          ],
        ),
      ),
    );
  }
}