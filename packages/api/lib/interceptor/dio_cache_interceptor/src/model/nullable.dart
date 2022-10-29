class Nullable<T> {
  const Nullable(this._value);
  final T? _value;

  T? get value => _value;

  bool get isNotNull => _value != null;
}
