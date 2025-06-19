import 'package:flutter/material.dart';
import '../../../../../navigation_drawer.dart' as CustomNavigationDrawer;

class Accueil extends StatelessWidget {
  Accueil({super.key});

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final double topHeight = 100.0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        drawer: CustomNavigationDrawer.NavigationDrawer(),
        appBar: AppBar(title: Text('Am'), backgroundColor: Colors.purple[200]),
        body: LayoutBuilder(
          builder: (context, constraints) {
            final availableHeight = constraints.maxHeight - topHeight;
            return Column(
              children: [
                Row(
                  children: [
                    Container(
                      height: topHeight,
                      width: MediaQuery.of(context).size.width / 3,
                      color: Colors.blue,
                      child: Center(
                        child: Text(
                          'Bleu 1/3',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                    Container(
                      height: topHeight,
                      width: (MediaQuery.of(context).size.width / 3) * 2,
                      color: Colors.red,
                      child: Center(
                        child: Text(
                          'Rouge 2/3',
                          style: TextStyle(fontSize: 24, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: availableHeight,
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: availableHeight / 3,
                            width: MediaQuery.of(context).size.width,
                            color: Colors.green,
                            child: Center(
                              child: Text(
                                'Vert',
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(8),
                            child: Container(
                              height: (availableHeight / 3) - 16,
                              width: MediaQuery.of(context).size.width - 16,
                              color: Colors.yellow,
                              child: Center(
                                child: Text(
                                  'Jaune',
                                  style: TextStyle(fontSize: 24, color: Colors.black),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            height: availableHeight / 3,
                            width: MediaQuery.of(context).size.width / 4,
                            color: Colors.deepOrangeAccent,
                            child: Center(
                              child: Text(
                                'Orange 1/4',
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                          Container(
                            height: availableHeight / 3,
                            width: MediaQuery.of(context).size.width / 2,
                            color: Colors.transparent,
                          ),
                          Container(
                            height: availableHeight / 3,
                            width: MediaQuery.of(context).size.width / 4,
                            color: Colors.pink,
                            child: Center(
                              child: Text(
                                'Rose 1/4',
                                style: TextStyle(fontSize: 24, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}