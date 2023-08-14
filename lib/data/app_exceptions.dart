

class AppExceptions implements Exception{

  final String _message;
  final String _prefix;

  AppExceptions(this._message, this._prefix);

  @override
  String toString(){
    return '$_prefix $_message';
  }
}

class InternetException extends AppExceptions{

  InternetException([String? message]) : super(message!, 'No Internet');

}

class RequestTimeOut extends AppExceptions{

  RequestTimeOut([String? message]) : super(message!, 'Request Time out');

}

class ServerException extends AppExceptions{

  ServerException([String? message]) : super(message!, 'No Internet');

}

class InvalidBarcodeException extends AppExceptions{

  InvalidBarcodeException([String? message]) : super(message!, "Invalid barcode");

}

class FetchDataException extends AppExceptions{

  FetchDataException([String? message]) : super(message!, 'Error while fetching data');

}