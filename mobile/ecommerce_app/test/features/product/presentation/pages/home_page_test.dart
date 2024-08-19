import 'dart:io';

import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/core/constants/constants.dart';
import 'package:ecommerce_app/features/product/data/models/product_model.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/features/product/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/features/product/presentation/pages/home_page.dart';
import 'package:ecommerce_app/features/product/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
    HttpOverrides.global = null;
  });

  Widget _makeTestableWidget(Widget body) {
    return BlocProvider<ProductBloc>.value(
      value: mockProductBloc,
      child: MaterialApp(
        home: body,
      ),
    );
  }

  final testProductEntityList = [
    ProductModel(
      id: '1',
      name: 'Test Pineapple',
      description: 'A yellow pineapple for the summer',
      imageUrl: Urls.imageUrl,
      price: 5.33,
    )
  ];
  group('home page test', () {
    testWidgets('state should have a loading circle', (widgetTester) async {
      //arrange
      when(() => mockProductBloc.state).thenAnswer((_) => LoadingState());

      //act
      await widgetTester.pumpWidget(_makeTestableWidget(const HomePage()));

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });
    testWidgets('Homepage shows error message when state is error',
        (WidgetTester tester) async {
      //arrange
      when(() => mockProductBloc.state)
          .thenReturn(const ErrorState('Test Error Message'));

      //act
      await tester.pumpWidget(_makeTestableWidget(const HomePage()));
      await tester.pumpAndSettle();

      expect(find.text('No data found'), findsOneWidget);
    });

    testWidgets('should show no data found when there is no data',
        (WidgetTester tester) async {
      // arrange
      whenListen(
        mockProductBloc,
        Stream.fromIterable([const ErrorState('msg')]),
        initialState: const ErrorState('msg'),
      );

      // act
      await tester.pumpWidget(_makeTestableWidget(const HomePage()));

      // assert
      expect(find.text('No data found'), findsOneWidget);
    });

//////////////////////////////////
    testWidgets('HomePage should have ProductCard',
        (WidgetTester tester) async {
      // Arrange
      when(() => mockProductBloc.state)
          .thenReturn(LoadedAllProductState(testProductEntityList));

      // Act
      await tester.pumpWidget(_makeTestableWidget(const HomePage()));
      // Assert
      expect(find.byType(ProductCard), findsWidgets);
    });
  });
}
