class ErrorResponse {
  String? message;
  int? code;

  ErrorResponse.fromJson(Map<String, dynamic> json) {
    message = json['message'] as String?;
    code = json['code'] as int?;
  }
}

class APIResponse<T> {
  T? data;
  ErrorResponse? error;

  isError() {
    return error != null;
  }

  APIResponse.fromJson(
      Map<String, dynamic> json, T Function(Map<String, dynamic>) fromJson) {
    final jsonData = json['data'] as Map<String, dynamic>?;

    if (json.containsKey('error')) {
      error = ErrorResponse.fromJson(json['error'] as Map<String, dynamic>);
    }

    if (jsonData != null) {
      this.data = fromJson(jsonData);
    }
  }

  APIResponse.fromJsonList(Map<String, dynamic> json,
      T Function(List<Map<String, dynamic>>) fromJson) {
    if (json.containsKey('error')) {
      error = ErrorResponse.fromJson(json['error'] as Map<String, dynamic>);
    }

    final List<dynamic> jsonData = json['data'] ?? [];

    this.data =
        fromJson(jsonData.map((e) => e as Map<String, dynamic>).toList());
  }
}
