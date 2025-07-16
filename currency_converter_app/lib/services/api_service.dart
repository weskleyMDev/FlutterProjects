import 'package:flutter/material.dart';
import 'package:mobx/mobx.dart';

import '../interfaces/api_interface.dart';

part 'api_service.g.dart';

class ApiService = ApiServiceBase with _$ApiService;

abstract class ApiServiceBase with Store {
  ApiServiceBase({required this.apiInterface});

  final ApiInterface apiInterface;

  TextEditingController realController = TextEditingController();
  TextEditingController dollarController = TextEditingController();
  TextEditingController euroController = TextEditingController();

  @observable
  double dollar = 0.0;

  @observable
  double euro = 0.0;

  @action
  void realChanged(String real) {
    final realDecimal = double.tryParse(real) ?? 0.0;
    dollarController.text = (realDecimal / dollar).toStringAsFixed(2);
    euroController.text = (realDecimal / euro).toStringAsFixed(2);
  }

  @action
  void dollarChanged(String dollar) {
    final dollarDecimal = double.tryParse(dollar) ?? 0.0;
    realController.text = (dollarDecimal * this.dollar).toStringAsFixed(2);
    euroController.text = (dollarDecimal * this.dollar / euro).toStringAsFixed(
      2,
    );
  }

  @action
  void euroChanged(String euro) {
    final euroDecimal = double.tryParse(euro) ?? 0.0;
    realController.text = (euroDecimal * this.euro).toStringAsFixed(2);
    dollarController.text = (euroDecimal * this.euro / dollar).toStringAsFixed(
      2,
    );
  }

  @action
  Future<Map> loadData() async {
    final Map data = await apiInterface.loadData();
    dollar = getCurrency('USD', data);
    euro = getCurrency('EUR', data);
    return data;
  }

  @action
  double getCurrency(String currencyKey, Map data) {
    return data.isNotEmpty ? data['results']['currencies'][currencyKey]['buy'] : 0.0;
  }
}
