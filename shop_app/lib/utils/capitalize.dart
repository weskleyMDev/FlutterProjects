extension StringExtensions on String {
  String capitalizeAll() {
    return trim()
        .split(' ')
        .map((word) => word.substring(0, 1).toUpperCase() + word.substring(1))
        .join(' ');
  }

  String capitalizeSingle() {
    const lowercaseWords = {'de', 'da', 'do', 'das', 'dos', 'e'};

    return trim()
        .split(RegExp(r'\s+'))
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

  String capitalizeFirst() {
    final trimmed = trim();
    if (trimmed.isEmpty) return '';
    return trimmed[0].toUpperCase() + trimmed.substring(1).toLowerCase();
  }

  String trimIndent() {
    final lines = split('\n');

    // Remove linhas totalmente em branco no início e fim
    final trimmedLines = lines
        .skipWhile((line) => line.trim().isEmpty)
        .toList()
        .reversed
        .skipWhile((line) => line.trim().isEmpty)
        .toList()
        .reversed
        .toList();

    if (trimmedLines.isEmpty) return '';

    // Determina a menor indentação comum
    final indent = trimmedLines
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.length - line.trimLeft().length)
        .reduce((a, b) => a < b ? a : b);

    // Remove a indentação comum de todas as linhas
    return trimmedLines
        .map((line) => line.length >= indent ? line.substring(indent) : line)
        .join('\n');
  }
}
