enum DataSource {
  SUCCESS,
  NO_CONTENT,
  BAD_REQUEST,
  FORBIDDEN,
  UNAUThORISED,
  NOT_FOUND,
  INTERNAL_SERVER_Error,
  CONNECT_TIMEOUT,
  CANCEL,
  RECIEVE_TIMEOUt,
  SEND_TIMEOUT,
  CACHE_ERROR,
  NO_INTERNET_CONNECTION
}

class ResponseCode{
  static const int SUCCESS = 200; // success with data
  static const int NO_CONTENT = 201; // success with no data
  static const int BAD_REQUEST = 400; // failure, API rejected request
  static const int UNAUThORISED = 401; // failure, user is not authorised
  static const int FORBIDDEN = 403; // failure, API rejected request
  static const int NOT_FOUND = 404;
  static const int INTERNAL_SERVER_Error = 500; // failure, crash in server side

  // local status code
  static const int CONNECT_TIMEOUT = -1;
  static const int CANCEL = -2;
  static const int RECIEVE_TIMEOUt = -3;
  static const int SEND_TIMEOUT = -4;
  static const int CACHE_ERROR = -5;
  static const int NO_INTERNET_CONNECTION = -6;
  static const int UNKNOWN = -7;
}

class ResponseMessage{
  static const String SUCCESS = "success"; // success with data
  static const String NO_CONTENT = "success"; // success with no data
  static const String BAD_REQUEST = "Bad request, Try again later"; // failure, API rejected request
  static const String UNAUThORISED = "User ia unauthorised, Try again later"; // failure, user is not authorised
  static const String FORBIDDEN = "Forbidden request, Try again later"; // failure, API rejected request
  static const String INTERNAL_SERVER_Error = "Some thing went wrong, Try again later"; // failure, crash in server side

  // local status code
  static const String CONNECT_TIMEOUT = "Time out error, Try again later";
  static const String CANCEL = "Request was cancelled, Try again later";
  static const String RECIEVE_TIMEOUt = "Time out error, Try again later";
  static const String SEND_TIMEOUT = "Time out error, Try again later";
  static const String CACHE_ERROR = "Cache error, Try again later";
  static const String NO_INTERNET_CONNECTION = "Please check your  internet connection";
  static const String UNKNOWN = "Some thing went wrong, Try again later";
}
