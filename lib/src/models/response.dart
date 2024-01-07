

class Response<T> {
  final bool isSuccess;
  final String message;
  final T result;
  final dynamic otherData;

  bool get isNotSuccess => !isSuccess;

  Response({
    required this.isSuccess,
    this.message = '',
    required this.result,
    this.otherData,
  });
}
