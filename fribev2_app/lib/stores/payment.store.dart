import 'package:decimal/decimal.dart';
import 'package:mobx/mobx.dart';

import '../models/payment.dart';

part 'payment.store.g.dart';

class PaymentStore = PaymentStoreBase with _$PaymentStore;

enum PaymentTypes {
  cash(type: 'Dinheiro'),
  creditCard(type: 'Cartão de Crédito'),
  debitCard(type: 'Cartão de Débito'),
  pix(type: 'PIX');

  const PaymentTypes({required this.type});

  final String type;
}

abstract class PaymentStoreBase with Store {
  @observable
  ObservableList<Payment> _payments = ObservableList();

  @observable
  PaymentTypes? _paymentType;

  @observable
  String _paymentValue = '0';

  @computed
  List<Payment> get payments => List.unmodifiable(_payments);

  @computed
  PaymentTypes? get paymentType => _paymentType;

  @computed
  String get paymentValue => _paymentValue;

  @computed
  double get totalPayments => _payments
      .fold(
        Decimal.zero,
        (total, payment) => total + Decimal.parse(payment.value),
      )
      .round(scale: 2)
      .toDouble();

  @action
  Future<void> pay() async {
    await addPayment(type: _paymentType!.type, value: _paymentValue);
  }

  @action
  Future<void> addPayment({required String type, required String value}) async {
    final payment = Payment(
      type: type,
      value: double.parse(value).toStringAsFixed(2),
    );
    _payments.add(payment);
  }

  @action
  void removePayment(Payment payment) {
    _payments.remove(payment);
  }

  @action
  void setPaymentType(PaymentTypes? type) => _paymentType = type;

  @action
  void setPaymentValue(String value) => _paymentValue = value;

  @action
  void clearPaymentFields() {
    _paymentType = null;
    _paymentValue = '0';
  }

  @action
  void clearPayments() {
    _payments.clear();
  }

  @action
  void clearPaymentStore() {
    clearPaymentFields();
    clearPayments();
  print('DISPOSE PAYMENT STORE!!');
  }
}
