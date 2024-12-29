import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_restaurant/inject_container.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_tables/get_tables_cubit.dart';
import 'package:offline_restaurant/presentation/pages/tables_page.dart';

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
          create: (context) => sl<GetTablesCubit>()..getTables(),
        ),
        BlocProvider(
          create: (context) => sl<GetCategoriesCubit>()..getCategories(),
        ),
      ],
      child: const MaterialApp(home: TablesPage()),
    );
  }
}
