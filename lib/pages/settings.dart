import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:leitura_cocho/helpers/api_fazenda.dart';
import 'package:leitura_cocho/helpers/api_registro.dart';
import 'package:leitura_cocho/helpers/api_usuario.dart';
import 'package:leitura_cocho/helpers/database_helpers.dart';
import 'package:leitura_cocho/models/fazenda.dart';
import 'package:leitura_cocho/models/registro.dart';
import 'package:leitura_cocho/models/usuario.dart';
import 'package:leitura_cocho/models/usuarioAtual.dart';
import 'package:leitura_cocho/pages/components/list_tile_custom.dart';

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
  List<Fazenda> fazendas = <Fazenda>[];
  List<Usuario> usuarios = <Usuario>[];
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

    db.getFazendas().then((lista) {
      setState(() {
        fazendas = lista;
      });
    });

    db.getUsuarios().then((lista) {
      setState(() {
        usuarios = lista;
      });
    });
  }

  Future<int> insertRegistro(Registro r) async {
    var result = await db.insertRegistro(r);
    return result;
  }

  Future<int> insertFazenda(Fazenda f) async {
    var result = await db.insertFazenda(f);
    return result;
  }

  Future<int> insertUsuario(Usuario u) async {
    var result = await db.insertUsuario(u);
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
                    margin:
                        const EdgeInsets.only(bottom: 20, left: 30, right: 30),
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
                            ApiHelpersRegistro.send(r);
                          }
                          var response = await ApiHelpersRegistro.fetch();
                          var result = 0;
                          for (int i = 0; i < response.length; i++) {
                            var item = response[i] as Map;
                            String cocho = item['cocho'];
                            String quantInicial = item['quant_inicial'];
                            String quantFinal = item['quant_final'];
                            String porcentagem = item['porcentagem'];
                            String data = item['data'];
                            String usuario = item['usuario'];
                            String fazendaNome = item['fazenda'];
                            String fazendaCodigo = item['fazendaCodigo'];

                            Registro r = Registro(
                                UsuarioAtual.nome,
                                cocho,
                                quantInicial,
                                quantFinal,
                                porcentagem,
                                data,
                                fazendaNome,
                                usuario,
                                fazendaCodigo);
                            result = await insertRegistro(r);

                            if (result == 1) {
                              true;
                            }
                          }
                        } catch (e) {
                          registros;
                        }

                        try {
                          for (int i = 0; i < fazendas.length; i++) {
                            var f = fazendas[i].toJson();
                            ApiHelpersFazenda.send(f);
                          }
                          var response = await ApiHelpersFazenda.fetch();
                          var result = 0;
                          for (int i = 0; i < response.length; i++) {
                            var item = response[i] as Map;
                            String nome = item['nome'];
                            String codigo = item['codigo'];
                            String usuario = item['usuario'];
                            Fazenda f = Fazenda(nome, codigo, usuario);
                            result = await insertFazenda(f);

                            if (result == 1) {
                              true;
                            }
                          }
                        } catch (e) {
                          registros;
                        }

                        try {
                          for (int i = 0; i < usuarios.length; i++) {
                            var r = usuarios[i].toJson();
                            ApiHelpersUsuario.send(r);
                          }
                          var response = await ApiHelpersUsuario.fetch();
                          var result = 0;
                          for (int i = 0; i < response.length; i++) {
                            var item = response[i] as Map;
                            String nome = item['nome'];
                            String usuario = item['usuario'];
                            String senha = item['senha'];

                            Usuario u = Usuario(nome, usuario, senha);
                            result = await insertUsuario(u);

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
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(18),
                          ),
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
