// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$ApiStore on ApiStoreBase, Store {
  Computed<List<Map<String, dynamic>>>? _$apiDataComputed;

  @override
  List<Map<String, dynamic>> get apiData =>
      (_$apiDataComputed ??= Computed<List<Map<String, dynamic>>>(
        () => super.apiData,
        name: 'ApiStoreBase.apiData',
      )).value;
  Computed<FutureStatus>? _$statusComputed;

  @override
  FutureStatus get status => (_$statusComputed ??= Computed<FutureStatus>(
    () => super.status,
    name: 'ApiStoreBase.status',
  )).value;

  late final _$_apiFutureDataAtom = Atom(
    name: 'ApiStoreBase._apiFutureData',
    context: context,
  );

  @override
  ObservableFuture<Map<String, dynamic>> get _apiFutureData {
    _$_apiFutureDataAtom.reportRead();
    return super._apiFutureData;
  }

  @override
  set _apiFutureData(ObservableFuture<Map<String, dynamic>> value) {
    _$_apiFutureDataAtom.reportWrite(value, super._apiFutureData, () {
      super._apiFutureData = value;
    });
  }

  late final _$_apiDataAtom = Atom(
    name: 'ApiStoreBase._apiData',
    context: context,
  );

  @override
  ObservableList<Map<String, dynamic>> get _apiData {
    _$_apiDataAtom.reportRead();
    return super._apiData;
  }

  @override
  set _apiData(ObservableList<Map<String, dynamic>> value) {
    _$_apiDataAtom.reportWrite(value, super._apiData, () {
      super._apiData = value;
    });
  }

  late final _$errorMessageAtom = Atom(
    name: 'ApiStoreBase.errorMessage',
    context: context,
  );

  @override
  String get errorMessage {
    _$errorMessageAtom.reportRead();
    return super.errorMessage;
  }

  @override
  set errorMessage(String value) {
    _$errorMessageAtom.reportWrite(value, super.errorMessage, () {
      super.errorMessage = value;
    });
  }

  late final _$getApiDataAsyncAction = AsyncAction(
    'ApiStoreBase.getApiData',
    context: context,
  );

  @override
  Future<List<Map<String, dynamic>>> getApiData() {
    return _$getApiDataAsyncAction.run(() => super.getApiData());
  }

  @override
  String toString() {
    return '''
errorMessage: ${errorMessage},
apiData: ${apiData},
status: ${status}
    ''';
  }
}
