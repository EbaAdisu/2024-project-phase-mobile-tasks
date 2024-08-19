import 'package:bloc_test/bloc_test.dart';
import 'package:dartz/dartz.dart';
import 'package:ecommerce_app/core/error/failure.dart';
import 'package:ecommerce_app/core/usecase/usecase.dart';
import 'package:ecommerce_app/features/product/domain/entities/product_entity.dart';
import 'package:ecommerce_app/features/product/domain/usecases/create_product.dart'
    as create_usecase;
import 'package:ecommerce_app/features/product/domain/usecases/delete_product.dart'
    as delete_usecase;
import 'package:ecommerce_app/features/product/domain/usecases/update_product.dart'
    as update_usecase;
import 'package:ecommerce_app/features/product/domain/usecases/view_specific_product.dart'
    as view_usecase;
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import '../../../../helpers/test_helper.mocks.dart';

void main() {
  late MockCreateProductUsecase mockCreateProductUsecase;
  late MockDeleteProductUsecase mockDeleteProductUsecase;
  late MockViewProductUsecase mockViewProductUsecase;
  late MockViewAllProductsUsecase mockViewAllProductsUsecase;
  late MockUpdateProductUsecase mockUpdateProductUsecase;

  // late viewParams = view_usecase.Params;

  late ProductBloc productBloc;

  setUp(() {
    mockCreateProductUsecase = MockCreateProductUsecase();
    mockDeleteProductUsecase = MockDeleteProductUsecase();
    mockViewProductUsecase = MockViewProductUsecase();
    mockViewAllProductsUsecase = MockViewAllProductsUsecase();
    mockUpdateProductUsecase = MockUpdateProductUsecase();
    productBloc = ProductBloc(
      createProductUsecase: mockCreateProductUsecase,
      deleteProductUsecase: mockDeleteProductUsecase,
      viewProductUsecase: mockViewProductUsecase,
      viewAllProductsUsecase: mockViewAllProductsUsecase,
      updateProductUsecase: mockUpdateProductUsecase,
    );
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

  group('CreateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when CreateProductEvent is added',
      build: () {
        when(mockCreateProductUsecase(
                const create_usecase.Params(product: productEntity)))
            .thenAnswer((_) async => const Right(productEntity));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(productEntity)),
      // wait: const Duration(milliseconds: 300),
      expect: () => [
        LoadingState(),
        const LoadedSingleProductState(productEntity),
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when CreateProductEvent is unsuccessful',
      build: () {
        when(mockCreateProductUsecase(
                const create_usecase.Params(product: productEntity)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const CreateProductEvent(productEntity)),
      // wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), const ErrorState('Server Failure')],
    );
  });

  group('DeleteProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, InitialState] when DeleteProductEvent is added',
      build: () {
        when(mockDeleteProductUsecase(
                const delete_usecase.Params(productId: productId)))
            .thenAnswer((_) async => const Right(true));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productId)),
      // wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), InitialState()],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when DeleteProductEvent is unsuccessful',
      build: () {
        when(mockDeleteProductUsecase(
                const delete_usecase.Params(productId: productId)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const DeleteProductEvent(productId)),
      // wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), const ErrorState('Server Failure')],
    );
  });

  group('GetSingleProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when GetSingleProductEvent is added',
      build: () {
        when(mockViewProductUsecase(
                const view_usecase.Params(productId: productId)))
            .thenAnswer((_) async => const Right(productEntity));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productId)),
      wait: const Duration(milliseconds: 300),
      expect: () =>
          [LoadingState(), const LoadedSingleProductState(productEntity)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when GetSingleProductEvent is unsuccessful',
      build: () {
        when(mockViewProductUsecase(
                const view_usecase.Params(productId: productId)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const GetSingleProductEvent(productId)),
      wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), const ErrorState('Server Failure')],
    );
  });

  group('LoadAllProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedAllProductState] when LoadAllProductEvent is added',
      build: () {
        when(mockViewAllProductsUsecase(NoParams()))
            .thenAnswer((_) async => const Right([productEntity]));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductEvent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [
        LoadingState(),
        const LoadedAllProductState([productEntity])
      ],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when LoadAllProductEvent is unsuccessful',
      build: () {
        when(mockViewAllProductsUsecase(NoParams())).thenAnswer(
            (_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const LoadAllProductEvent()),
      wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), const ErrorState('Server Failure')],
    );
  });

  group('UpdateProductEvent', () {
    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, LoadedSingleProductState] when UpdateProductEvent is added',
      build: () {
        when(mockUpdateProductUsecase(
                const update_usecase.Params(product: productEntity)))
            .thenAnswer((_) async => const Right(productEntity));
        return productBloc;
      },
      act: (bloc) => bloc.add(const UpdateProductEvent(productEntity)),
      // wait: const Duration(milliseconds: 300),
      expect: () =>
          [LoadingState(), const LoadedSingleProductState(productEntity)],
    );

    blocTest<ProductBloc, ProductState>(
      'emits [LoadingState, ErrorState] when UpdateProductEvent is unsuccessful',
      build: () {
        when(mockUpdateProductUsecase(
                const update_usecase.Params(product: productEntity)))
            .thenAnswer(
                (_) async => const Left(ServerFailure('Server Failure')));
        return productBloc;
      },
      act: (bloc) => bloc.add(const UpdateProductEvent(productEntity)),
      // wait: const Duration(milliseconds: 300),
      expect: () => [LoadingState(), const ErrorState('Server Failure')],
    );
  });
}
