import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Accueil.dart';
import 'package:guillaume_pelletier/Details.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String? username = "Guillaume Pelletier";
    String? matricule = "2264914";

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.blue),
            child: Column(
              children: [

                const SizedBox(height: 10),
                Text(
                  username ?? 'Utilisateur',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  matricule ?? 'Matricule',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            leading: const Icon(Icons.abc),
            title: const Text('Détails'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Details()),
              );
            },
          ),
        ],
      ),
    );
  }
}