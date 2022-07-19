class DataOrFailure<T, U> {
  final T? data;
  final U? failure;

  DataOrFailure({this.data, this.failure});
}
