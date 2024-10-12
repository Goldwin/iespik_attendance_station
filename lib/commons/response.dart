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

  APIResponse.fromJson(Map<String, dynamic> json) {
    //data = json['data'] as T;
    if (json.containsKey('error')) {
      error = ErrorResponse.fromJson(json['error'] as Map<String, dynamic>);
    }
  }
}
