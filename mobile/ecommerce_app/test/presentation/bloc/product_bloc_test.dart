import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/domain/entities/product_entity.dart';
import 'package:ecommerce_app/domain/usecases/view_specific_product.dart';
import 'package:ecommerce_app/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../helpers/test_helper.mocks.dart';

void main() {
  late MockViewProductUsecase mockViewProductUsecase;
  late ProductBloc productBloc;

  setUp(() {
    mockViewProductUsecase = MockViewProductUsecase();
    productBloc = ProductBloc(mockViewProductUsecase);
  });

  const productEntity = ProductEntity(
    id: '1',
    name: 'Product 1',
    description: 'Description 1',
    price: 1000,
    imageUrl: 'image1.png',
  );
  const productId = '1';

  test('initial state should be InitialState', () {
    expect(productBloc.state, equals(InitialState()));
  });

  blocTest<ProductBloc, ProductState>(
    'emits [LoadingState, LoadedSingleProductState] when GetSingleProductEvent is added',
    build: () {
      when(mockViewProductUsecase(const Params(productId: productId)))
          .thenAnswer((_) async => const Right(productEntity));
      return productBloc;
    },
    act: (bloc) => bloc.add(GetSingleProductEvent(productId)),
    wait: const Duration(milliseconds: 300),
    expect: () =>
        [LoadingState(), const LoadedSingleProductState(productEntity)],
  );
  blocTest<ProductBloc, ProductState>(
    'emits [LoadingState, ErrorState] when GetSingleProductEvent is unsuccessful',
    build: () {
      when(mockViewProductUsecase(const Params(productId: productId)))
          .thenAnswer((_) async => const Left(ServerFailure('Server Failure')));
      return productBloc;
    },
    act: (bloc) => bloc.add(GetSingleProductEvent(productId)),
    wait: const Duration(milliseconds: 300),
    expect: () => [LoadingState(), const ErrorState('Server Failure')],
  );
}
