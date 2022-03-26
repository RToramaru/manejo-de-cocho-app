import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/pages/components/list_tile_custom.dart';

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
  final fieldTextPesquisa = TextEditingController();

  Future<bool> pesquisa(String id) async {
    registros = <Registro>[];
    await db.getRegistrosCocho(id).then((lista) {
      setState(() {
        registros = lista;
        if (registros.isEmpty) {
          encontrado = false;
        }
      });
    });

    if (registros.isEmpty) {
      await db.getRegistrosAluno(id).then((lista) {
        setState(() {
          registros = lista;
        });
      });
    }
    if (registros.isNotEmpty) {
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.max,
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
                      controller: fieldTextPesquisa,
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
                        fieldTextPesquisa.clear();
                      });
                    },
                  ),
                ],
              ),
            ),
            if (encontrado) ...[
              if (double.parse(registros[0].porcentagem) >= 0 &&
                  double.parse(registros[0].porcentagem) <= 2.5) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          (double.parse(registros[0].quantInicial) +
                                  double.parse(registros[0].quantInicial) * 0.1)
                              .toStringAsFixed(2) +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ] else if (double.parse(registros[0].porcentagem) > 2.5 &&
                  double.parse(registros[0].porcentagem) <= 5) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          (double.parse(registros[0].quantInicial) +
                                  double.parse(registros[0].quantInicial) *
                                      0.05)
                              .toStringAsFixed(2) +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ] else if (double.parse(registros[0].porcentagem) > 5 &&
                  double.parse(registros[0].porcentagem) <= 10) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          registros[0].quantInicial +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ] else if (double.parse(registros[0].porcentagem) > 10 &&
                  double.parse(registros[0].porcentagem) <= 15) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          (double.parse(registros[0].quantInicial) -
                                  double.parse(registros[0].quantInicial) *
                                      0.05)
                              .toStringAsFixed(2) +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ] else if (double.parse(registros[0].porcentagem) > 15) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          (double.parse(registros[0].quantInicial) -
                                  double.parse(registros[0].quantInicial) * 0.1)
                              .toStringAsFixed(2) +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ] else if (double.parse(registros[0].porcentagem) <= 5) ...[
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Text(
                      'Colocar ' +
                          registros[0].quantInicial +
                          ' kg de alimento',
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold)),
                ),
              ],
              const Padding(
                padding: EdgeInsets.fromLTRB(20.0, 0, 0, 0),
                child: Text('Histórico',
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
            ],
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(10.0),
                itemCount: registros.length,
                itemBuilder: (BuildContext context, int index) {
                  return _listaRegistros(context, index);
                },
              ),
            )
          ],
        ),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }

  _listaRegistros(BuildContext context, int index) {
    return Card(
        child: Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: <Widget>[
                Padding(
                    padding: const EdgeInsets.only(left: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text('Tratador: ' + registros[index].aluno,
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Identificador do cocho: ' + registros[index].cocho,
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Quantidade Inicial: ' +
                                registros[index].quantInicial +
                                ' kg',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Quantidade Final: ' +
                                registros[index].quantFinal +
                                ' kg',
                            style: const TextStyle(fontSize: 20)),
                        Text(
                            'Porcentagem: ' +
                                registros[index].porcentagem +
                                '%',
                            style: const TextStyle(fontSize: 20)),
                        Text('Data: ' + registros[index].data,
                            style: const TextStyle(fontSize: 20)),
                      ],
                    ))
              ],
            )));
  }
}
