class Registro {
  late String aluno;
  late String cocho;
  late String quantInicial;
  late String quantFinal;
  late String porcentagem;
  late String data;
  late String fazenda;
  late String usuario;
  late String fazendaCodigo;

  Registro(this.aluno, this.cocho, this.quantInicial, this.quantFinal,
      this.porcentagem, this.data, this.fazenda, this.usuario, this.fazendaCodigo);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'aluno': aluno,
      'cocho': cocho,
      'quant_inicial': quantInicial,
      'quant_final': quantFinal,
      'porcentagem': porcentagem,
      'data': data,
      'fazenda':fazenda,
      'usuario':usuario,
      'fazendaCodigo':fazendaCodigo,
    };
    return map;
  }

  Registro.fromMap(Map<String, dynamic> map) {
    aluno = map['aluno'];
    cocho = map['cocho'];
    quantInicial = map["quant_inicial"];
    quantFinal = map['quant_final'];
    porcentagem = map['porcentagem'];
    data = map['data'];
    fazenda = map['fazenda'];
    usuario = map['usuario'];
    fazendaCodigo = map['fazendaCodigo'];
  }

  Registro.fromJson(Map<String, dynamic> json) {
    aluno = json['aluno'];
    cocho = json['cocho'];
    quantInicial = json['quant_inicial'];
    quantFinal = json['quant_final'];
    porcentagem = json['porcentagem'];
    data = json['data'];
    fazenda = json['fazenda'];
    usuario = json['usuario'];
    fazendaCodigo = json['fazendaCodigo'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aluno'] = aluno;
    data['cocho'] = cocho;
    data['quant_inicial'] = quantInicial;
    data['quant_final'] = quantFinal;
    data['porcentagem'] = porcentagem;
    data['data'] = this.data;
    data['fazenda'] = fazenda;
    data['usuario'] = usuario;
    data['fazendaCodigo'] = fazendaCodigo;
    return data;
  }
}
