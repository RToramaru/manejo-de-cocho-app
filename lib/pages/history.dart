import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/pages/components/list_tile_custom.dart';

class HistoryPage extends StatefulWidget {
  const HistoryPage({Key? key}) : super(key: key);

  @override
  State<HistoryPage> createState() {
    return HistoryPageState();
  }
}

class HistoryPageState extends State<HistoryPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Registro> registros = <Registro>[];

  @override
  void initState() {
    super.initState();

    db.getRegistros().then((lista) {
      setState(() {
        registros = lista;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
          padding: const EdgeInsets.all(10.0),
          itemCount: registros.length,
          itemBuilder: (BuildContext context, int index) {
            return _listaRegistros(context, index);
          },
        ),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }

  _listaRegistros(BuildContext context, int index) {
    return Card(
        color: _escolheCor(index),
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
                        if (double.parse(registros[index].porcentagem) >= 0 &&
                            double.parse(registros[index].porcentagem) <=
                                2.5) ...[
                          Text(
                              'Próximo abastecimento: ' +
                                  (double.parse(registros[index].quantInicial) +
                                          double.parse(registros[index]
                                                  .quantInicial) *
                                              0.1)
                                      .toStringAsFixed(2) +
                                  " kg",
                              style: const TextStyle(fontSize: 20)),
                        ] else if (double.parse(registros[index].porcentagem) >
                                2.5 &&
                            double.parse(registros[index].porcentagem) <=
                                5) ...[
                          Text(
                              'Próximo abastecimento: ' +
                                  (double.parse(registros[index].quantInicial) +
                                          double.parse(registros[index]
                                                  .quantInicial) *
                                              0.05)
                                      .toStringAsFixed(2) +
                                  " kg",
                              style: const TextStyle(fontSize: 20)),
                        ] else if (double.parse(registros[index].porcentagem) >
                                5 &&
                            double.parse(registros[index].porcentagem) <=
                                10) ...[
                          Text(
                              'Próximo abastecimento: ' +
                                  registros[index].quantInicial +
                                  " kg",
                              style: const TextStyle(fontSize: 20)),
                        ] else if (double.parse(registros[index].porcentagem) >
                                10 &&
                            double.parse(registros[index].porcentagem) <=
                                15) ...[
                          Text(
                              'Próximo abastecimento: ' +
                                  (double.parse(registros[index].quantInicial) -
                                          double.parse(registros[index]
                                                  .quantInicial) *
                                              0.05)
                                      .toStringAsFixed(2) +
                                  " kg",
                              style: const TextStyle(fontSize: 20)),
                        ] else if (double.parse(registros[index].porcentagem) >
                            15) ...[
                          Text(
                              'Próximo abastecimento: ' +
                                  (double.parse(registros[index].quantInicial) -
                                          double.parse(registros[index]
                                                  .quantInicial) *
                                              0.1)
                                      .toStringAsFixed(2) +
                                  " kg",
                              style: const TextStyle(fontSize: 20)),
                        ]
                      ],
                    ))
              ],
            )));
  }

  _escolheCor(int index) {
    if (double.parse(registros[index].porcentagem) <= 5) {
      return const Color.fromARGB(255, 238, 164, 159);
    } else if (double.parse(registros[index].porcentagem) <= 10) {
      return const Color.fromARGB(255, 147, 231, 149);
    } else {
      return const Color.fromARGB(255, 236, 229, 163);
    }
  }
}
