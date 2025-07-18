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
    required this.name,
    required this.category,
    required this.measure,
    required this.amount,
    required this.price,
    this.imageUrl,
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
