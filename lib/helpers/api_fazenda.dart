import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiHelpersFazenda {
  static Future<List> fetch() async {
    var url =
        Uri.parse('https://api-rest-leitura-cocho.herokuapp.com/api/fazendas');
    var response = await http.get(url);
    List json = jsonDecode(response.body) as List;
    return json;
  }

  static Future send(dynamic registro) async {
    try {
      var url = Uri.parse(
          'https://api-rest-leitura-cocho.herokuapp.com/api/fazenda');
      var _body = json.encode(registro);
      await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: _body,
      );
      // ignore: empty_catches
    } catch (e) {}
  }
}
