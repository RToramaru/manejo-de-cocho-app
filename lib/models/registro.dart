class Registro {
  late String aluno;
  late String cocho;
  late String quantInicial;
  late String quantFinal;
  late String porcentagem;
  late String data;

  Registro(this.aluno, this.cocho, this.quantInicial, this.quantFinal,
      this.porcentagem, this.data);

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'aluno': aluno,
      'cocho': cocho,
      'quant_inicial': quantInicial,
      'quant_final': quantFinal,
      'porcentagem': porcentagem,
      'data': data
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
  }

  Registro.fromJson(Map<String, dynamic> json) {
    aluno = json['aluno'];
    cocho = json['cocho'];
    quantInicial = json['quant_inicial'];
    quantFinal = json['quant_final'];
    porcentagem = json['porcentagem'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aluno'] = aluno;
    data['cocho'] = cocho;
    data['quant_inicial'] = quantInicial;
    data['quant_final'] = quantFinal;
    data['porcentagem'] = porcentagem;
    data['data'] = this.data;
    return data;
  }
}
