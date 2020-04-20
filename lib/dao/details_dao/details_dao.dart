import 'package:checked_list/models/details.dart';

import '../base-dao.dart';

class DetailsDao extends BaseDAO<Details> {
  @override
  String get tableName => "passageiros";

  @override
  Details fromMap(Map<String, dynamic> map) {
    return Details.fromMap(map);
  }

  Future<List<Details>> getPassingsByTrip(int tripId) async {
    final dbClient = await db;

    // final list = await dbClient.rawQuery('select * from carro where tipo =? ', [tipo]);
    final list = await dbClient.query(tableName,
        where: 'trip_id = ?', whereArgs: [tripId], orderBy: 'id DESC');
    return list.map<Details>((json) => fromMap(json)).toList();
  }

  Future<int> update(Details details) async {
    final dbClient = await db;
    return await dbClient.update('passageiros', details.toMap(), where: "id = ?", whereArgs: [details.id]);
  }
}
