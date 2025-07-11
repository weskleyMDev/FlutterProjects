import 'package:mobx/mobx.dart';

part 'counter.store.g.dart';

class CounterStore = CounterStoreBase with _$CounterStore;

abstract class CounterStoreBase with Store {
  @observable
  int _counter = 0;

  @computed
  int get count => _counter;

  @action
  void increment() => _counter++;

  @action
  void decrement() => _counter--;
}
