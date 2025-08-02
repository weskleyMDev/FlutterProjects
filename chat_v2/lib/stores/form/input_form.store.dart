import 'dart:io';

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
  ObservableMap<String, dynamic> _formData = ObservableMap<String, dynamic>();

  @observable
  File? _file;

  @observable
  ObservableStream<List<Message>> _messages = ObservableStream<List<Message>>(
    Stream.empty(),
  );

  @computed
  Map<String, dynamic> get formData => _formData;

  @computed
  bool get isWriting => _isWriting;

  @computed
  File? get file => _file;

  @computed
  Stream<List<Message>> get messages => _messages;

  set isWriting(bool value) => _isWriting = value;
  set formData(Map<String, dynamic> value) => _formData = value.asObservable();
  set file(File? value) => _file = value;

  @action
  Future<void> fetchMessages() async {
    _messages = ObservableStream(databaseService.messages);
  }

  @action
  Future<void> sendMessage() async {
    final message = Message(
      id: Uuid().v4(),
      text: formData['text'],
      imageUrl: formData['imageUrl'],
      createAt: DateTime.now(),
    );
    await databaseService.sendMessage(message);
    clearForm();
  }

  @action
  void clearForm() {
    _isWriting = false;
    _formData.clear();
  }

  @action
  Future<void> init() async {
    await fetchMessages();
  }
}
