import 'dart:typed_data';
import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
          children: [
            Expanded(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Container(
                  margin:
                      const EdgeInsets.only(bottom: 20, left: 30, right: 30),
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
                <String>['Nome', 'Sobrenome', 'Idade'],
                <String>['name', 'lastName', 'year']
              ])
            ]));
    return await doc.save();
  }
}
