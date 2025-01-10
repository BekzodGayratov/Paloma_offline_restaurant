import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:offline_restaurant/features/order_managent/domain/entities/order_item_entity.dart';
import 'package:offline_restaurant/presentation/bloc/create_order/create_order_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_categories/get_categories_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_orders/get_orders_cubit.dart';
import 'package:offline_restaurant/presentation/bloc/get_products/get_products_cubit.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Menu'),
        actions: [
          // Cart Button
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const CartPage()),
            ),
          ),
          // Order History Button
          IconButton(
            icon: const Icon(Icons.history),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const OrderHistoryPage()),
            ),
          ),
        ],
      ),
      body: const MenuContent(),
    );
  }
}

class MenuContent extends StatefulWidget {
  const MenuContent({super.key});

  @override
  State<MenuContent> createState() => _MenuContentState();
}

class _MenuContentState extends State<MenuContent> {
  @override
  void initState() {
    super.initState();
    context.read<GetCategoriesCubit>().getCategories();
    context.read<GetProductsCubit>().getProducts();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetCategoriesCubit, GetCategoriesState>(
      builder: (context, categoryState) {
        if (categoryState.status == GetCategoriesStatus.loading) {
          return const Center(child: CircularProgressIndicator());
        }

        return BlocBuilder<GetProductsCubit, GetProductsState>(
          builder: (context, productState) {
            if (productState.status == GetProductsStatus.loading) {
              return const Center(child: CircularProgressIndicator());
            }

            return ListView.builder(
              itemCount: categoryState.categories.length,
              itemBuilder: (context, index) {
                final category = categoryState.categories[index];
                final categoryProducts = productState.products
                    .where((p) => p.categoryId == category.id)
                    .toList();

                return ExpansionTile(
                  title: Text(category.title ?? ''),
                  children: categoryProducts.map((product) {
                    return ListTile(
                      title: Text(product.title ?? ''),
                      subtitle: Text('\$${product.amount?.toStringAsFixed(2)}'),
                      trailing: IconButton(
                        icon: const Icon(Icons.add_shopping_cart),
                        onPressed: () {
                          // Add to cart
                          context.read<CreateOrderCubit>().addItem(
                                OrderItemModel(
                                  productId: product.id!,
                                  quantity: 1,
                                  priceAtOrder:
                                      (product.amount ?? 0).toDouble(),
                                  orderId: 0, // Temporary ID
                                ),
                              );
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text('Added to cart'),
                              duration: Duration(seconds: 1),
                            ),
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            );
          },
        );
      },
    );
  }
}

// cart_page.dart
class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Cart')),
      body: BlocBuilder<CreateOrderCubit, CreateOrderState>(
        builder: (context, state) {
          if (state.status == CreateOrderStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.orderItems.isEmpty) {
            return const Center(
              child: Text('Your cart is empty'),
            );
          }

          // Calculate total amount from items
          final totalAmount = state.orderItems.fold<double>(
              0, (sum, item) => sum + (item.quantity * item.priceAtOrder));

          return Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: state.orderItems.length,
                  itemBuilder: (context, index) {
                    final item = state.orderItems[index];
                    return ListTile(
                      title: BlocBuilder<GetProductsCubit, GetProductsState>(
                        builder: (context, productState) {
                          final product = productState.products
                              .firstWhere((p) => p.id == item.productId);
                          return Text(product.title ?? '');
                        },
                      ),
                      subtitle: Text(
                        'Quantity: ${item.quantity} × \$${item.priceAtOrder.toStringAsFixed(2)} = \$${(item.quantity * item.priceAtOrder).toStringAsFixed(2)}',
                      ),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.remove),
                            onPressed: () {
                              if (item.quantity > 1) {
                                context
                                    .read<CreateOrderCubit>()
                                    .updateItemQuantity(
                                      index,
                                      item.quantity - 1,
                                    );
                              } else {
                                context
                                    .read<CreateOrderCubit>()
                                    .removeItem(index);
                              }
                            },
                          ),
                          Text('${item.quantity}'),
                          IconButton(
                            icon: const Icon(Icons.add),
                            onPressed: () {
                              context
                                  .read<CreateOrderCubit>()
                                  .updateItemQuantity(
                                    index,
                                    item.quantity + 1,
                                  );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.surface,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 4,
                      offset: const Offset(0, -2),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total Amount:',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        Text(
                          '\$${totalAmount.toStringAsFixed(2)}',
                          style:
                              Theme.of(context).textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                        onPressed: () async {
                          try {
                            await context.read<CreateOrderCubit>().createOrder(
                                  items: state.orderItems,
                                  totalAmount: totalAmount,
                                );

                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                  content: Text('Order placed successfully!'),
                                  backgroundColor: Colors.green,
                                ),
                              );
                              Navigator.pop(context);
                            }
                          } catch (e) {
                            if (context.mounted) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                      'Failed to place order: ${e.toString()}'),
                                  backgroundColor: Colors.red,
                                ),
                              );
                            }
                          }
                        },
                        child: const Text('Place Order'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

// order_history_page.dart
class OrderHistoryPage extends StatefulWidget {
  const OrderHistoryPage({super.key});

  @override
  State<OrderHistoryPage> createState() => _OrderHistoryPageState();
}

class _OrderHistoryPageState extends State<OrderHistoryPage> {
  @override
  void initState() {
    super.initState();
    context.read<GetOrdersCubit>().getOrders();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Order History')),
      body: BlocBuilder<GetOrdersCubit, GetOrdersState>(
        builder: (context, state) {
          if (state.status == GetOrdersStatus.loading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state.orders.isEmpty) {
            return const Center(
              child: Text('No orders yet'),
            );
          }

          return ListView.builder(
            itemCount: state.orders.length,
            itemBuilder: (context, index) {
              final order = state.orders[index];
              return ListTile(
                title: Text('Order #${order.id}'),
                subtitle: Text(
                  'Date: ${DateFormat('MMM dd, yyyy HH:mm').format(order.orderDate)}\n'
                  'Total: \$${order.totalAmount.toStringAsFixed(2)}',
                ),
              );
            },
          );
        },
      ),
    );
  }
}
