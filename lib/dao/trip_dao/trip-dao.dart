import 'package:checked_list/dao/base-dao.dart';
import 'package:checked_list/models/trip.dart';

class TripeDAO extends BaseDAO<Trip> {
  @override
  // TODO: implement tableName
  String get tableName => "trips";

  @override
  Trip fromMap(Map<String, dynamic> map) {
    // TODO: implement fromMap
    return Trip.fromMap(map);
  }

  Future<int> deleteTrip(int id) async {
    var dbClient = await db;

    int res = await dbClient
        .rawDelete('delete from passageiros where trip_id = ?', [id]);
    
      return await dbClient
          .rawDelete('delete from $tableName where id = ?', [id]);
    
  }
}
