part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object> get props => [];
}

class LoginEvent extends AuthEvent {
  final LoginEntity loginEntity;

  const LoginEvent({required this.loginEntity});
}

class RegisterEvent extends AuthEvent {
  final RegistrationEntity registrationEntity;

  const RegisterEvent({required this.registrationEntity});
}

class LogoutEvent extends AuthEvent {}

class GetUserEvent extends AuthEvent {}
