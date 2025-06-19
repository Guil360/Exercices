import 'package:flutter/material.dart';
import '../../../../../navigation_drawer.dart' as CustomNavigationDrawer;

class Am extends StatelessWidget {
  Am({super.key});
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double greenHeight = 44.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: CustomNavigationDrawer.NavigationDrawer(),
        appBar: AppBar(
          title: Text('Am'),
          backgroundColor: Colors.purple[200],
        ),
        body: Column(
          children: [
            Container(
              height: greenHeight * 6,
              color: Colors.blue,
            ),
            Container(
              height: greenHeight,
              color: Colors.green,
            ),
            Expanded(
              child: Center(
                child: Container(
                  width: 222,
                  height: 222,
                  color: Colors.yellow,
                ),
              ),
            ),
            Container(
              height: greenHeight * 3,
              color: Colors.red,
            ),
            Container(
              height: greenHeight * 4,
              color: Colors.orange,
            ),
          ],
        ),
      ),
    );
  }
}