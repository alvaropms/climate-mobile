// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Api on _Api, Store {
  final _$dataAtom = Atom(name: '_Api.data');

  @override
  CurrentWeather get data {
    _$dataAtom.reportRead();
    return super.data;
  }

  @override
  set data(CurrentWeather value) {
    _$dataAtom.reportWrite(value, super.data, () {
      super.data = value;
    });
  }

  final _$isLoadingAtom = Atom(name: '_Api.isLoading');

  @override
  bool get isLoading {
    _$isLoadingAtom.reportRead();
    return super.isLoading;
  }

  @override
  set isLoading(bool value) {
    _$isLoadingAtom.reportWrite(value, super.isLoading, () {
      super.isLoading = value;
    });
  }

  final _$getWeatherDataAsyncAction = AsyncAction('_Api.getWeatherData');

  @override
  Future<dynamic> getWeatherData() {
    return _$getWeatherDataAsyncAction.run(() => super.getWeatherData());
  }

  final _$_ApiActionController = ActionController(name: '_Api');

  @override
  Future<dynamic> getWeatherDataByCity(String city) {
    final _$actionInfo =
        _$_ApiActionController.startAction(name: '_Api.getWeatherDataByCity');
    try {
      return super.getWeatherDataByCity(city);
    } finally {
      _$_ApiActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
data: ${data},
isLoading: ${isLoading}
    ''';
  }
}
