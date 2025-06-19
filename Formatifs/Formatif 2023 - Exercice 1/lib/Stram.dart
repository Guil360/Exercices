import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Gram.dart';
import '../../../../../navigation_drawer.dart' as CustomNavigationDrawer;

class Stram extends StatelessWidget {
  Stram({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Liste des Tâches'),
        centerTitle: true,
        elevation: 4,
        backgroundColor: Colors.deepPurple,
        leading: IconButton(
          icon: const Icon(Icons.menu),
          onPressed: () {
            _scaffoldKey.currentState?.openDrawer();
          },
        ),
      ),
      drawer: const CustomNavigationDrawer.NavigationDrawer(),
      body: Center(
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          await Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Gram()),
          );
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(Icons.arrow_right_alt),
        foregroundColor: Colors.white,
      ),
    );
  }
}