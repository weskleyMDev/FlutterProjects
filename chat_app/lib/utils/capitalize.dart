extension StringExtensions on String {
  String capitalizeWords() {
    const lowercaseWords = {'de', 'da', 'do', 'das', 'dos', 'e'};

    return trim()
        .split(RegExp(r'\s+'))
        .where((word) => word.isNotEmpty)
        .toList()
        .asMap()
        .entries
        .map((entry) {
          final index = entry.key;
          final word = entry.value.toLowerCase();

          if (index == 0 || !lowercaseWords.contains(word)) {
            return word[0].toUpperCase() + word.substring(1);
          } else {
            return word;
          }
        })
        .join(' ');
  }
}
