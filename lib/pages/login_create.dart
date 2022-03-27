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
  late String confirmar;
  late String nome;
  String text = '';
  final fieldTextUsuario = TextEditingController();
  final fieldTextSenha = TextEditingController();
  final fieldTextNome = TextEditingController();
  final fieldTextConfirmar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
          child: ListView(
        children: [
          Center(
            heightFactor: 1.5,
            child: Container(
              margin: const EdgeInsets.all(30),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  children: [
                    Container(
                      margin: const EdgeInsets.only(
                        bottom: 10,
                      ),
                      child: Text(
                        text,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 15),
                      ),
                    ),
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
                        obscureText: true,
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
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TextField(
                        obscureText: true,
                        onChanged: (confirmarText) {
                          confirmar = confirmarText;
                        },
                        keyboardType: TextInputType.text,
                        decoration: InputDecoration(
                            labelText: 'confirmar senha',
                            enabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 3, color: Colors.blue),
                                borderRadius: BorderRadius.circular(15)),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                                  const BorderSide(width: 3, color: Colors.red),
                              borderRadius: BorderRadius.circular(15),
                            )),
                        controller: fieldTextConfirmar,
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
                            if (senha == confirmar) {
                              Navigator.of(context)
                                  .pushReplacementNamed('/login');
                            }else {
                              setState(() {
                                text = "As senhas não conferem";
                              });
                              
                            }
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
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      )),
    );
  }
}
