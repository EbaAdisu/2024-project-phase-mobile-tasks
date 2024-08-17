import 'package:bloc_test/bloc_test.dart';
import 'package:ecommerce_app/data/models/product_model.dart';
import 'package:ecommerce_app/presentation/bloc/product_bloc.dart';
import 'package:ecommerce_app/presentation/bloc/product_event.dart';
import 'package:ecommerce_app/presentation/bloc/product_state.dart';
import 'package:ecommerce_app/presentation/pages/home_page.dart';
import 'package:ecommerce_app/presentation/widgets/product_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

class MockProductBloc extends MockBloc<ProductEvent, ProductState>
    implements ProductBloc {}

// class MockProductBloc extends MockBloc<ProductEvent, ProductState>
//     implements ProductBloc {
//   @override
//   ProductState get state => LoadingState();
// }

void main() {
  late MockProductBloc mockProductBloc;

  setUp(() {
    mockProductBloc = MockProductBloc();
  });
  Widget makeTestableWidget({required Widget child}) {
    return BlocProvider<ProductBloc>(
      create: (context) => mockProductBloc,
      child: MaterialApp(
        home: child,
      ),
    );
  }

  //  working
  testWidgets('should show circular progress indicator when loading',
      (WidgetTester tester) async {
    // arrange
    whenListen(
      mockProductBloc,
      Stream.fromIterable([LoadingState()]),
      initialState: LoadingState(),
    );

    // act
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
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
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));

    // assert
    expect(find.text('No data found'), findsOneWidget);
  });

///////////////////////////////////////////////////////////////////////////////////////////////////////////////////
//  Not working

  testWidgets('should  show CircularProgressIndicator on LodingState  ',
      (widgetTester) async {
    //  arrange
    // when(() => mockProductBloc.state).thenAnswer((_) => (LoadingState()));
    // when(() => mockProductBloc.state).thenReturn(InitialState());

    // when(() => mockProductBloc.state).thenAnswer((_) => (() => LoadingState()));
    when(mockProductBloc.state).thenReturn(LoadingState());

    // act
    await widgetTester.pumpWidget(makeTestableWidget(child: const HomePage()));

    // assert
    expect(find.byType(CircularProgressIndicator), findsOneWidget);
  });

  testWidgets(
      'should show list of products when state is LoadedAllProductState',
      (WidgetTester tester) async {
    // arrange
    final products = [
      const ProductModel(
        id: '1',
        name: 'Product 1',
        price: 100,
        imageUrl: 'https://example.com/image1.png',
        description: 'Description 1',
      ),
      const ProductModel(
        id: '2',
        name: 'Product 2',
        price: 200,
        imageUrl: 'https://example.com/image2.png',
        description: 'Description 2',
      ),
    ];

    whenListen(
      mockProductBloc,
      Stream.fromIterable([LoadedAllProductState(products)]),
      initialState: LoadedAllProductState(products),
    );

    // act
    await tester.pumpWidget(makeTestableWidget(child: const HomePage()));

    // assert
    expect(find.byType(ListView), findsNWidgets(1));
  });

  // testWidgets(
  //     'should trigger LoadAllProductEvent when refresh button is tapped',
  //     (WidgetTester tester) async {
  //   // arrange
  //   whenListen(
  //     mockProductBloc,
  //     Stream.fromIterable([const LoadedAllProductState([])]),
  //     initialState: InitialState(),
  //   );

  //   // act
  //   await tester.pumpWidget(makeTestableWidget(child: const HomePage()));
  //   await tester.tap(find.byIcon(Icons.restart_alt_outlined));
  //   await tester.pumpAndSettle();

  //   // assert
  //   verify(mockProductBloc.add(const LoadAllProductEvent())).called(1);
  // });
}
