import 'package:chat_v2/models/message.dart';
import 'package:chat_v2/services/database/idatabase_service.dart';
import 'package:mobx/mobx.dart';
import 'package:uuid/uuid.dart';

part 'input_form.store.g.dart';

class InputFormStore = InputFormStoreBase with _$InputFormStore;

abstract class InputFormStoreBase with Store {
  InputFormStoreBase({required this.databaseService});
  final IDatabaseService databaseService;

  @observable
  bool _isWriting = false;

  @observable
  String _text = '';

  @observable
  ObservableFuture<List<Message>> _futureMessages = ObservableFuture.value([]);

  @observable
  ObservableList<Message> _messages = ObservableList<Message>();

  @computed
  String get text => _text;

  @computed
  bool get isWriting => _isWriting;

  @computed
  FutureStatus get status => _futureMessages.status;

  @computed
  List<Message> get messages => _messages;

  set isWriting(bool value) => _isWriting = value;
  set text(String value) => _text = value;

  @action
  Future<void> fetchMessages() async {
    _futureMessages = ObservableFuture(databaseService.messages.first);
    final stream = databaseService.messages;
    stream.listen((data) => _messages = ObservableList.of(data));
  }

  @action
  Future<void> sendMessage() async {
    final message = Message(
      id: Uuid().v4(),
      text: text,
      createAt: DateTime.now(),
    );
    await databaseService.sendMessage(message);
    clearForm();
  }

  @action
  void clearForm() {
    _isWriting = false;
    _text = '';
  }

  @action
  Future<void> init() async {
    await fetchMessages();
  }
}
