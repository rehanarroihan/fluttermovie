class ApiReturn<T> {
  final T? data;
  final String message;
  final bool success;
  final String? code;

  ApiReturn({
    this.data,
    this.message = "",
    required this.success,
    this.code
  });
}