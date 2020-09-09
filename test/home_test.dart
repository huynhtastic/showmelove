import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/pages/app/home/home.dart';
import 'package:showsomelove/pages/app/home/widgets/new_post.dart';

class _Auth extends Mock implements FirebaseAuth {
  Future<FirebaseUser> currentUser() => null;
}

MaterialApp _home() => MaterialApp(home: Home());

final getIt = GetIt.I;
main() {
  setUp(() {
    getIt.registerSingleton<FirebaseAuth>(_Auth());
  });

  tearDown(() {
    getIt.reset();
  });

  testWidgets('new post button opens new post widget',
      (WidgetTester tester) async {
    await tester.pumpWidget(_home());
    final newPost = find.byKey(Key('newPost'));
    await tester.tap(newPost);
    await tester.pumpAndSettle();

    final expected = find.byType(NewPost);

    expect(expected, findsOneWidget);
  });
}
