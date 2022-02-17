import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onVerticalDragEnd: (details) =>
          Navigator.of(context).pushReplacementNamed('/calculate'),
      child: Scaffold(
        floatingActionButton: FloatingActionButton(
            backgroundColor: Colors.green,
            child: const Icon(Icons.login),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/calculate');
            }),
      ),
    );
  }
}
