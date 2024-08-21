import '../../domain/entities/login_entity.dart';

class LoginModel extends LoginEntity {
  const LoginModel({
    required super.email,
    required super.password,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
    };
  }

  static LoginModel toModel(LoginEntity loginEntity) {
    return LoginModel(
      email: loginEntity.email,
      password: loginEntity.password,
    );
  }
}
