import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:showsomelove/pages/app/home/widgets/new_post.dart';
import 'package:showsomelove/pages/app/home/widgets/view_post.dart';

Widget _newPost() => MaterialApp(home: Scaffold(body: NewPost()));

main() {
  group('NewPost widget', () {
    testWidgets('should open ViewPost after submitting post', (tester) async {
      await tester.pumpWidget(_newPost());

      final recipient = find.byKey(Key('recipient'));
      final message = find.byKey(Key('message'));
      final createPost = find.byKey(Key('createPost'));

      await tester.enterText(recipient, 'recipient');
      await tester.enterText(message, 'message');

      await tester.tap(createPost);

      final expected = find.byType(ViewPost);
      expect(expected, findsOneWidget);
    });
  });
}
