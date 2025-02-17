part of 'category_cubit.dart';

enum CategoryStateStatus { initial, loading, success, failure }

class CategoryState extends Equatable {
  final CategoryStateStatus status;
  final List<CategoryEntity> categories;
  final String? errorMessage;
  final String? selectedCategory;

  const CategoryState({
    this.status = CategoryStateStatus.initial,
    this.categories = const [],
    this.errorMessage,
    this.selectedCategory, // null means "All" categories
  });

  CategoryState copyWith({
    CategoryStateStatus? status,
    List<CategoryEntity>? categories,
    String? errorMessage,
    String? selectedCategory,
    bool clearSelectedCategory = false, // Add this flag
  }) {
    return CategoryState(
      status: status ?? this.status,
      categories: categories ?? this.categories,
      errorMessage: errorMessage ?? this.errorMessage,
      selectedCategory: clearSelectedCategory
          ? null
          : (selectedCategory ?? this.selectedCategory),
    );
  }

  @override
  List<Object?> get props => [
        status,
        categories,
        errorMessage,
        selectedCategory,
      ];
}
