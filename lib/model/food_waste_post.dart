class FoodWastePost {
  String date;
  String imageUrl;
  int quantity;
  double latitude;
  double longitude;

  FoodWastePost(
      {this.date, this.imageUrl, this.quantity, this.latitude, this.longitude});

  int get wasteQuantity => quantity;
}
