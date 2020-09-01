class Http_Exception implements Exception {
  final String message;
  Http_Exception(this.message);
  @override
  String toString() {
    // TODO: implement toString
    return message;
  }
}
