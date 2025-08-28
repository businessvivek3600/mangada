

import 'package:get/get.dart';
import '../../../core/data/models/food_data_model.dart';

class CartController extends GetxController {
  var cartItems = <FoodCardData>[].obs;

  void addToCart(FoodCardData food) {
    cartItems.add(food);
  }

  void removeFromCart(FoodCardData food) {
    cartItems.remove(food);
  }

  void clearCart() {
    cartItems.clear();
  }

  double get totalPrice =>
      cartItems.fold(0, (sum, item) => sum + item.price);
}
