import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/pages/app/home/widgets/new_post.dart';
import 'package:showsomelove/pages/app/view_post.dart';
import 'package:showsomelove/routes.dart';
import 'package:showsomelove/services/user.dart';

class _UserService extends Mock implements UserService {}

final getIt = GetIt.I;

Widget _newPost() => MaterialApp(
      home: Scaffold(
        body: NewPost(),
      ),
      routes: routes,
    );

main() {
  group('NewPost widget', () {
    tearDown(() {
      getIt.reset();
    });

    testWidgets('should open ViewPost after submitting post', (tester) async {
      final _recipient = 'recipient';
      final _message = 'message';
      final _imageUrl = '';

      final _userService = _UserService();
      when(_userService.createPost(_recipient, _message, null))
          .thenAnswer((_) async => Post(_recipient, _message, _imageUrl));
      getIt.registerSingleton<UserService>(_userService);
      await tester.pumpWidget(_newPost());

      final recipient = find.byKey(Key('recipient'));
      final message = find.byKey(Key('message'));
      final submitPost = find.byKey(Key('submitPost'));

      await tester.enterText(recipient, 'recipient');
      await tester.enterText(message, 'message');

      await tester.tap(submitPost);

      await tester.pumpAndSettle();

      final expected = find.byType(ViewPost);
      expect(expected, findsOneWidget);
    });
  });
}
