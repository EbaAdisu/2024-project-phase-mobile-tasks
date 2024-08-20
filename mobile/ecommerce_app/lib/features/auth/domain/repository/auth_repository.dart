import 'package:dartz/dartz.dart';

import '../../../../core/error/failure.dart';
import '../entities/user_entity.dart';

abstract class AuthRepository {
  Future<Either<Failure, UserEntity>> signUpUser(UserEntity user);
  Future<Either<Failure, UserEntity>> logInUser(UserEntity user);
  Future<Either<Failure, UserEntity>> logOutUser();
  Future<Either<Failure, UserEntity>> getCurrentUser();
}
