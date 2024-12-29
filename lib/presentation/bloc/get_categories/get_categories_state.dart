part of 'get_categories_cubit.dart';

enum GetCategoriesStatus { initial, loading, failed, success }

class GetCategoriesState extends Equatable {
  const GetCategoriesState(
      {this.status = GetCategoriesStatus.initial,
      this.error,
      this.categories = const []});
  final GetCategoriesStatus status;
  final List<CategoryEntity> categories;
  final String? error;

  GetCategoriesState copyWith({
    final GetCategoriesStatus? status,
    final List<CategoryEntity>? categories,
    final String? error,
  }) {
    return GetCategoriesState(
        status: status ?? this.status,
        categories: categories ?? this.categories,
        error: error ?? this.error);
  }

  @override
  List<Object?> get props => [status, categories, error];
}
