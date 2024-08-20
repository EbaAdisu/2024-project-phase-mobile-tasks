import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/log_in.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late LogInUseCase logInUseCase;
  late MockAuthRepository mockAuthRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    logInUseCase = LogInUseCase(mockAuthRepository);
  });
  const testUser = UserEntity(
    name: 'Mr. User',
    email: 'user@email.com',
    password: 'userpassword',
  ); // const testPoductName = 'product';
  test(
    'should call logInUser from auth repository',
    () async {
      // arrange
      when(mockAuthRepository.logInUser(testUser))
          .thenAnswer((_) async => const Right(testUser));

      // act
      final result = await logInUseCase(const Params(user: testUser));

      // assert
      expect(result, const Right(testUser));
    },
  );
  test(
    'should return failure when Auth repository return failure',
    () async {
      // arrange
      when(mockAuthRepository.logInUser(testUser))
          .thenAnswer((_) async => const Left(ServerFailure('error')));

      // act
      final result = await logInUseCase(const Params(user: testUser));

      // assert
      expect(result, const Left(ServerFailure('error')));
    },
  );
}
