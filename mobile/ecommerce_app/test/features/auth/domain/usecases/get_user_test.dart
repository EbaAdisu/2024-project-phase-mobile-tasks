import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/auth/domain/entities/user_data_entity.dart';
import 'package:ecommerce_app/features/auth/domain/usecases/get_user.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late GetUserUsecase getUserUsecase;
  late MockAuthRepository mockAuthRepository;

  setUp(() {
    mockAuthRepository = MockAuthRepository();
    getUserUsecase = GetUserUsecase(mockAuthRepository);
  });

  const tUserDataEntity = UserDataEntity(
    email: 'email',
    name: 'name',
  );

  group('LogoutUsecase', () {
    test('should return userdataentity if successful', () async {
      //arrange
      when(mockAuthRepository.getUser())
          .thenAnswer((_) async => const Right(tUserDataEntity));

      //act
      final result = await getUserUsecase(NoParams());

      //assert
      expect(result, const Right(tUserDataEntity));
    });
    test('should return failure if unsuccessful', () async {
      //arrange
      when(mockAuthRepository.getUser()).thenAnswer(
          (_) async => const Left(ServerFailure('test error message')));

      //act
      final result = await getUserUsecase(NoParams());

      //assert
      expect(result, const Left(ServerFailure('test error message')));
    });
  });
}
