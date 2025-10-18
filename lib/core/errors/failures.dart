import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  const Failure(this.message);

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure(super.message);
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class CacheFailure extends Failure {
  const CacheFailure(super.message);
}

// Extension for user-friendly error messages
extension FailureX on Failure {
  String get userMessage {
    if (this is ServerFailure) {
      return 'Server error: $message';
    } else if (this is NetworkFailure) {
      return 'Network error: Please check your internet connection';
    } else if (this is CacheFailure) {
      return 'Cache error: $message';
    }
    return 'An unexpected error occurred';
  }
}
