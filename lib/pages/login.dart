import 'package:flutter/material.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/usuario.dart';
import 'package:leitura_cocho/models/usuarioAtual.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() {
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  late String usuario;
  late String senha;
  final fieldTextUsuario = TextEditingController();
  final fieldTextSenha = TextEditingController();
  String text = "";

  DatabaseHelper db = DatabaseHelper();
  List<Usuario> usuarios = <Usuario>[];

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
                    Container(
                      margin: const EdgeInsets.only(
                        top: 10,
                      ),
                      child: TextField(
                        obscureText: true,
                        onChanged: (senhaText) {
                          senha = senhaText;
                        },
                        keyboardType: TextInputType.visiblePassword,
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
                          onPressed: () async {
                            
                            Usuario? user = await db.getUsuario(usuario, senha);

                            if(user != null){
                              setState(() {
                                UsuarioAtual.nome = user.nome;
                                UsuarioAtual.usuario = user.usuario;
                              }); 
                              Navigator.of(context).pushReplacementNamed('/home');
                            }else{
                              setState(() {
                                text = "Usuário ou senha inválidos";
                              });
                            }
                          },
                          child: const Text('Acessar'),
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
                    Container(
                      margin: const EdgeInsets.only(top: 10),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Text(
                            "Não tem uma conta ",
                            textAlign: TextAlign.center,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 20),
                          ),
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                UsuarioAtual.nome = "novo";
                              });
                              Navigator.of(context)
                                  .pushReplacementNamed('/register');
                            },
                            child: const Text(
                              "Cadastre",
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 20),
                            ),
                          )
                        ],
                      ),
                    ),
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
