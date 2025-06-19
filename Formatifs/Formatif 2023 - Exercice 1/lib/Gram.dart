import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Am.dart';

class Gram extends StatelessWidget {
  Gram({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      body: Center(
        child: Container(
          width: 300,
          height: 300,
          color: Colors.amber,
          child: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Gram'),
                TextButton(
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => Am()),
                    );
                  },
                  child: const Text('Retour vers Am'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}