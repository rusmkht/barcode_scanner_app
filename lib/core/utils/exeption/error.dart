class ErrorData {
  String message;

  ErrorData(this.message);

  factory ErrorData.fromJson(Map<String, dynamic> map) => ErrorData(
        map['message'] ?? map['error'] ?? map['detail'] ?? map,
      );
}
