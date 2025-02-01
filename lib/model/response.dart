class ResponseModel {
  String message;
  bool isOperationSuccessful;
  dynamic data;

  ResponseModel({
    required this.message,
    required this.isOperationSuccessful,
    this.data,
  });
}
