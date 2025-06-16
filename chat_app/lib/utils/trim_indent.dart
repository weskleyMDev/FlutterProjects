extension StringExtensions on String {
  String trimIndent() {
    final lines = split('\n');

    final trimmedLines = lines
        .skipWhile((line) => line.trim().isEmpty)
        .toList()
        .reversed
        .skipWhile((line) => line.trim().isEmpty)
        .toList()
        .reversed
        .toList();

    if (trimmedLines.isEmpty) return '';

    final indent = trimmedLines
        .where((line) => line.trim().isNotEmpty)
        .map((line) => line.length - line.trimLeft().length)
        .reduce((a, b) => a < b ? a : b);

    return trimmedLines
        .map((line) => line.length >= indent ? line.substring(indent) : line)
        .join('\n');
  }
}
