import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leitura_cocho/helpers/api_helpers.dart';
import '../helpers/database_helpers.dart';
import '../models/registro.dart';
import 'list_tile_custom.dart';

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

  void insertRegistro(Registro r) {
    db.insertRegistro(r);
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

    // Custom Toast Position
    fToast.showToast(
        child: toast,
        toastDuration: const Duration(seconds: 2),
        positionedToastBuilder: (context, child) {
          return Positioned(
            child: child,
            top: 16.0,
            left: 16.0,
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
          margin: const EdgeInsets.all(30),
          child: SizedBox(
            child: ListView(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const Text(
                      'Enviar dados',
                      style: TextStyle(fontSize: 20),
                    ),
                    IconButton(
                      icon: const Icon(Icons.send),
                      onPressed: () async {
                        try {
                          for (int i = 0; i < registros.length; i++) {
                            var r = registros[i].toJson();
                            ApiHelpers.send(r);
                          }
                          db.deleteRegistros();
                          var response = await ApiHelpers.fetch();
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
                            insertRegistro(r);
                          }
                        } catch (e) {
                          registros;
                        }
                        _showToast();
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Text('Leitura de Cocho'),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
