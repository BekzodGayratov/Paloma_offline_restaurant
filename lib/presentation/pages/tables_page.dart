import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/table_entity.dart';
import 'package:offline_restaurant/presentation/bloc/get_tables/get_tables_cubit.dart';
import 'package:offline_restaurant/presentation/pages/add_items_page.dart';
import 'package:offline_restaurant/presentation/widgets/loading_widget.dart';

class TablesPage extends StatelessWidget {
  const TablesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: BlocBuilder<GetTablesCubit, GetTablesState>(
        builder: (context, state) {
          if (state.status == GetTablesStatus.loading) {
            return const Center(child: LoadingWidget());
          } else if (state.status == GetTablesStatus.failed) {
            return Center(child: Text(state.error.toString()));
          } else if (state.status == GetTablesStatus.success) {
            return _LoadedView(tables: state.tables);
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }
}

class _LoadedView extends StatelessWidget {
  final List<TableEntity> tables;
  const _LoadedView({required this.tables});

  @override
  Widget build(BuildContext context) {
    if (tables.isEmpty) {
      return const Center(child: Text("No tables available."));
    } else {
      return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          childAspectRatio: 2,
        ),
        itemCount: tables.length,
        itemBuilder: (context, index) {
          final table = tables[index];
          return ElevatedButton(
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(
                builder: (context) => AddItemsPage(title: table.name??''))),
            child: Center(
              child: Text(table.name??''),
            ),
          );
        },
      );
    }
  }
}
