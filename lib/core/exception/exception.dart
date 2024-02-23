class ServerException implements Exception {
  final String errorMassege;
  final int errorCode;
  ServerException({
    required this.errorMassege,
    required this.errorCode,
  });

  @override
  String toString() => 'ServerException(errorMassege: $errorMassege, errorCode: $errorCode)';
}
