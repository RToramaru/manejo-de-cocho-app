import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/fazendaDados.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

import 'package:leitura_cocho/pages/components/list_tile_custom.dart';

class PdfPage extends StatefulWidget {
  const PdfPage({Key? key}) : super(key: key);

  @override
  State<PdfPage> createState() {
    return PdfPageState();
  }
}

class PdfPageState extends State<PdfPage> {
  List<Registro> registros = <Registro>[];
  DatabaseHelper db = DatabaseHelper();
  List<String> abastecimento = <String>[];

  @override
  void initState() {
    super.initState();

    db
        .getRegistrosUsuarios(
            FazendaDados.atual.nome, FazendaDados.atual.codigo)
        .then((lista) {
      setState(() {
        registros = lista;

        for (int c = 0; c < registros.length; c++) {
          if (double.parse(registros[c].porcentagem) >= 0 &&
              double.parse(registros[c].porcentagem) <= 2.5) {
            abastecimento.add((double.parse(registros[c].quantInicial) +
                        double.parse(registros[c].quantInicial) * 0.1)
                    .toStringAsFixed(2) +
                " kg");
          } else if (double.parse(registros[c].porcentagem) > 2.5 &&
              double.parse(registros[c].porcentagem) <= 5) {
            abastecimento.add((double.parse(registros[c].quantInicial) +
                        double.parse(registros[c].quantInicial) * 0.05)
                    .toStringAsFixed(2) +
                " kg");
          } else if (double.parse(registros[c].porcentagem) > 5 &&
              double.parse(registros[c].porcentagem) <= 10) {
            abastecimento.add(registros[c].quantInicial + " kg");
          } else if (double.parse(registros[c].porcentagem) > 10 &&
              double.parse(registros[c].porcentagem) <= 15) {
            abastecimento.add((double.parse(registros[c].quantInicial) -
                        double.parse(registros[c].quantInicial) * 0.05)
                    .toStringAsFixed(2) +
                " kg");
          } else if (double.parse(registros[c].porcentagem) > 15) {
            abastecimento.add((double.parse(registros[c].quantInicial) -
                        double.parse(registros[c].quantInicial) * 0.1)
                    .toStringAsFixed(2) +
                " kg");
          }
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: const EdgeInsets.only(bottom: 20, left: 30, right: 30),
                child: ElevatedButton.icon(
                  icon: const Icon(
                    Icons.picture_as_pdf_outlined,
                    color: Colors.white,
                    size: 24.0,
                  ),
                  label: const Text('Gerar PDF'),
                  onPressed: () {
                    Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) {
                        return buildPdf(format);
                      },
                    );
                  },
                  style: ElevatedButton.styleFrom(
                      fixedSize: const Size(400, 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(18),
                      ),
                      primary: Colors.green),
                ),
              ),
            ),
          ),
        ],
      ),
      appBar: AppBar(
        title: const Center(child: Text('Leitura de Cocho')),
        backgroundColor: const Color.fromARGB(255, 1, 39, 1),
      ),
      drawer: const ListTileCustom(),
    );
  }

  Future<Uint8List> buildPdf(PdfPageFormat format) async {
    final pw.Document doc = pw.Document();
    doc.addPage(pw.MultiPage(
        build: (context) => [
              pw.Table.fromTextArray(data: <List<String>>[
                <String>[
                  'Tratador',
                  'Abastecimento',
                  'Sobra',
                  'Porcentagem',
                  'Proximo abasteimento' 'Fazenda',
                  'Data'
                ],
                for (int c = 0; c < registros.length; c++) ...[
                  <String>[
                    registros[c].aluno,
                    registros[c].quantInicial + ' kg',
                    registros[c].quantFinal + ' kg',
                    registros[c].porcentagem + ' %',
                    abastecimento[c],
                    registros[c].fazenda,
                    registros[c].data,
                  ]
                ],
              ])
            ]));
    return await doc.save();
  }
}
