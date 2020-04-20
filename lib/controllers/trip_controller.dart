import 'package:checked_list/dao/trip_dao/trip-dao.dart';
import 'package:checked_list/models/trip.dart';
import 'package:mobx/mobx.dart';
part 'trip_controller.g.dart';

class TripController = _TripControllerBase with _$TripController;

abstract class _TripControllerBase with Store {
  @observable
  ObservableList<Trip> trips = ObservableList<Trip>();

  @action
  addTrip(Trip trip) {
    this.save(trip);
  }

  @action
  getTrips() {
    this.findAll().then((trips) {
      this.trips.clear();
      for (var trip in trips) {
        this.trips.add(trip);
        print('Id: ${trip.id}');
      }
    });
  }

  save(Trip trip) async {
    final _tripDao = TripeDAO();
    int id = await _tripDao.save(trip);
    this.getTrips();
    // if(id > 0 ){
    //   this.trips.insert(0,trip);
      
    // }
  }

  Future<bool> delete(int id) async {
    print('ID_DELETED: $id');
    final _tripDao = TripeDAO();
    int _id = await _tripDao.deleteTrip(id);
    Trip _viagem = trips.firstWhere((viagem) =>  viagem.id == id, orElse: () => null);
    if(_id == 1){
      trips.removeWhere((item) => item.id == id);
      print('Viagem ${_viagem.nome} removida');
      return true;
    }

    return false;
  }

  Future<List<Trip>> findAll() async {
    final _tripDao = TripeDAO();
    final List<Trip> tripsList = await _tripDao.findAll();

    return tripsList;
  }
}
