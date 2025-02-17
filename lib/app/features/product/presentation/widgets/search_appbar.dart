import 'package:flutter/material.dart';

import '../../../../utils/widgets/textfield/search_textfield.dart';

class SearchAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final TextEditingController searchController;
  final Function(String) onSubmitted;

  final bool showBackButton;

  const SearchAppBar({
    super.key,
    required this.title,
    required this.searchController,
    required this.onSubmitted,
    this.showBackButton = true,
  });

  @override
  Size get preferredSize => const Size.fromHeight(120);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Column(
        children: [
          SizedBox(height: MediaQuery.of(context).padding.top - 10),
          Row(
            children: [
              IconButton(
                icon: const Icon(Icons.arrow_back),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              Expanded(
                child: SearchTextfield(
                  searchController: searchController,
                  onSubmitted: onSubmitted,
                  autofocus: true,
                ),
              ),
              const SizedBox(width: 16),
            ],
          ),
          const SizedBox(height: 8)
        ],
      ),
    );
  }
}
