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

  void clear() {
    name = '';
    category = '';
    measure = '';
    amount = '';
    price = '';
    imageUrl = '';
  }

  @override
  String toString() =>
      'StockFormData(name: $name, category: $category, measure: $measure, amount: $amount, price: $price, imageUrl: $imageUrl)';
}
