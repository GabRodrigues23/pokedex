abstract class Error {
  final String message;
  const Error(this.message);
}

class NetworkError extends Error {
  const NetworkError(super.message);
}

class ServerFailure extends Error {
  const ServerFailure(super.message);
}
