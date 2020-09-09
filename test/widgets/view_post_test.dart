import 'package:flutter_test/flutter_test.dart';
import 'package:flutter/material.dart';
import 'package:showsomelove/models/post.dart';
import 'package:showsomelove/pages/app/view_post/view_post.dart';

Widget _viewPost(Post post) => MaterialApp(home: ViewPost(post: post));

main() {
  testWidgets('should show post details given Post', (tester) async {
    final sender = 'sender';
    final recipient = 'recipient';
    final message = 'message';
    final imageUrl = '';
    final post = Post(sender, recipient, message, imageUrl);

    await tester.pumpWidget(_viewPost(post));

    expect(find.text(recipient), findsOneWidget);
    expect(find.text(message), findsOneWidget);
    expect(find.text(imageUrl), findsNothing);
  });

  testWidgets('should render image given Post with imageurl', (tester) async {
    final sender = 'sender';
    final recipient = 'recipient';
    final message = 'message';
    final imageUrl =
        'https://www.ajactraining.org/wp-content/uploads/2019/09/image-placeholder.jpg';
    final post = Post(sender, recipient, message, imageUrl);

    await tester.pumpWidget(_viewPost(post));

    final expected = find.byKey(Key('image'));
    expect(expected, findsOneWidget);
  });
}
