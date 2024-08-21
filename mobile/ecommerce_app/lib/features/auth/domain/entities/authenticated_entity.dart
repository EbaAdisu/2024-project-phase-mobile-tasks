import 'package:equatable/equatable.dart';

class AuthenticatedEntity extends Equatable {
  final String token;

  const AuthenticatedEntity({
    required this.token,
  });
  @override
  List<Object?> get props => [token];
}
