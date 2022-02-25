import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leitura_cocho/helpers/api_helpers.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/pages/list_tile_custom.dart';

class SetttingPage extends StatefulWidget {
  const SetttingPage({Key? key}) : super(key: key);

  @override
  State<SetttingPage> createState() {
    return SetttingPageState();
  }
}

class SetttingPageState extends State<SetttingPage> {
  late FToast fToast;
  DatabaseHelper db = DatabaseHelper();
  List<Registro> registros = <Registro>[];
  bool atualizado = false;

  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);

    db.getRegistros().then((lista) {
      setState(() {
        registros = lista;
      });
    });
  }

  Future<int> insertRegistro(Registro r) async {
    var result = await db.insertRegistro(r);
    return result;
  }

  _showToast() {
    Widget toast = Container(
      padding: const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(25.0),
        color: const Color.fromARGB(255, 252, 252, 252),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: const [
          Icon(Icons.check),
          SizedBox(
            width: 12.0,
          ),
          Text("Registros Atualizados"),
        ],
      ),
    );

    fToast.showToast(
      child: toast,
      gravity: ToastGravity.BOTTOM,
      toastDuration: const Duration(seconds: 2),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          children: [
            if (atualizado) ...[
              Expanded(
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 0,
                    ),
                    child: const SizedBox(
                      child: CircularProgressIndicator(),
                      height: 100,
                      width: 100,
                    ),
                  ),
                ),
              ),
            ] else ...[
              Expanded(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    margin: const EdgeInsets.only(
                      bottom: 20,
                    ),
                    child: ElevatedButton(
                      child: const Text(
                        'Atualizar dados',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 24),
                      ),
                      onPressed: () async {
                        setState(() {
                          atualizado = true;
                        });
                        try {
                          for (int i = 0; i < registros.length; i++) {
                            var r = registros[i].toJson();
                            ApiHelpers.send(r);
                          }
                          db.deleteRegistros();
                          var response = await ApiHelpers.fetch();
                          var result = 0;
                          for (int i = 0; i < response.length; i++) {
                            var item = response[i] as Map;
                            String aluno = item['aluno'];
                            String cocho = item['cocho'];
                            String quantInicial = item['quant_inicial'];
                            String quantFinal = item['quant_final'];
                            String porcentagem = item['porcentagem'];
                            String data = item['data'];

                            Registro r = Registro(aluno, cocho, quantInicial,
                                quantFinal, porcentagem, data);
                            result = await insertRegistro(r);

                            if (result == 1) {
                              true;
                            }
                          }
                          setState(() {
                            atualizado = false;
                            _showToast();
                          });
                        } catch (e) {
                          registros;
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          fixedSize: const Size(400, 50),
                          //shape: const CircleBorder(),
                          primary: Colors.green),
                    ),
                  ),
                ),
              ),
            ],
          ],
        ),
        appBar: AppBar(
          title: const Text('Leitura de Cocho'),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
