abstract class BaseError extends Error {
  String? source = "System";
  final String module;
  final String message;
  String? functionName;

  BaseError({
    required this.source,
    required this.module,
    required this.message,
    this.functionName,
  }) : super();
}

class RepositoryError extends BaseError {
  RepositoryError({
    required super.module,
    required super.message,
    super.functionName,
    super.source,
  });

  @override
  String toString() {
    return "[Error][$source][Repository][$module - $functionName]: $message";
  }
}

class ServiceError extends BaseError {
  ServiceError({
    required super.module,
    required super.message,
    super.source,
    required super.functionName,
  });

  @override
  String toString() {
    return "[Error][$source][Service][$module - $functionName]: $message";
  }
}
