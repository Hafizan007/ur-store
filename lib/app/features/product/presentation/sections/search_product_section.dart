import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';

import '../../../../config/router/app_router.gr.dart';
import '../../../../constants/typograph.dart';
import '../../../../utils/widgets/textfield/search_textfield.dart';

class SearchProductSection extends StatefulWidget {
  const SearchProductSection({super.key});

  @override
  State<SearchProductSection> createState() => _SearchProductSectionState();
}

class _SearchProductSectionState extends State<SearchProductSection> {
  final searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Hi,',
            style: Typograph.label16m,
          ),
          const SizedBox(height: 4),
          Text('What are you looking for today?', style: Typograph.subtitle20m),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: SearchTextfield(
                  searchController: searchController,
                  onSubmitted: (p0) {},
                  readOnly: true,
                  onTap: () {
                    context.pushRoute(const SearchProductRoute());
                  },
                ),
              ),
              const SizedBox(width: 8),
            ],
          ),
        ],
      ),
    );
  }
}
