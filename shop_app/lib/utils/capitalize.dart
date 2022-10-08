class Capitalize {
  String capitalize(String text) {
    List<String> splited = text.split(' ');
    List<String> result = [];
    for (var element in splited) {
      result.add(element.capitalizing());
    }
    text = result.join(' ');
    return text;
  }
}

extension MyExtension on String {
  String capitalizing() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
