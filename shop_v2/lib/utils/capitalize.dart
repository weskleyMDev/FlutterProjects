extension StringExtensions on String {
  String capitalize() {
    const lowerCaseWords = {'de', 'da', 'do', 'das', 'dos', 'e'};
    return trim()
        .split(' ')
        .where((word) => word.isNotEmpty)
        .toList()
        .asMap()
        .entries
        .map((e) {
          final index = e.key;
          final word = e.value.toLowerCase();

          if (index == 0 || !lowerCaseWords.contains(word)) {
            return word[0].toUpperCase() + word.substring(1);
          } else {
            return word;
          }
        })
        .join(' ');
  }
}
