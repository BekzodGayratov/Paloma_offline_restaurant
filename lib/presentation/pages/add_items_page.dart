import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/widgets/loading_widget.dart';

class AddItemsPage extends StatelessWidget {
  final String title;
  const AddItemsPage({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: const Column(
        children: [Text('asdasd')],
      ),
      bottomSheet: DraggableScrollableSheet(
        snap: true,
        expand: true,
        maxChildSize: 0.9,
        initialChildSize: 0.3,
        builder: (context, scrollController) {
          return Visibility(
              child: _CategoriesView(scrollController: scrollController));
        },
      ),
    );
  }
}

class _ItemsView extends StatelessWidget {
  const _ItemsView();

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _CategoriesView extends StatelessWidget {
  final ScrollController scrollController;
  const _CategoriesView({required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, state) {
        if (state.status == GetCategoriesStatus.loading) {
          return const Center(child: LoadingWidget());
        } else if (state.status == GetCategoriesStatus.failed) {
          return Center(child: Text(state.error.toString()));
        } else if (state.status == GetCategoriesStatus.success) {
          final cats = state.categories;
          if (cats.isEmpty) {
            return const Center(child: Text('No categories'));
          }
          return GridView.builder(
            controller: scrollController,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 3,
              childAspectRatio: 2,
            ),
            itemCount: cats.length,
            itemBuilder: (context, index) {
              final cat = cats[index];
              return ElevatedButton(
                onPressed: () {},
                child: Center(
                  child: Text(cat.title ?? ''),
                ),
              );
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}
