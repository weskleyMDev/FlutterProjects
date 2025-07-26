import 'package:mobx/mobx.dart';

import '../../services/api/iapi_service.dart';

part 'api.store.g.dart';

class ApiStore = ApiStoreBase with _$ApiStore;

abstract class ApiStoreBase with Store {
  ApiStoreBase({required this.apiService});
  final IApiService apiService;

  @observable
  ObservableFuture<Map<String, dynamic>> _apiFutureData =
      ObservableFuture.value({});

  @observable
  ObservableList<Map<String, dynamic>> _apiData = ObservableList();

  @observable
  String errorMessage = '';

  @computed
  List<Map<String, dynamic>> get apiData => List.unmodifiable(_apiData);

  @computed
  FutureStatus get status => _apiFutureData.status;

  @action
  Future<List<Map<String, dynamic>>> getApiData() async {
    try {
      _apiFutureData = ObservableFuture(apiService.getData());
      final Map<String, dynamic> data = await _apiFutureData;
      _apiData
        ..clear()
        ..addAll(List.from(data['data']));
      return _apiData;
    } catch (e) {
      errorMessage = e.toString();
      return [];
    }
  }
}
