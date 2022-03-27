import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/fazenda.dart';
import 'package:leitura_cocho/models/usuarioAtual.dart';

class FazendaCreatePage extends StatefulWidget {
  const FazendaCreatePage({Key? key}) : super(key: key);

  @override
  State<FazendaCreatePage> createState() {
    return FazendaCreatePageState();
  }
}

class FazendaCreatePageState extends State<FazendaCreatePage> {
  late String fazenda;
  late String codigo;
  final fieldFazenda = TextEditingController();
  final fieldCodigo = TextEditingController();
  DatabaseHelper db = DatabaseHelper();

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
                      borderSide: const BorderSide(width: 3, color: Colors.red),
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
                      borderSide: const BorderSide(width: 3, color: Colors.red),
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
                      //Navigator.of(context).pushReplacementNamed('/home');
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
    );
  }
}
