class ListUtils {
  static bool listCompare<T>(List<T> first, List<T> second) {
    if (first.length == second.length) {
      for (var i = 0; i < first.length; i++) {
        if (first[i] != second[i]) return false;
      }
      return true;
    } else {
      return false;
    }
  }
}
