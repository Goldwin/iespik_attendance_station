class PrintResult {
  final bool success;
  final String? message;

  PrintResult(this.success, this.message);

  PrintResult.failed() : this(false, null);

  factory PrintResult.fromMap(Map<dynamic, dynamic> map) {
    return PrintResult(map["success"] as bool, map["message"] as String?);
  }
}
