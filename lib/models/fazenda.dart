class Fazenda {
  late String nome;
  late String codigo;
  late String usuario;

  Fazenda(this.nome, this.codigo, this.usuario);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'codigo': codigo,
      'usuario': usuario
    };
    return map;
  }

  Fazenda.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    codigo = map['codigo'];
    usuario = map["usuario"];
  }

  Fazenda.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    codigo = json['codigo'];
    usuario = json['usuario'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['codigo'] = codigo;
    data['usuario'] = usuario;
    return data;
  }
}
