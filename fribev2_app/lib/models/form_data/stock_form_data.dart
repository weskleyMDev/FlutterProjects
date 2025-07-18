enum StockCategory {
  bovine,
  swine,
  sheep,
  chiken,
  others
}

class StockFormData {
  String name;
  String category;
  String measure;
  String amount;
  String price;
  String? imageUrl;

  StockFormData({
    this.name = '',
    this.category = '',
    this.measure = '',
    this.amount = '',
    this.price = '',
    this.imageUrl = '',
  });

  void toggleCategory(StockCategory newCategory) {
    switch (newCategory) {
      case StockCategory.bovine:
        category = 'BOVINO';
        break;
      case StockCategory.swine:
        category = 'SUÍNO';
        break;
      case StockCategory.sheep:
        category = 'OVINO';
        break;
      case StockCategory.chiken:
        category = 'AVES';
        break;
      case StockCategory.others:
        category = 'OUTROS';
        break;
    }
  }

}
