int customBinarySearch<T, E>(List<T> list, E elem, int Function(T, E) compare) {
  int start = 0;
  int end = list.length - 1;

  while (start <= end) {
    int mid = (start + end) ~/ 2;
    T midItem = list[mid];

    int comparisonResult = compare(midItem, elem);

    if (comparisonResult == 0) {
      return mid;
    } else if (comparisonResult < 0) {
      start = mid + 1;
    } else {
      end = mid - 1;
    }
  }
  return -1;
}

extension CompareMapById on Map<String, dynamic> {
  int compareById(Map<String, dynamic> other) {
    String id1 = this['id'];
    String id2 = other['id'];
    return id1.compareTo(id2);
  }
}
