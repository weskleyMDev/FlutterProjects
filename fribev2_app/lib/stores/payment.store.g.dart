// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.store.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic, no_leading_underscores_for_local_identifiers

mixin _$PaymentStore on PaymentStoreBase, Store {
  Computed<List<Payment>>? _$paymentsComputed;

  @override
  List<Payment> get payments => (_$paymentsComputed ??= Computed<List<Payment>>(
    () => super.payments,
    name: 'PaymentStoreBase.payments',
  )).value;
  Computed<String>? _$paymentTypeComputed;

  @override
  String get paymentType => (_$paymentTypeComputed ??= Computed<String>(
    () => super.paymentType,
    name: 'PaymentStoreBase.paymentType',
  )).value;
  Computed<String>? _$paymentValueComputed;

  @override
  String get paymentValue => (_$paymentValueComputed ??= Computed<String>(
    () => super.paymentValue,
    name: 'PaymentStoreBase.paymentValue',
  )).value;
  Computed<String>? _$totalPaymentsComputed;

  @override
  String get totalPayments => (_$totalPaymentsComputed ??= Computed<String>(
    () => super.totalPayments,
    name: 'PaymentStoreBase.totalPayments',
  )).value;

  late final _$_paymentsAtom = Atom(
    name: 'PaymentStoreBase._payments',
    context: context,
  );

  @override
  ObservableList<Payment> get _payments {
    _$_paymentsAtom.reportRead();
    return super._payments;
  }

  @override
  set _payments(ObservableList<Payment> value) {
    _$_paymentsAtom.reportWrite(value, super._payments, () {
      super._payments = value;
    });
  }

  late final _$_paymentTypeAtom = Atom(
    name: 'PaymentStoreBase._paymentType',
    context: context,
  );

  @override
  String get _paymentType {
    _$_paymentTypeAtom.reportRead();
    return super._paymentType;
  }

  @override
  set _paymentType(String value) {
    _$_paymentTypeAtom.reportWrite(value, super._paymentType, () {
      super._paymentType = value;
    });
  }

  late final _$_paymentValueAtom = Atom(
    name: 'PaymentStoreBase._paymentValue',
    context: context,
  );

  @override
  String get _paymentValue {
    _$_paymentValueAtom.reportRead();
    return super._paymentValue;
  }

  @override
  set _paymentValue(String value) {
    _$_paymentValueAtom.reportWrite(value, super._paymentValue, () {
      super._paymentValue = value;
    });
  }

  late final _$payAsyncAction = AsyncAction(
    'PaymentStoreBase.pay',
    context: context,
  );

  @override
  Future<void> pay() {
    return _$payAsyncAction.run(() => super.pay());
  }

  late final _$addPaymentAsyncAction = AsyncAction(
    'PaymentStoreBase.addPayment',
    context: context,
  );

  @override
  Future<void> addPayment({required String type, required String value}) {
    return _$addPaymentAsyncAction.run(
      () => super.addPayment(type: type, value: value),
    );
  }

  late final _$PaymentStoreBaseActionController = ActionController(
    name: 'PaymentStoreBase',
    context: context,
  );

  @override
  void removePayment(Payment payment) {
    final _$actionInfo = _$PaymentStoreBaseActionController.startAction(
      name: 'PaymentStoreBase.removePayment',
    );
    try {
      return super.removePayment(payment);
    } finally {
      _$PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentType(String type) {
    final _$actionInfo = _$PaymentStoreBaseActionController.startAction(
      name: 'PaymentStoreBase.setPaymentType',
    );
    try {
      return super.setPaymentType(type);
    } finally {
      _$PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void setPaymentValue(String value) {
    final _$actionInfo = _$PaymentStoreBaseActionController.startAction(
      name: 'PaymentStoreBase.setPaymentValue',
    );
    try {
      return super.setPaymentValue(value);
    } finally {
      _$PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void clearFields() {
    final _$actionInfo = _$PaymentStoreBaseActionController.startAction(
      name: 'PaymentStoreBase.clearFields',
    );
    try {
      return super.clearFields();
    } finally {
      _$PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  void reset() {
    final _$actionInfo = _$PaymentStoreBaseActionController.startAction(
      name: 'PaymentStoreBase.reset',
    );
    try {
      return super.reset();
    } finally {
      _$PaymentStoreBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
payments: ${payments},
paymentType: ${paymentType},
paymentValue: ${paymentValue},
totalPayments: ${totalPayments}
    ''';
  }
}
