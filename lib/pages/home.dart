import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String valor = 'Selecione...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: const Color.fromARGB(255, 2, 87, 2),
        body: Column(children: [
          Center(
            child: Container(
              margin: const EdgeInsets.all(50),
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
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 10, top: 20),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 2.0)),
                    width: 300,
                    height: 50,
                    child: Theme(
                      data: Theme.of(context).copyWith(
                          canvasColor: const Color.fromARGB(255, 2, 87, 2)),
                      child: DropdownButton<String>(
                        value: valor,
                        isExpanded: true,
                        iconSize: 30,
                        style: const TextStyle(
                            color: Color.fromARGB(255, 247, 245, 245),
                            fontSize: 30),
                        icon: const Icon(Icons.arrow_downward,
                            color: Colors.white),
                        onChanged: (String? novoValor) {
                          setState(() {
                            valor = novoValor!;
                          });
                        },
                        items: <String>[
                          'Selecione...',
                          'Fazenda 2',
                          'Fazenda 3',
                          'Fazenda 4'
                        ].map<DropdownMenuItem<String>>((String value) {
                          return DropdownMenuItem<String>(
                            value: value,
                            child: Center(
                                child: Text(value,
                                    style: const TextStyle(fontSize: 30))),
                          );
                        }).toList(),
                      ),
                    ),
                  ),
                  Center(
                      child: ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pushReplacementNamed('/calculate');
                    },
                    child:
                        const Text('Acessar', style: TextStyle(fontSize: 30)),
                    style: ElevatedButton.styleFrom(
                      fixedSize: const Size(300, 50),
                      side: const BorderSide(
                        width: 2.0,
                        color: Colors.white,
                      ),
                      primary: const Color.fromARGB(255, 2, 87, 2),
                    ),
                  )),
                ],
              ),
            ),
          ),
        ]));
  }
}
