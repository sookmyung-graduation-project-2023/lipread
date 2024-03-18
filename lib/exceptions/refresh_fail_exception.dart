class RefreshFailException implements Exception {
  String message;

  RefreshFailException({this.message = 'access token이 refresh되지 않았습니다.'});

  @override
  String toString() {
    return 'RefreshFailException: $message';
  }
}
