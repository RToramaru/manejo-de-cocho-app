import 'package:flutter/material.dart';
import 'package:leitura_cocho/pages/components/list_tile_custom.dart';
import 'package:leitura_cocho/models/fazenda.dart';
import 'package:leitura_cocho/models/usuarioAtual.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class FazendaPage extends StatefulWidget {
  const FazendaPage({Key? key}) : super(key: key);

  @override
  State<FazendaPage> createState() {
    return FazendaPageState();
  }
}

class FazendaPageState extends State<FazendaPage> {
  late FToast fToast;
  late String fazenda;
  late String codigo;
  final fieldFazenda = TextEditingController();
  final fieldCodigo = TextEditingController();
  DatabaseHelper db = DatabaseHelper();


  @override
  void initState() {
    super.initState();
    fToast = FToast();
    fToast.init(context);
  }

void clearText() {
    fieldFazenda.clear();
    fieldCodigo.clear();
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
          Text("Fazenda cadastrada"),
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
        body: Container(
          margin: const EdgeInsets.all(30),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                TextField(
                  onChanged: (codigoText) {
                    codigo = codigoText;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Código da fazenda',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  controller: fieldCodigo,
                ),
                Container(
                  margin: const EdgeInsets.only(top: 10),
                ),
                TextField(
                  onChanged: (fazendaText) {
                    fazenda = fazendaText;
                  },
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                      labelText: 'Fazenda',
                      enabledBorder: OutlineInputBorder(
                          borderSide:
                              const BorderSide(width: 3, color: Colors.blue),
                          borderRadius: BorderRadius.circular(15)),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            const BorderSide(width: 3, color: Colors.red),
                        borderRadius: BorderRadius.circular(15),
                      )),
                  controller: fieldFazenda,
                ),
                SizedBox(
                  width: double.infinity,
                  child: Container(
                    margin: const EdgeInsets.only(
                      top: 10,
                    ),
                    child: ElevatedButton(
                      onPressed: () async{
                      Fazenda f = Fazenda(fazenda, codigo, UsuarioAtual.usuario);
                      var result = await db.insertFazenda(f);
                      clearText();
                      _showToast();
                    },
                      child: const Text('Cadastrar'),
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
              ],
            ),
          ),
        ),
        appBar: AppBar(
          title: const Center(child: Text('Leitura de Cocho')),
          backgroundColor: const Color.fromARGB(255, 1, 39, 1),
        ),
        drawer: const ListTileCustom());
  }
}
