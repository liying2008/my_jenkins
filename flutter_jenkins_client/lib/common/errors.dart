class FetchDataFailedError extends Error {
  final String message;

  FetchDataFailedError(this.message);

  String toString() => "fetch data failed: $message";
}
