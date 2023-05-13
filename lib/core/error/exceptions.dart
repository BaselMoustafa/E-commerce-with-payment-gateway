
/////////////////////////////
class SafetyLocalDataBaseException implements Exception {
  final String message;
  const SafetyLocalDataBaseException({required this.message});
}

class NoUserException implements Exception{}

class ServerException implements Exception{
  final String message;
  ServerException({required this.message});
}
