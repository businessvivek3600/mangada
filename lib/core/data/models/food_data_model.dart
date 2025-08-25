
class FoodCardData {
  final String title;
  final String subtitle;
  final double price;
  final double oldPrice;
  final double rating;
  final int reviews;

  FoodCardData({
  required this.title,
  required this.subtitle,
  required this.price,
  required this.oldPrice,
  required this.rating,
  required this.reviews,
  });
}

var items = [
  FoodCardData(
    title: "Gudeg",
    subtitle: "Gudeg Mbok Jum",
    price: 4.0,
    oldPrice: 3.5,
    rating: 4.9,
    reviews: 115,
  ),
  FoodCardData(
    title: "Sate Padang",
    subtitle: "Sate Pak Maman",
    price: 2.0,
    oldPrice: 3.0,
    rating: 4.9,
    reviews: 115,
  ),
  FoodCardData(
    title: "Nasi Liwet",
    subtitle: "Resto Mbok Jiah",
    price: 3.0,
    oldPrice: 5.0,
    rating: 4.9,
    reviews: 115,
  ),
  FoodCardData(
    title: "Gudeg",
    subtitle: "Gudeg Mbok Yem",
    price: 4.0,
    oldPrice: 5.0,
    rating: 4.0,
    reviews: 200,
  ),
];