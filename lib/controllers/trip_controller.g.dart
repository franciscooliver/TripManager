// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'trip_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$TripController on _TripControllerBase, Store {
  final _$tripsAtom = Atom(name: '_TripControllerBase.trips');

  @override
  ObservableList<Trip> get trips {
    _$tripsAtom.context.enforceReadPolicy(_$tripsAtom);
    _$tripsAtom.reportObserved();
    return super.trips;
  }

  @override
  set trips(ObservableList<Trip> value) {
    _$tripsAtom.context.conditionallyRunInAction(() {
      super.trips = value;
      _$tripsAtom.reportChanged();
    }, _$tripsAtom, name: '${_$tripsAtom.name}_set');
  }

  final _$_TripControllerBaseActionController =
      ActionController(name: '_TripControllerBase');

  @override
  dynamic addTrip(Trip trip) {
    final _$actionInfo = _$_TripControllerBaseActionController.startAction();
    try {
      return super.addTrip(trip);
    } finally {
      _$_TripControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic getTrips() {
    final _$actionInfo = _$_TripControllerBaseActionController.startAction();
    try {
      return super.getTrips();
    } finally {
      _$_TripControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string = 'trips: ${trips.toString()}';
    return '{$string}';
  }
}
