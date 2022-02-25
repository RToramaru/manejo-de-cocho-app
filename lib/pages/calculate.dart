import 'package:flutter/material.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/pages/list_tile_custom.dart';

class CalculatePage extends StatefulWidget {
  const CalculatePage({Key? key}) : super(key: key);

  @override
  State<CalculatePage> createState() {
    return CalculatePageState();
  }
}

class CalculatePageState extends State<CalculatePage> {
  late String aluno;
  late String cocho;
  late String quantInicial;
  late String quantFinal;
  late String porcentagem;
  late String data;
  String text = '';
  final fieldTextAluno = TextEditingController();
  final fieldTextCocho = TextEditingController();
  final fieldTextInical = TextEditingController();
  final fieldTextFinal = TextEditingController();

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

  void insertRegistro(Registro r) {
    db.insertRegistro(r);
  }

  void clearText() {
    fieldTextAluno.clear();
    fieldTextCocho.clear();
    fieldTextInical.clear();
    fieldTextFinal.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: ListView(
          children: [
            Container(
              margin: const EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    TextField(
                      onChanged: (alunotext) {
                        aluno = alunotext;
                      },
                      keyboardType: TextInputType.text,
                      decoration: InputDecoration(
                          labelText: 'Tratador',
                          enabledBorder: OutlineInputBorder(
                              borderSide: const BorderSide(
                                  width: 3, color: Colors.blue),
                              borderRadius: BorderRadius.circular(15)),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                const BorderSide(width: 3, color: Colors.red),
                            borderRadius: BorderRadius.circular(15),
                          )),
                      controller: fieldTextAluno,
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TextField(
                        onChanged: (cochoText) {
                          cocho = cochoText;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Identificador',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: fieldTextCocho,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TextField(
                        onChanged: (quantInicialText) {
                          try {
                            quantInicial =
                                quantInicialText.replaceAll(',', '.');
                            // ignore: empty_catches
                          } catch (e) {}
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantidade Inicial',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: fieldTextInical,
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TextField(
                        onChanged: (quantFinalText) {
                          try {
                            quantFinal = quantFinalText.replaceAll(',', '.');
                            // ignore: empty_catches
                          } catch (e) {}
                        },
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: 'Quantidade Final',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: fieldTextFinal,
                      ),
                    ),
                    SizedBox(
                      width: double.infinity,
                      child: Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: ElevatedButton(
                          onPressed: () {
                            setState(() {
                              double porcent =
                                  (100 * double.parse(quantFinal)) /
                                      double.parse(quantInicial);
                              String porcentagem = porcent.toStringAsFixed(2);
                              if (double.parse(porcentagem) >= 0 &&
                                  double.parse(porcentagem) <= 2.5) {
                                double valor = double.parse(quantInicial) +
                                    double.parse(quantInicial) * 0.1;
                                text = "A porcentagem que restou \n"
                                        "foi de $porcentagem% \n"
                                        "Para o proximo abastecimento \n"
                                        "colocar " +
                                    valor.toString() +
                                    " kg";
                              } else if (double.parse(porcentagem) > 2.5 &&
                                  double.parse(porcentagem) <= 5) {
                                double valor = double.parse(quantInicial) +
                                    double.parse(quantInicial) * 0.05;
                                text = "A porcentagem que restou \n"
                                        "foi de $porcentagem% \n"
                                        "Para o proximo abastecimento \n"
                                        "colocar " +
                                    valor.toString() +
                                    " kg";
                              } else if (double.parse(porcentagem) > 5 &&
                                  double.parse(porcentagem) <= 10) {
                                text = "A porcentagem que restou \n"
                                        "foi de $porcentagem% \n"
                                        "Para o proximo abastecimento \n"
                                        "colocar " +
                                    quantInicial +
                                    " kg";
                              } else if (double.parse(porcentagem) > 10 &&
                                  double.parse(porcentagem) <= 15) {
                                double valor = double.parse(quantInicial) -
                                    double.parse(quantInicial) * 0.05;
                                text = "A porcentagem que restou \n"
                                        "foi de $porcentagem% \n"
                                        "Para o proximo abastecimento \n"
                                        "colocar " +
                                    valor.toString() +
                                    " kg";
                              } else if (double.parse(porcentagem) >= 15) {
                                double valor = double.parse(quantInicial) -
                                    double.parse(quantInicial) * 0.1;
                                text = "A porcentagem que restou \n"
                                        "foi de $porcentagem% \n"
                                        "Para o proximo abastecimento \n"
                                        "colocar " +
                                    valor.toString() +
                                    " kg";
                              }
                            });
                            double porcent = (100 * double.parse(quantFinal)) /
                                double.parse(quantInicial);
                            String porcentagem = porcent.toStringAsFixed(2);
                            DateTime d = DateTime.now();
                            data = d.toString();
                            Registro r = Registro(aluno, cocho, quantInicial,
                                quantFinal, porcentagem, data);
                            insertRegistro(r);
                            clearText();
                          },
                          child: const Text('Calcular'),
                          style: ElevatedButton.styleFrom(
                            fixedSize: const Size(100, 50),
                            primary: Colors.green,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                      ),
                    ),
                    Text(
                      text,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ),
          ],
        )),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
