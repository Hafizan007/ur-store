import 'package:injectable/injectable.dart';
import 'package:sqflite/sqflite.dart';

import '../../../../../config/data/datasources/local/database_helper.dart';
import '../../../../../config/networking/app_exception.dart';
import '../../../../../constants/db_constant.dart';
import '../../models/cart_model.dart';

abstract class CartLocalDataSource {
  Future<List<CartModel>> getCart();
  Future<CartModel> addToCart(CartModel cart);
  Future<void> updateCart(CartModel cart);
  Future<void> removeFromCart(int id);
}

@LazySingleton(as: CartLocalDataSource)
class CartLocalDataSourceImpl implements CartLocalDataSource {
  final DatabaseHelper databaseHelper;

  CartLocalDataSourceImpl({required this.databaseHelper});

  @override
  Future<List<CartModel>> getCart() async {
    try {
      final db = await databaseHelper.database;
      final List<Map<String, dynamic>> maps =
          await db.query(DbConstant.cartTable);
      return List.generate(maps.length, (i) => CartModel.fromJson(maps[i]));
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<CartModel> addToCart(CartModel cart) async {
    try {
      final db = await databaseHelper.database;

      // Check if product already exists in cart
      final List<Map<String, dynamic>> existing = await db.query(
        DbConstant.cartTable,
        where: 'productId = ?',
        whereArgs: [cart.productId],
      );

      if (existing.isNotEmpty) {
        // Update quantity if product exists
        final existingCart = CartModel.fromJson(existing.first);
        final updatedCart = CartModel(
          id: existingCart.id,
          productId: existingCart.productId,
          title: existingCart.title,
          price: existingCart.price,
          image: existingCart.image,
          quantity: existingCart.quantity + cart.quantity,
        );

        await db.update(
          DbConstant.cartTable,
          updatedCart.toJson(),
          where: 'id = ?',
          whereArgs: [existingCart.id],
        );

        return updatedCart;
      } else {
        // Insert new product if it doesn't exist
        final id = await db.insert(
          DbConstant.cartTable,
          cart.toJson(),
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        return cart.copyWith(id: id);
      }
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> updateCart(CartModel cart) async {
    try {
      final db = await databaseHelper.database;
      await db.update(
        DbConstant.cartTable,
        cart.toJson(),
        where: 'id = ?',
        whereArgs: [cart.id],
      );
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }

  @override
  Future<void> removeFromCart(int id) async {
    try {
      final db = await databaseHelper.database;
      await db.delete(
        DbConstant.cartTable,
        where: 'id = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
