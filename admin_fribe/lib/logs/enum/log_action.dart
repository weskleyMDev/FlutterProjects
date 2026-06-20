enum LogAction { updateAmount, updatePrice }

extension LogActionX on LogAction {
  String get label {
    switch (this) {
      case LogAction.updateAmount:
        return 'Update Amount';
      case LogAction.updatePrice:
        return 'Update Price';
    }
  }
}
