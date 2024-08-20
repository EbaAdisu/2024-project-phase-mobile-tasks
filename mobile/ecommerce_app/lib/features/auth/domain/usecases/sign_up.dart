import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/usecase/usecase.dart';
import '../entities/user_entity.dart';
import '../repository/auth_repository.dart';

class SignUpUseCase extends UseCase<UserEntity, Params> {
  final AuthRepository authRepository;

  SignUpUseCase(this.authRepository);

  @override
  Future<Either<Failure, UserEntity>> call(Params params) async {
    return await authRepository.signUpUser(params.user);
  }
}

class Params extends Equatable {
  final UserEntity user;

  const Params({required this.user});
  @override
  List<Object?> get props => [user];
}
