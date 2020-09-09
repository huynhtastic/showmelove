import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/pages/app/home/widgets/posts_list.dart';
import 'package:showsomelove/pages/app/view_post/view_post.dart';
import 'package:showsomelove/routes.dart';
import 'package:showsomelove/services/user.dart';

class _UserService extends Mock implements UserService {}

Widget _postsList(_UserService s) =>
    MaterialApp(home: PostsList(service: s), routes: routes);

main() {
  testWidgets('should build one listtile given one post', (tester) async {
    final _service = _UserService();
    when(_service.getPosts).thenAnswer((_) async* {
      yield [Post('asdf', 'asdf', 'asdf', 'asdf')];
    });
    await tester.pumpWidget(_postsList(_service));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsOneWidget);
  });

  testWidgets('should build empty list given no items', (tester) async {
    final _service = _UserService();
    when(_service.getPosts).thenAnswer((_) async* {
      yield [];
    });
    await tester.pumpWidget(_postsList(_service));
    await tester.pump();

    expect(find.byType(ListView), findsOneWidget);
    expect(find.byType(ListTile), findsNothing);
  });

  testWidgets('should show sender in the list tile title', (tester) async {
    final _service = _UserService();
    final sender = 'sender';
    when(_service.getPosts).thenAnswer((_) async* {
      yield [Post(sender, 'asdf', 'asdf', 'asdf')];
    });
    await tester.pumpWidget(_postsList(_service));
    await tester.pump();

    final Text title = find.byKey(Key('sender')).evaluate().first.widget;

    expect(title.data, equals(sender));
  });

  testWidgets('should open ViewPost when post item pressed', (tester) async {
    final _service = _UserService();
    when(_service.getPosts).thenAnswer((_) async* {
      yield [Post('asdf', 'asdf', 'asdf', 'asdf')];
    });
    await tester.pumpWidget(_postsList(_service));
    await tester.pump();

    await tester.tap(find.byKey(Key('post_tile0')));
    await tester.pump();
    await tester.pump();
    expect(find.byType(ViewPost), findsOneWidget);
  });
}
