import 'package:checked_list/dao/entity.dart';

class Details extends Entity {
  int id;
  String pnome;
  String psobrenome;
  int to_pay;
  int trip_id;


  Details({this.pnome, this.psobrenome, this.to_pay, this.trip_id});

  Details.fromMap(Map<String, dynamic> json) {
    id = json['id'];
    pnome = json['pnome'];
    psobrenome = json['psobrenome'];
    to_pay = json['to_pay'];
    trip_id = json['trip_id'];
  
  }

  @override
  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['pnome'] = this.pnome;
    data['psobrenome'] = this.psobrenome;
    data['to_pay'] = this.to_pay;
    data['trip_id'] = this.trip_id;
    
    return data;
  }
}