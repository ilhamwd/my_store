import 'package:get/get.dart';
import 'package:my_store/bindings/checkout_binding.dart';
import 'package:my_store/bindings/product_binding.dart';
import 'package:my_store/bindings/transaction_binding.dart';
import 'package:my_store/views/cart.dart';
import 'package:my_store/views/checkout.dart';
import 'package:my_store/views/home.dart';
import 'package:my_store/views/product_detail.dart';
import 'package:my_store/views/transactions.dart';
import 'package:my_store/views/wishlist.dart';

class Routes {
  static String home = "/home";
  static String productDetail = "/product-detail";
  static String cart = "/cart";
  static String wishlist = "/wishlist";
  static String checkout = "/checkout";
  static String transactions = "/transactions";
}

final getRoutes = [
  GetPage(
      name: Routes.home, page: () => const Home(), binding: ProductBinding()),
  GetPage(
      name: Routes.cart, page: () => const Cart(), binding: ProductBinding()),
  GetPage(
      name: Routes.transactions,
      page: () => const TransactionsHistory(),
      binding: TransactionBinding()),
  GetPage(
      name: Routes.wishlist,
      page: () => const Wishlist(),
      binding: ProductBinding()),
  GetPage(
      name: Routes.checkout,
      page: () => const Checkout(),
      binding: CheckoutBinding()),
  GetPage(
      name: Routes.productDetail,
      page: () => const ProductDetail(),
      transition: Transition.fadeIn),
];
