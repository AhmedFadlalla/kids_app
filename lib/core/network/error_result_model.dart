class ErrorResultModel{

  final String message;
  final String code;

  ErrorResultModel({required this.message,required this.code});

  factory ErrorResultModel.fromJson(Map<String,dynamic>json){
    return ErrorResultModel(
      message: json["message"]??"",
      code: json["message"]??"Null"
    );
  }
}