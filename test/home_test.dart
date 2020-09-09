import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showsomelove/pages/app/home/home.dart';
import 'package:showsomelove/pages/app/home/widgets/new_post.dart';

MaterialApp _home() => MaterialApp(home: Home());
main() {
  testWidgets('new post button opens new post widget',
      (WidgetTester tester) async {
    final newPost = find.byKey(Key('newPost'));

    await tester.pumpWidget(_home());
    // await tester.pumpAndSettle();
    await tester.press(newPost);

    final expected = find.byType(NewPost);
    await tester.pumpAndSettle();

    expect(expected, findsOneWidget);
  });
}
