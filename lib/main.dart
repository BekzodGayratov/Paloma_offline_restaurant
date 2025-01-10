import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_restaurant/inject_container.dart';
import 'package:offline_restaurant/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_orders/get_orders_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_products/get_products_cubit.dart';
import 'package:offline_restaurant/presentation/pages/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initSingletons();
  runApp(const PalomaApp());
}

class PalomaApp extends StatelessWidget {
  const PalomaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => sl<GetProductsCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetCategoriesCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<CreateOrderCubit>(),
        ),
        BlocProvider(
          create: (context) => sl<GetOrdersCubit>(),
        ),
      ],
      child: const MaterialApp(home: HomePage()),
    );
  }
}
