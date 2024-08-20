import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_current_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetCurrentUserUseCase getCurrentUserUseCase;
  late MockAuthRepository mockAuthRepository;
  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getCurrentUserUseCase = GetCurrentUserUseCase(mockAuthRepository);
  });
  const testUser = UserEntity(
    name: 'Mr. User',
    email: 'user@email.com',
    password: 'userpassword',
  ); // const testPoductName = 'product';
  test(
    'should call getCurrentUser from auth repository',
    () async {
      // arrange
      when(mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Right(testUser));

      // act
      final result = await getCurrentUserUseCase(NoParams());

      // assert
      expect(result, const Right(testUser));
    },
  );
  test(
    'should return failure when auth repository return failure',
    () async {
      // arrange
      when(mockAuthRepository.getCurrentUser())
          .thenAnswer((_) async => const Left(ServerFailure('error')));

      // act
      final result = await getCurrentUserUseCase(NoParams());

      // assert
      expect(result, const Left(ServerFailure('error')));
    },
  );
}
