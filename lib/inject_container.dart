import 'package:get_it/get_it.dart';
import 'package:offline_restaurant/features/order_managent/data/datasources/category_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/datasources/order_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/datasources/product_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/datasources/table_local_data_source.dart';
import 'package:offline_restaurant/features/order_managent/data/repositories/category_repository_impl.dart';
import 'package:offline_restaurant/features/order_managent/data/repositories/order_repository_impl.dart';
import 'package:offline_restaurant/features/order_managent/data/repositories/product_repository_impl.dart';
import 'package:offline_restaurant/features/order_managent/data/repositories/table_repository_impl.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/category_repository.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/order_repository.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/product_repository.dart';
import 'package:offline_restaurant/features/order_managent/domain/repositories/table_repository.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/add_table_usecase.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/get_categories_usecase.dart';
import 'package:offline_restaurant/features/order_managent/domain/usecases/get_tables_usecase.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_tables/get_tables_cubit.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

Future<Database> openDB() async {
  final dbPath = await getDatabasesPath();
  final path = join(dbPath, 'paloma_pos.db');
  return await openDatabase(
    path,
    version: 2,
    onCreate: (db, version) async {
      await db.execute('''
        CREATE TABLE tables (
          id INTEGER PRIMARY KEY,
          name TEXT,
          status TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE categories (
          id INTEGER PRIMARY KEY,
          title TEXT
        )
      ''');

      await db.execute('''
        CREATE TABLE products (
          id INTEGER PRIMARY KEY,
          title TEXT,
          amount REAL,
          categoryId INTEGER,
          FOREIGN KEY (categoryId) REFERENCES categories (id)
        )
      ''');

      await db.execute('''
        CREATE TABLE orders (
          id INTEGER PRIMARY KEY,
          tableId INTEGER,
          productId INTEGER,
          quantity INTEGER,
          FOREIGN KEY (tableId) REFERENCES tables (id),
          FOREIGN KEY (productId) REFERENCES products (id)
        )
      ''');
    },
  );
}

final sl = GetIt.instance;

Future<void> initSingletons() async {
  final tableDB = await openDB();
  sl.registerSingleton<Database>(tableDB);

  sl.registerLazySingleton<TableLocalDataSource>(
      () => TableLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<OrderLocalDataSource>(
      () => OrderLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<CategoryLocalDataSource>(
      () => CategoryLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<ProductLocalDataSource>(
      () => ProductLocalDataSourceImpl(sl<Database>()));

  sl.registerLazySingleton<TableRepository>(
      () => TableRepositoryImpl(sl<TableLocalDataSource>()));

  sl.registerLazySingleton<OrderRepository>(
      () => OrderRepositoryImpl(sl<OrderLocalDataSource>()));

  sl.registerLazySingleton<CategoryRepository>(
      () => CategoryRepositoryImpl(sl<CategoryLocalDataSource>()));

  sl.registerLazySingleton<ProductRepository>(
      () => ProductRepositoryImpl(sl<ProductLocalDataSource>()));

  sl.registerLazySingleton<GetTablesUsecase>(
      () => GetTablesUsecase(sl<TableRepository>()));

  sl.registerLazySingleton<AddTableUsecase>(
      () => AddTableUsecase(sl<TableRepository>()));

  sl.registerLazySingleton<GetCategoriesUsecase>(
      () => GetCategoriesUsecase(sl<CategoryRepository>()));

  sl.registerFactory<GetTablesCubit>(
      () => GetTablesCubit(sl<GetTablesUsecase>()));

  sl.registerFactory<GetCategoriesCubit>(
      () => GetCategoriesCubit(sl<GetCategoriesUsecase>()));
}
