extension NonNullString on String? {
  String orEmpty() {
    return this == null ? '' : this!;
  }
}

extension NonNullInt on int? {
  int orZero() {
    return this == null ? 0 : this!;
  }
}
