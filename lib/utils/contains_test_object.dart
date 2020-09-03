import 'dart:io';

const flutterTestEnv = 'FLUTTER_TEST';

bool containsTestObject(dynamic testObject) =>
    Platform.environment.containsKey(flutterTestEnv)
        ? testObject != null
        : true;
