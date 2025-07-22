import 'package:decimal/decimal.dart';
import 'package:mobx/mobx.dart';

import '../models/payment.dart';

part 'payment.store.g.dart';

class PaymentStore = PaymentStoreBase with _$PaymentStore;

abstract class PaymentStoreBase with Store {
  @observable
  ObservableList<Payment> _payments = ObservableList();

  @observable
  String _paymentType = '';

  @observable
  String _paymentValue = '';

  @computed
  List<Payment> get payments => List.unmodifiable(_payments);

  @computed
  String get paymentType => _paymentType;

  @computed
  String get paymentValue => _paymentValue;

  @action
  Future<void> pay() async {
    await addPayment(type: _paymentType, value: _paymentValue);
    clearFields();
  }

  @action
  Future<void> addPayment({required String type, required String value}) async {
    final payment = Payment(type: type, value: value);
    _payments.add(payment);
  }

  @action
  void removePayment(Payment payment) {
    _payments.remove(payment);
  }

  @computed
  String get totalPayments => _payments
      .fold(Decimal.zero, (sum, payment) => sum + Decimal.parse(payment.value))
      .toStringAsFixed(2);

  @action
  void setPaymentType(String type) => _paymentType = type;

  @action
  void setPaymentValue(String value) => _paymentValue = value;

  @action
  void clearFields() {
    setPaymentType('');
    setPaymentValue('');
  }

  @action
  void reset() {
    _payments.clear();
    _paymentType = '';
    _paymentValue = '';
  }
}
