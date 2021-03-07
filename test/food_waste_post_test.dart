import 'package:flutter_test/flutter_test.dart';
import 'package:wastegram/model/food_waste_post.dart';

void main() {
  //mock data
  const date = '2021-03-06';
  const imageUrl = 'Testing';
  const quantity = 1;
  const latitude = 1.0;
  const longitude = 2.0;

  final newPost = FoodWastePost();

  test('FoodWastePost object have null value before setting', () {
    expect(newPost.date, null);
    expect(newPost.imageUrl, null);
    expect(newPost.quantity, null);
    expect(newPost.latitude, null);
    expect(newPost.longitude, null);
  });

  test('FoodWastePost constructor have appropriate property value', () {
    newPost.date = date;
    newPost.imageUrl = imageUrl;
    newPost.quantity = quantity;
    newPost.latitude = latitude;
    newPost.longitude = longitude;

    expect(newPost.date, date);
    expect(newPost.imageUrl, imageUrl);
    expect(newPost.quantity, quantity);
    expect(newPost.latitude, latitude);
    expect(newPost.longitude, longitude);
  });

  test('get wasteQuantity return the correct value', () {
    final count = newPost.wasteQuantity;

    expect(count, quantity);
  });
}
