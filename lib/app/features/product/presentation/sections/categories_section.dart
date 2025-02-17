import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../constants/typograph.dart';
import '../cubit/category_cubit.dart';
import '../cubit/product_cubit.dart';
import '../widgets/category_shimmer.dart';

class CategoriesSection extends StatefulWidget {
  const CategoriesSection({super.key});

  @override
  State<CategoriesSection> createState() => _CategoriesSectionState();
}

class _CategoriesSectionState extends State<CategoriesSection> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Categories',
            style: Typograph.subtitle16m,
          ),
        ),
        const SizedBox(height: 6),
        BlocBuilder<CategoryCubit, CategoryState>(
          builder: (context, state) {
            switch (state.status) {
              case CategoryStateStatus.loading:
                return const CategoryShimmer();
              case CategoryStateStatus.failure:
                return Center(
                    child: Text(state.errorMessage ?? 'Error occurred'));
              case CategoryStateStatus.success:
                return SizedBox(
                  height: 50,
                  child: ListView.builder(
                    padding: const EdgeInsets.only(left: 16),
                    scrollDirection: Axis.horizontal,
                    itemCount: state.categories.length + 1,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: RawChip(
                            selectedColor: Theme.of(context).primaryColor,
                            showCheckmark: false,
                            selected: state.selectedCategory == null,
                            label: Text('All Category',
                                style: Typograph.label12m.copyWith(
                                    color: state.selectedCategory == null
                                        ? Colors.white
                                        : Colors.black)),
                            onSelected: (_) {
                              _onAllCategorySelected();
                            },
                          ),
                        );
                      }

                      final category = state.categories[index - 1];
                      final isSelected =
                          category.name == state.selectedCategory;
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 4),
                        child: RawChip(
                          selectedColor: Theme.of(context).primaryColor,
                          showCheckmark: false,
                          selected: isSelected,
                          label: Text(category.name,
                              style: Typograph.label12m.copyWith(
                                  color: isSelected
                                      ? Colors.white
                                      : Colors.black)),
                          onSelected: (selected) {
                            _onCategorySelected(
                                selected ? category.name : null);
                          },
                        ),
                      );
                    },
                  ),
                );
              default:
                return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  void _onCategorySelected(String? category) {
    final categoryCubit = context.read<CategoryCubit>();
    final productCubit = context.read<ProductCubit>();

    if (category == null) {
      _onAllCategorySelected();
      return;
    }

    categoryCubit.selectCategory(category);
    productCubit.getCategoryProducts(category: category);
  }

  void _onAllCategorySelected() {
    final categoryCubit = context.read<CategoryCubit>();
    final productCubit = context.read<ProductCubit>();
    categoryCubit.selectCategory(null);
    productCubit.getProducts();
  }
}
