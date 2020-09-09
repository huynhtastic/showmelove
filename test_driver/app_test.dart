import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  FlutterDriver driver;

  setUpAll(() async {
    driver = await FlutterDriver.connect();
  });

  tearDownAll(() async {
    if (driver != null) {
      driver.close();
    }
  });

  Future<void> _registerNewUser(String username) async {
    final authToggle = find.byValueKey('toggleAuth');
    final email = find.byValueKey('email');
    final password = find.byValueKey('password');
    final name = find.byValueKey('name');
    final authenticate = find.byValueKey('authenticate');

    await driver.tap(authToggle);

    await driver.tap(email);
    await driver.enterText('$username@testmail.com');
    await driver.tap(password);
    await driver.enterText(username);
    await driver.tap(name);
    await driver.enterText(username);

    await driver.tap(authenticate);
  }

  group('Post tests', () {
    test('should make and view post without img', () async {
      await _registerNewUser('viewPostUser');

      // start from home page
      final newPost = find.byValueKey('newPost');
      final recipient = find.byValueKey('recipient');
      final message = find.byValueKey('message');
      final createPost = find.byValueKey('submitPost');

      await driver.tap(newPost);
      await driver.tap(recipient);
      await driver.enterText('test recipient');
      await driver.tap(message);
      await driver.enterText('test message');

      await driver.tap(createPost);
    });
  });

  group('Authentication tests', () {
    test('should make new user with register form', () async {
      final authToggle = find.byValueKey('toggleAuth');
      final email = find.byValueKey('email');
      final password = find.byValueKey('password');
      final name = find.byValueKey('name');
      final authenticate = find.byValueKey('authenticate');

      await driver.tap(authToggle);

      await driver.tap(email);
      await driver.enterText('test@email.com');
      await driver.tap(password);
      await driver.enterText('password');
      await driver.tap(name);
      await driver.enterText('name name');

      await driver.tap(authenticate);
    });
  });
}
