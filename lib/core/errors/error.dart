abstract class Error {
  final String message;
  const Error(this.message);
}

class NetworkError extends Error {
  const NetworkError(String message) : super(message);
}

class ServerFailure extends Error {
  const ServerFailure(String message) : super(message);
}
