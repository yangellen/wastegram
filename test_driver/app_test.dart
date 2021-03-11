import 'package:flutter_driver/flutter_driver.dart';
import 'package:test/test.dart';

void main() {
  group('Wastegram App', () {
    // final counterTextFinder = find.byValueKey('counter');
    // final buttonFinder = find.byValueKey('increment');

    FlutterDriver driver;

    //connet to the flutter driver before running any tests.
    setUpAll(() async {
      driver = await FlutterDriver.connect();
    });

    //close connection when done
    tearDownAll(() async {
      if (driver != null) {
        driver.close();
      }
    });

    test('verifies that list contains most recent post', () async {
      final listFinder = find.byValueKey('post_list');
      final itemFinder = find.byValueKey('item_0_text');

      await driver.scrollUntilVisible(
        listFinder,
        itemFinder,
        dyScroll: -300.0,
      );
      expect(await driver.getText(itemFinder), 'Wednesday, March 10, 2021');
    });

    // test('starts at 0', () async {
    //   expect(await driver.getText(counterTextFinder), '0');
    // });

    // test('increments the counter', () async {
    //   await driver.tap(buttonFinder);
    //   expect(await driver.getText(counterTextFinder), '1');
    // });
  });
}
