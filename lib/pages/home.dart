import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/fazenda.dart';
import 'package:leitura_cocho/models/fazendaDados.dart';
import 'package:leitura_cocho/models/usuarioAtual.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() {
    return HomePageState();
  }
}

class HomePageState extends State<HomePage> {
  String valor = 'Selecione...';
  List<String> opcoes = <String>[];
  late String codigo;

  DatabaseHelper db = DatabaseHelper();
  List<Fazenda> fazenda = <Fazenda>[];

  @override
  void initState() {
    super.initState();

    db.getFazendaUsuario(UsuarioAtual.usuario).then((lista) {
      setState(() {
        fazenda = lista;

        if (fazenda.isEmpty) {
          Navigator.of(context).pushReplacementNamed('/farmCreate');
        } else {
          valor = fazenda[0].nome;
          for (int c = 0; c < fazenda.length; c++) {
            opcoes.add(fazenda[c].nome);
          }
        }
      });
    });
  }

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
                        items: opcoes
                            .map<DropdownMenuItem<String>>((String value) {
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
                      setState(() {
                        for (int c = 0; c < fazenda.length; c++) {
                          if (fazenda[c].nome == valor) {
                            codigo = fazenda[c].codigo;
                          }
                        }
                        Fazenda f =
                            Fazenda(valor, codigo, UsuarioAtual.usuario);
                        FazendaDados.atual = f;
                        FazendaDados.registros = fazenda;
                      });
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
