import 'package:mobx/mobx.dart';

part 'contador_store.g.dart';

class ContadorStore = ContadorStoreBase with _$ContadorStore;

abstract class ContadorStoreBase with Store {
  @observable
  int contador = 0;

  @action
  void incrementar() => contador++;
}
