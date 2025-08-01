import 'package:mobx/mobx.dart';

part 'input_form.store.g.dart';

class InputFormStore = InputFormStoreBase with _$InputFormStore;

abstract class InputFormStoreBase with Store {
  @observable
  bool isWriting = false;
}
