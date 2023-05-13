
abstract class Failure {
  final String message;
  Failure({required this.message});
}

class OfflineFailure extends Failure{
  OfflineFailure({required String message}):super(message: message);
}

class SafetyLocalDataBaseFailure extends Failure{
  SafetyLocalDataBaseFailure({required String message}):super(message:message );
}

class ServerFailure extends Failure{
  ServerFailure({required String message}):super(message:message);
}
