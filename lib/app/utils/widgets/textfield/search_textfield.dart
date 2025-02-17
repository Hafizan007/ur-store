import 'package:flutter/material.dart';

import '../../../config/themes/app_color.dart';
import '../../../constants/typograph.dart';

class SearchTextfield extends StatelessWidget {
  final TextEditingController searchController;
  final Function(String) onSubmitted;
  final bool? readOnly;
  final void Function()? onTap;
  final bool? autofocus;

  const SearchTextfield(
      {super.key,
      required this.searchController,
      required this.onSubmitted,
      this.readOnly,
      this.autofocus,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return TextField(
      autofocus: autofocus ?? false,
      controller: searchController,
      readOnly: readOnly ?? false,
      onTap: onTap,
      onSubmitted: onSubmitted,
      style: Typograph.body14r.copyWith(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 8,
        ),
        filled: true,
        fillColor: AppColor.greyColor,
        hintText: 'Search product',
        hintStyle: Typograph.body14r.copyWith(color: AppColor.greyTextColor),
        prefixIcon: const Icon(Icons.search, color: AppColor.blackColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
