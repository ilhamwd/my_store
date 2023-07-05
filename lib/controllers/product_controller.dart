import 'package:get/get.dart';
import 'package:my_store/domain/models/product.dart';
import 'package:my_store/domain/repository/product.dart';
import 'package:my_store/helpers.dart';
import 'package:my_store/routes.dart';

class ProductController extends GetxController {
  final repository = ProductRepository();

  RxBool isInitialized = false.obs;

  RxList<ProductModel> wishlist = <ProductModel>[].obs,
      cart = <ProductModel>[].obs,
      data = <ProductModel>[].obs;

  void getInitialData() async {
    await getProducts();

    cart.value = await repository.getCartItems();
    wishlist.value = await repository.getWishlistItems();
    isInitialized.value = true;
  }

  Future<void> getProducts() async {
    final products = await repository.getProducts();

    // Restore all wishlisted items
    final wishlists = wishlist.map((element) => element.id);
    data.value =
        products.map((e) => e..wishlisted = wishlists.contains(e.id)).toList();
  }

  order(ProductModel data) async {
    await addToCart(data);

    Get.toNamed(Routes.cart);
  }

  updateCartQty(ProductModel data, int qty) async {
    if (qty < 1) {
      await repository.deleteFromCart(data);
    } else {
      await repository.updateCartQty(data, qty);
    }

    cart.value = await repository.getCartItems();
  }

  addToCart(ProductModel data) async {
    // Check for existing carts
    final current = cart.where((p0) => p0.id == data.id);

    if (current.isNotEmpty) {
      await updateCartQty(data, current.first.qty + 1);
    } else {
      await repository.addToCart(data..qty = 1);
    }

    cart.value = await repository.getCartItems();

    Helpers.showSnackBar("Successfully added 1 item to cart");
  }

  addToWishlist(ProductModel data) async {
    // Check for existing wishlists
    final current = wishlist.where((p0) => p0.id == data.id);

    if (current.isNotEmpty) {
      await repository.deleteFromWishlist(data);
    } else {
      await repository.addToWishlist(
          data..qty = current.isEmpty ? 1 : current.first.qty + 1);
    }

    wishlist.value = await repository.getWishlistItems();

    await getProducts();
  }

  @override
  void onInit() {
    super.onInit();

    getInitialData();
  }
}
