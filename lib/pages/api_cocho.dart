class Cocho {
  String? aluno;
  String? cocho;
  double? qauntInical;
  double? quantFinal;
  double? porcentagem;
  String? data;

  Cocho(
      {this.aluno,
      this.cocho,
      this.qauntInical,
      this.quantFinal,
      this.porcentagem,
      this.data});

  Cocho.fromJson(Map<String, dynamic> json) {
    aluno = json['aluno'];
    cocho = json['cocho'];
    qauntInical = json['quant_inical'];
    quantFinal = json['quant_final'];
    porcentagem = json['porcentagem'];
    data = json['data'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['aluno'] = aluno;
    data['cocho'] = cocho;
    data['quant_inical'] = qauntInical;
    data['quant_final'] = quantFinal;
    data['porcentagem'] = porcentagem;
    data['data'] = this.data;
    return data;
  }
}
