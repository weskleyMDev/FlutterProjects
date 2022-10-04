class Capitalize {
  String capitalizedWords(String text) {
    List<String> splited = text.split(' ');
    List<String> result = [];
    for (var element in splited) {
      result.add(element.capitalize());
    }
    text = result.join(' ');
    return text;
  }
}

extension MyExtension on String {
  String capitalize() {
    return '${this[0].toUpperCase()}${substring(1).toLowerCase()}';
  }
}
