import 'package:flutter/material.dart';
import '../helpers/database_helpers.dart';
import '../models/registro.dart';
import 'list_tile_custom.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() {
    return SearchPageState();
  }
}

class SearchPageState extends State<SearchPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Registro> registros = <Registro>[];
  String cocho = '';
  bool encontrado = false;

  @override
  void initState() {
    super.initState();
  }

  Future<bool> pesquisa(String id) async {
    await db.getRegistrosCocho(id).then((lista) {
      setState(() {
        registros = lista;
      });
    });
    if (registros.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Row(
                children: [
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.7,
                    child: TextField(
                      onChanged: (identificador) {
                        cocho = identificador;
                      },
                      keyboardType: TextInputType.text,
                      decoration: const InputDecoration(
                        border: InputBorder.none,
                        labelText: 'Identificador',
                      ),
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.search),
                    tooltip: 'Pesquisar',
                    onPressed: () async {
                      // ignore: await_only_futures
                      bool valido = await pesquisa(cocho);
                      setState(() {
                        encontrado = valido;
                      });
                    },
                  ),
                ],
              ),
            ),
            Padding(
                padding: const EdgeInsets.only(left: 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    if (encontrado) ...[
                      if (double.parse(registros[0].porcentagem) <= 5) ...[
                        Text(
                            'Colocar ' +
                                registros[0].quantInicial +
                                ' kg de alimento',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ] else if (double.parse(registros[0].porcentagem) ==
                          0) ...[
                        Text(
                            'Colocar ' +
                                (double.parse(registros[0].quantInicial) +
                                        double.parse(
                                                registros[0].quantInicial) *
                                            0.1)
                                    .toString() +
                                ' kg de alimento',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ] else ...[
                        Text(
                            'Colocar ' +
                                (double.parse(registros[0].quantInicial) -
                                        double.parse(
                                                registros[0].quantInicial) *
                                            0.1)
                                    .toString() +
                                ' kg de alimento',
                            style: const TextStyle(
                                fontSize: 20, fontWeight: FontWeight.bold)),
                      ],
                      Container(
                        margin: const EdgeInsets.only(
                          top: 20,
                          bottom: 20,
                        ),
                        child: const Text('Último abastecimento',
                            style: TextStyle(
                              fontSize: 25,
                              shadows: [
                                Shadow(
                                    color: Colors.black,
                                    blurRadius: 8,
                                    offset: Offset(1, 1))
                              ],
                            )),
                      ),
                      Text('Aluno: ' + registros[0].aluno,
                          style: const TextStyle(fontSize: 20)),
                      Text('Identificador do cocho: ' + registros[0].cocho,
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          'Quantidade Inicial: ' +
                              registros[0].quantInicial +
                              " kg",
                          style: const TextStyle(fontSize: 20)),
                      Text(
                          'Quantidade Final: ' +
                              registros[0].quantFinal +
                              " kg",
                          style: const TextStyle(fontSize: 20)),
                      Text('Porcentagem: ' + registros[0].porcentagem + '%',
                          style: const TextStyle(fontSize: 20)),
                      Text('Data: ' + registros[0].data,
                          style: const TextStyle(fontSize: 20))
                    ]
                  ],
                ))
          ],
        ),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
