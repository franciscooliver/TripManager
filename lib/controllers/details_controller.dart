import 'package:checked_list/dao/details_dao/details_dao.dart';
import 'package:checked_list/models/details.dart';
import 'package:mobx/mobx.dart';
part 'details_controller.g.dart';

class DetailsController = _DetailsControllerBase with _$DetailsController;

abstract class _DetailsControllerBase with Store {
  @observable
  ObservableList<Details> detailList = ObservableList<Details>();

  @observable
  int countPassings = 0;


  @computed
  int get listLenght => detailList.length;

  @action
  setList(int tripId) {
    findAll(tripId).then((viagens) {
       detailList.clear();
      for (var item in viagens) {
        this.detailList.add(item);
      }
      _updateCount();
    });
  }

  @action
  save(Details detail) {
    final _detailsDao = new DetailsDao();

    _detailsDao.save(detail);
    // detailList.insert(0, detail);
    setList(detail.trip_id);
    _updateCount();
  }

  Future<List<Details>> findAll(int tripId) async {
    final _tripDao = DetailsDao();
    // final List<Details> list = await _tripDao.findAll();
    final List<Details> list = await _tripDao.getPassingsByTrip(tripId);
    // final List<Details> list = await _tripDao.findAll();

    return list;
  }

  @action
  Future<bool> delete(int id) async {
    print('ID_DELETED: $id');
    final _tripDao = DetailsDao();
    int _id = await _tripDao.delete(id);
  
      // detailList.firstWhere((viagem) => viagem.id == id, orElse: () => null);
    if (_id == 1) {
      detailList.removeWhere((item) => item.id == id);

      _updateCount();
      return true;
    }

    return false;
  }

  void _updateCount() {
    countPassings = detailList.length;
  }

  @action
  Future<int> setPayment(Details details) async {
    print('Setando pagamento...toPay: ${details.to_pay}');
    final _tripDao = DetailsDao();
    final res = await _tripDao.update(details);

    print('Resposta update: $res');

    return res;

  }
}
