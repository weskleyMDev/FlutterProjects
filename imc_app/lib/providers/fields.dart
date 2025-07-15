import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'calculate.dart';

class FieldsProvider with ChangeNotifier {
  final heightController = TextEditingController();
  final weightController = TextEditingController();

  void clearFields(BuildContext context) {
    FocusScope.of(context).unfocus();
    heightController.clear();
    weightController.clear();
    notifyListeners();
  }

  void clearAll(BuildContext context) {
    FocusScope.of(context).unfocus();
    heightController.clear();
    weightController.clear();
    Provider.of<CalculateProvider>(context, listen: false).clearStrings();
    notifyListeners();
  }
}
