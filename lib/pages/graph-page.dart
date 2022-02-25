// ignore_for_file: file_names

import 'package:draw_graph/draw_graph.dart';
import 'package:draw_graph/models/feature.dart';
import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/pages/list_tile_custom.dart';
import 'package:intl/intl.dart';
import 'package:collection/collection.dart';

class GraphPage extends StatefulWidget {
  const GraphPage({Key? key}) : super(key: key);

  @override
  State<GraphPage> createState() {
    return GraphPageState();
  }
}

class GraphPageState extends State<GraphPage> {
  DatabaseHelper db = DatabaseHelper();
  List<Registro> registros = <Registro>[];
  List quantAlimentoDia = [];
  List quantSobraDia = [];
  List valoresPesos = [];
  List<String> dataNome = <String>[];
  List<String> cochoNome = <String>[];

  @override
  void initState() {
    super.initState();

    DateTime now = DateTime.now();
    DateFormat formatterNow = DateFormat('yyyy-MM-dd');
    String formattedNow = formatterNow.format(now);

    DateTime before = now.subtract(const Duration(days: 7));
    DateFormat formatterBefore = DateFormat('yyyy-MM-dd');
    String formattedBefore = formatterBefore.format(before);

    db.getRegistrosData(formattedNow, formattedBefore).then((lista) {
      setState(() {
        registros = lista;
        var cochos = [];
        for (var element in registros) {
          cochos.add(element.cocho);
        }
        var dias = [];
        for (int i = 1; i <= 7; i++) {
          DateTime dia = now.subtract(Duration(days: i));
          DateFormat formatterDia = DateFormat('yyyy-MM-dd');
          String formattedDia = formatterDia.format(dia);
          dias.add(formattedDia);
          dias.sort();
        }

        var distintos = cochos.toSet().toList();
        for (int i = 0; i < distintos.length; i++) {
          cochoNome.add(distintos[i]);
        }
        var gruposCochos = [];
        for (int i = 0; i < distintos.length; i++) {
          gruposCochos.add(registros
              .where((element) => element.cocho == distintos[i])
              .toList());
        }

        for (int i = 0; i < gruposCochos.length; i++) {
          var quantAlimentoDiaAux = [];
          var quantSobraDiaAux = [];
          var aux = gruposCochos[i] as List<Registro>;
          var diaAlimento1 = [0.01];
          var diaSobra1 = [0.01];
          var diaAlimento2 = [0.01];
          var diaSobra2 = [0.01];
          var diaAlimento3 = [0.01];
          var diaSobra3 = [0.01];
          var diaAlimento4 = [0.01];
          var diaSobra4 = [0.01];
          var diaAlimento5 = [0.01];
          var diaSobra5 = [0.01];
          var diaAlimento6 = [0.01];
          var diaSobra6 = [0.01];
          var diaAlimento7 = [0.01];
          var diaSobra7 = [0.01];

          for (int c = 0; c < aux.length; c++) {
            var auxCochoDias = aux[c];
            if (auxCochoDias.data.substring(0, 10) == dias[0]) {
              diaAlimento1.add(double.parse(auxCochoDias.quantInicial));
              diaSobra1.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[1]) {
              diaAlimento2.add(double.parse(auxCochoDias.quantInicial));
              diaSobra2.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[2]) {
              diaAlimento3.add(double.parse(auxCochoDias.quantInicial));
              diaSobra3.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[3]) {
              diaAlimento4.add(double.parse(auxCochoDias.quantInicial));
              diaSobra4.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[4]) {
              diaAlimento5.add(double.parse(auxCochoDias.quantInicial));
              diaSobra5.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[5]) {
              diaAlimento6.add(double.parse(auxCochoDias.quantInicial));
              diaSobra6.add(double.parse(auxCochoDias.quantFinal));
            } else if (auxCochoDias.data.substring(0, 10) == dias[6]) {
              diaAlimento7.add(double.parse(auxCochoDias.quantInicial));
              diaSobra7.add(double.parse(auxCochoDias.quantFinal));
            }
          }

          quantAlimentoDiaAux.add([
            diaAlimento1.sum,
            diaAlimento2.sum,
            diaAlimento3.sum,
            diaAlimento4.sum,
            diaAlimento5.sum,
            diaAlimento6.sum,
            diaAlimento7.sum
          ]);

          quantSobraDiaAux.add([
            diaSobra1.sum,
            diaSobra2.sum,
            diaSobra3.sum,
            diaSobra4.sum,
            diaSobra5.sum,
            diaSobra6.sum,
            diaSobra7.sum
          ]);

          var maxAlimentoList = quantAlimentoDiaAux[0];
          maxAlimentoList.sort();
          var maxAlimento = maxAlimentoList[6];
          quantAlimentoDia.add([
            (diaAlimento1.sum / maxAlimento),
            (diaAlimento2.sum / maxAlimento),
            (diaAlimento3.sum / maxAlimento),
            (diaAlimento4.sum / maxAlimento),
            (diaAlimento5.sum / maxAlimento),
            (diaAlimento6.sum / maxAlimento),
            (diaAlimento7.sum / maxAlimento)
          ]);

          valoresPesos.add([
            ((maxAlimento / 5).toStringAsFixed(2)).toString() + 'kg',
            ((maxAlimento / 4).toStringAsFixed(2)).toString() + 'kg',
            ((maxAlimento / 3).toStringAsFixed(2)).toString() + 'kg',
            ((maxAlimento / 2).toStringAsFixed(2)).toString() + 'kg',
            ((maxAlimento / 1).toStringAsFixed(2)).toString() + 'kg'
          ]);

          quantSobraDia.add([
            (diaSobra1.sum / maxAlimento),
            (diaSobra2.sum / maxAlimento),
            (diaSobra3.sum / maxAlimento),
            (diaSobra4.sum / maxAlimento),
            (diaSobra5.sum / maxAlimento),
            (diaSobra6.sum / maxAlimento),
            (diaSobra7.sum / maxAlimento)
          ]);
        }
        for (int i = 1; i <= 7; i++) {
          DateTime dia = now.subtract(Duration(days: i));
          DateFormat formatterDia = DateFormat('dd');
          String formattedDia = formatterDia.format(dia);
          dataNome.add(formattedDia);
          dataNome.sort();
        }
      });
    });
  }

  List<Feature> dados(int index) {
    List<Feature> features = [
      Feature(
        title: "Abastecimento (kg)",
        color: const Color.fromARGB(255, 7, 102, 23),
        data: quantAlimentoDia[index],
      ),
      Feature(
        title: "Sobras (kg)",
        color: const Color.fromARGB(255, 245, 5, 5),
        data: quantSobraDia[index],
      ),
    ];
    return features;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView(children: [
          for (int c = 0; c < quantAlimentoDia.length; c++)
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 2.0, horizontal: 4.0),
                  child: Text(
                    'Cocho ' + cochoNome[c],
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                ),
                LineGraph(
                  features: dados(c),
                  size: const Size(400, 250),
                  labelX: dataNome,
                  labelY: valoresPesos[c],
                  showDescription: true,
                  graphColor: Colors.black,
                  graphOpacity: 0.0,
                  verticalFeatureDirection: false,
                  descriptionHeight: 200,
                ),
              ],
            ),
        ]),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
