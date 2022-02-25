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
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 87, 2),
        body: Column(children: [
          Center(
            child: Container(
              color: const Color.fromARGB(255, 2, 87, 2),
              child: Image.asset('assets/images/logo.png'),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 30,
            ),
            child: const Center(
              child: Text('Registro de cocho',
                  style: TextStyle(fontSize: 40, color: Colors.white)),
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Center(
                  child: ElevatedButton(
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/calculate');
                },
                child: const Text('Acessar', style: TextStyle(fontSize: 30)),
                style: ElevatedButton.styleFrom(
                  fixedSize: const Size(300, 50),
                  side: const BorderSide(
                    width: 2.0,
                    color: Colors.white,
                  ),
                  primary: const Color.fromARGB(255, 2, 87, 2),
                ),
              )),
            ),
          ),
        ]));
  }
}
