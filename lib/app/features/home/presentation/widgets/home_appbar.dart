import 'package:flutter/material.dart';

import '../../../../../gen/assets.gen.dart';
import '../../../../config/themes/app_color.dart';
import '../../../cart/presentation/widgets/cart_badge.dart';

class HomeAppbar extends StatelessWidget implements PreferredSizeWidget {
  const HomeAppbar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      toolbarHeight: MediaQuery.of(context).viewPadding.top + 40,
      title: Row(
        children: [
          const Icon(
            Icons.account_circle_sharp,
            color: AppColor.primaryColor,
            size: 30,
          ),
          const SizedBox(width: 32),
          Image.asset(
            Assets.images.app.logo.path,
            width: 140,
          ),
          const Spacer(),
        ],
      ),
      actions: const [
        CartItem(),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
