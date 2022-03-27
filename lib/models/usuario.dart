class Usuario {
  late String nome;
  late String usuario;
  late String senha;

  Usuario(this.nome, this.usuario, this.senha);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nome': nome,
      'usuario': usuario,
      'senha': senha
    };
    return map;
  }

  Usuario.fromMap(Map<String, dynamic> map) {
    nome = map['nome'];
    usuario = map['usuario'];
    senha = map["senha"];
  }

  Usuario.fromJson(Map<String, dynamic> json) {
    nome = json['nome'];
    usuario = json['usuario'];
    senha = json['senha'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['nome'] = nome;
    data['usuario'] = usuario;
    data['senha'] = senha;
    return data;
  }
}
