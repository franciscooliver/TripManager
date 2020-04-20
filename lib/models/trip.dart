import 'package:checked_list/dao/entity.dart';

class Trip extends Entity {
  int id;
  String nome;
  String dataViagem; 

  Trip({this.id, this.nome, this.dataViagem});

  Trip.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    nome = json['nome'];
    dataViagem = json['dataViagem'];
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['nome'] = this.nome;
    data['dataViagem'] = this.dataViagem;

    return data;
  }
}