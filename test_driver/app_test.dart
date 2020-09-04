import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Authentication tests', () {
    FlutterDriver driver;

    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

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
