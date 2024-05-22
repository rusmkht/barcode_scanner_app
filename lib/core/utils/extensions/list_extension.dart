extension ListExtension<T> on List<T> {
  List<T> operator *(int b) {
    return () sync* {
      for (int i = 0; i < b; i++) {
        yield* this;
      }
    }()
        .toList();
  }
}
