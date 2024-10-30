class PrintResult {
  final bool success;
  final String? message;

  PrintResult(this.success, this.message);

  PrintResult.failed(String message) : this(false, message);

  factory PrintResult.fromJson(Map<dynamic, dynamic> map) {
    return PrintResult(map["success"] as bool, map["message"] as String?);
  }
}
