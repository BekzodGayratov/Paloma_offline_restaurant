import 'package:get_it/get_it.dart';
import 'package:offline_restaurant/data/datasources/category_local_data_source.dart';
import 'package:offline_restaurant/data/datasources/order_local_data_source.dart';
import 'package:offline_restaurant/data/datasources/product_local_data_source.dart';
import 'package:offline_restaurant/data/repositories/category_repository_impl.dart';
import 'package:offline_restaurant/data/repositories/order_repository_impl.dart';
import 'package:offline_restaurant/data/repositories/product_repository_impl.dart';
import 'package:offline_restaurant/domain/repositories/category_repository.dart';
import 'package:offline_restaurant/domain/repositories/order_repository.dart';
import 'package:offline_restaurant/domain/repositories/product_repository.dart';
import 'package:offline_restaurant/domain/usecases/create_order_usecase.dart';
import 'package:offline_restaurant/domain/usecases/get_categories_usecase.dart';
import 'package:offline_restaurant/domain/usecases/get_orders_usecase.dart';
import 'package:offline_restaurant/domain/usecases/get_product_usecase.dart';
import 'package:offline_restaurant/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_orders/get_orders_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'paloma_pos.db');
  return await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      // Create tables
      await db.execute('''
       CREATE TABLE categories (
         id INTEGER PRIMARY KEY,
         title TEXT NOT NULL
       )
     ''');

      await db.execute('''
       CREATE TABLE products (
         id INTEGER PRIMARY KEY,
         title TEXT NOT NULL,
         price REAL NOT NULL,
         categoryId INTEGER NOT NULL,
         FOREIGN KEY (categoryId) REFERENCES categories (id)
       )
     ''');

      await db.execute('''
       CREATE TABLE orders (
         id INTEGER PRIMARY KEY,
         orderDate DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
         totalAmount REAL NOT NULL,
         status TEXT NOT NULL DEFAULT 'completed'
       )
     ''');

      await db.execute('''
       CREATE TABLE order_items (
         id INTEGER PRIMARY KEY,
         orderId INTEGER NOT NULL,
         productId INTEGER NOT NULL,
         quantity INTEGER NOT NULL,
         priceAtOrder REAL NOT NULL,
         FOREIGN KEY (orderId) REFERENCES orders (id),
         FOREIGN KEY (productId) REFERENCES products (id)
       )
     ''');

      // Insert initial categories
      final categoryBatch = db.batch();

      categoryBatch.insert('categories', {'id': 1, 'title': 'Hot Drinks'});
      categoryBatch.insert('categories', {'id': 2, 'title': 'Cold Drinks'});
      categoryBatch.insert('categories', {'id': 3, 'title': 'Pastries'});
      categoryBatch.insert('categories', {'id': 4, 'title': 'Desserts'});

      await categoryBatch.commit();

      // Insert initial products
      final productBatch = db.batch();

      // Hot Drinks
      productBatch.insert('products', {
        'title': 'Espresso',
        'price': 2.99,
        'categoryId': 1,
      });
      productBatch.insert('products', {
        'title': 'Cappuccino',
        'price': 3.99,
        'categoryId': 1,
      });
      productBatch.insert('products', {
        'title': 'Latte',
        'price': 3.99,
        'categoryId': 1,
      });
      productBatch.insert('products', {
        'title': 'Turkish Coffee',
        'price': 3.49,
        'categoryId': 1,
      });

      // Cold Drinks
      productBatch.insert('products', {
        'title': 'Iced Coffee',
        'price': 3.99,
        'categoryId': 2,
      });
      productBatch.insert('products', {
        'title': 'Iced Tea',
        'price': 2.99,
        'categoryId': 2,
      });
      productBatch.insert('products', {
        'title': 'Lemonade',
        'price': 2.99,
        'categoryId': 2,
      });
      productBatch.insert('products', {
        'title': 'Smoothie',
        'price': 4.99,
        'categoryId': 2,
      });

      // Pastries
      productBatch.insert('products', {
        'title': 'Croissant',
        'price': 2.99,
        'categoryId': 3,
      });
      productBatch.insert('products', {
        'title': 'Muffin',
        'price': 2.49,
        'categoryId': 3,
      });
      productBatch.insert('products', {
        'title': 'Danish',
        'price': 2.99,
        'categoryId': 3,
      });
      productBatch.insert('products', {
        'title': 'Bagel',
        'price': 1.99,
        'categoryId': 3,
      });

      // Desserts
      productBatch.insert('products', {
        'title': 'Cheesecake',
        'price': 4.99,
        'categoryId': 4,
      });
      productBatch.insert('products', {
        'title': 'Chocolate Cake',
        'price': 4.99,
        'categoryId': 4,
      });
      productBatch.insert('products', {
        'title': 'Tiramisu',
        'price': 5.99,
        'categoryId': 4,
      });
      productBatch.insert('products', {
        'title': 'Apple Pie',
        'price': 4.49,
        'categoryId': 4,
      });

      await productBatch.commit();
    },
  );
}

final sl = GetIt.instance;

Future<void> initSingletons() async {
  final db = await openDB();
  sl.registerSingleton<Database>(db);

  // Data Sources
  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl(sl<Database>()));

  // Repositories
  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl<CategoryLocalDataSource>()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductLocalDataSource>()));

  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(sl<OrderLocalDataSource>()));

  // Use Cases
  sl.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(sl<CategoryRepository>()));

  sl.registerLazySingleton<GetProductsUsecase>(
      () => GetProductsUsecase(sl<ProductRepository>()));

  sl.registerLazySingleton<CreateOrderUsecase>(
      () => CreateOrderUsecase(sl<OrderRepository>()));

  sl.registerLazySingleton<GetOrdersUsecase>(
      () => GetOrdersUsecase(sl<OrderRepository>()));

  // Cubits/BLoCs
  sl.registerFactory<GetCategoriesCubit>(
      () => GetCategoriesCubit(sl<GetCategoriesUsecase>()));

  sl.registerFactory<GetProductsCubit>(
      () => GetProductsCubit(sl<GetProductsUsecase>()));

  sl.registerFactory<GetOrdersCubit>(
      () => GetOrdersCubit(sl<GetOrdersUsecase>()));

  sl.registerFactory<CreateOrderCubit>(
      () => CreateOrderCubit(sl<OrderRepository>()));
}
