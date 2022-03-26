import 'package:flutter/material.dart';
import 'package:leitura_cocho/pages/components/list_tile_custom.dart';

class LoginCreatePage extends StatefulWidget {
  const LoginCreatePage({Key? key}) : super(key: key);

  @override
  State<LoginCreatePage> createState() {
    return LoginCreatePageState();
  }
}

class LoginCreatePageState extends State<LoginCreatePage> {
  late String usuario;
  late String senha;
  late String nome;
  final fieldTextUsuario = TextEditingController();
  final fieldTextSenha = TextEditingController();
  final fieldTextNome = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SizedBox(
            child: ListView(
          children: [
            Center(
              heightFactor: 2,
              child: Container(
                margin: const EdgeInsets.all(30),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      TextField(
                        onChanged: (nomeText) {
                          nome = nomeText;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'Nome',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: fieldTextNome,
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextField(
                          onChanged: (usuarioText) {
                            usuario = usuarioText;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'usuário',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          controller: fieldTextUsuario,
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(
                          top: 10,
                        ),
                        child: TextField(
                          onChanged: (senhaText) {
                            senha = senhaText;
                          },
                          keyboardType: TextInputType.text,
                          decoration: InputDecoration(
                              labelText: 'Senha',
                              enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      width: 3, color: Colors.blue),
                                  borderRadius: BorderRadius.circular(15)),
                              focusedBorder: OutlineInputBorder(
                                borderSide:
                                    const BorderSide(width: 3, color: Colors.red),
                                borderRadius: BorderRadius.circular(15),
                              )),
                          controller: fieldTextSenha,
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
                              Navigator.of(context).pushReplacementNamed('/login');
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
                      Text(
                        "Sucesso",
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      )
                    ],
                  ),
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
