import 'package:my_store/domain/models/product.dart';

abstract class ProductUseCases {
  Future<List<ProductModel>> getProducts();

  Future<void> addToCart(ProductModel data);

  Future<void> updateCartQty(ProductModel data, int qty);

  Future<void> deleteFromCart(ProductModel data);

  Future<List<ProductModel>> getCartItems();

  Future<void> addToWishlist(ProductModel data);

  Future<void> deleteFromWishlist(ProductModel data);

  Future<List<ProductModel>> getWishlistItems();
}
