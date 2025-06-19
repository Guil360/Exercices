import 'package:flutter/material.dart';
import 'package:guillaume_pelletier/Am.dart';
import 'package:guillaume_pelletier/Stram.dart';

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    String? username = "Guillaume Pelletier";

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 30,
                  child: Text(
                    username != null ? username[0].toUpperCase() : 'U',
                    style: const TextStyle(fontSize: 24, color: Colors.white),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  username ?? 'Utilisateur',
                  style: const TextStyle(color: Colors.white, fontSize: 18),
                ),
              ],
            ),
          ),
          ListTile(
            title: const Text('Am'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Am()),
              );
            },
          ),
          ListTile(
            title: const Text('Stram'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => Stram()),
              );
            },
          ),
        ],
      ),
    );
  }
}