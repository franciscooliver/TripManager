// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailsController on _DetailsControllerBase, Store {
  Computed<int> _$listLenghtComputed;

  @override
  int get listLenght =>
      (_$listLenghtComputed ??= Computed<int>(() => super.listLenght)).value;

  final _$detailListAtom = Atom(name: '_DetailsControllerBase.detailList');

  @override
  ObservableList<Details> get detailList {
    _$detailListAtom.context.enforceReadPolicy(_$detailListAtom);
    _$detailListAtom.reportObserved();
    return super.detailList;
  }

  @override
  set detailList(ObservableList<Details> value) {
    _$detailListAtom.context.conditionallyRunInAction(() {
      super.detailList = value;
      _$detailListAtom.reportChanged();
    }, _$detailListAtom, name: '${_$detailListAtom.name}_set');
  }

  final _$countPassingsAtom =
      Atom(name: '_DetailsControllerBase.countPassings');

  @override
  int get countPassings {
    _$countPassingsAtom.context.enforceReadPolicy(_$countPassingsAtom);
    _$countPassingsAtom.reportObserved();
    return super.countPassings;
  }

  @override
  set countPassings(int value) {
    _$countPassingsAtom.context.conditionallyRunInAction(() {
      super.countPassings = value;
      _$countPassingsAtom.reportChanged();
    }, _$countPassingsAtom, name: '${_$countPassingsAtom.name}_set');
  }

  final _$deleteAsyncAction = AsyncAction('delete');

  @override
  Future<bool> delete(int id) {
    return _$deleteAsyncAction.run(() => super.delete(id));
  }

  final _$setPaymentAsyncAction = AsyncAction('setPayment');

  @override
  Future<int> setPayment(Details details) {
    return _$setPaymentAsyncAction.run(() => super.setPayment(details));
  }

  final _$_DetailsControllerBaseActionController =
      ActionController(name: '_DetailsControllerBase');

  @override
  dynamic setList(int tripId) {
    final _$actionInfo = _$_DetailsControllerBaseActionController.startAction();
    try {
      return super.setList(tripId);
    } finally {
      _$_DetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic save(Details detail) {
    final _$actionInfo = _$_DetailsControllerBaseActionController.startAction();
    try {
      return super.save(detail);
    } finally {
      _$_DetailsControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'detailList: ${detailList.toString()},countPassings: ${countPassings.toString()},listLenght: ${listLenght.toString()}';
    return '{$string}';
  }
}
