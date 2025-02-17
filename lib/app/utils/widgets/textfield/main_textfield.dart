import 'package:flutter/material.dart';

import '../../../config/themes/app_color.dart';
import '../../../constants/typograph.dart';

class MainTextfield extends StatefulWidget {
  final TextEditingController controller;
  final String labelText;
  final bool obscureText;
  final String? Function(String?)? validator;
  final int? minLines;
  final int? maxLines;
  final bool? readOnly;
  final void Function()? onTap;
  final FocusNode? focusNode;
  final bool? autofocus;
  final Widget? prefixIcon;

  const MainTextfield({
    super.key,
    required this.controller,
    required this.labelText,
    this.obscureText = false,
    this.validator,
    this.minLines,
    this.maxLines,
    this.readOnly,
    this.onTap,
    this.focusNode,
    this.autofocus,
    this.prefixIcon,
  });

  @override
  State<MainTextfield> createState() => _MainTextfieldState();
}

class _MainTextfieldState extends State<MainTextfield> {
  late bool _passwordVisible;

  @override
  void initState() {
    super.initState();
    _passwordVisible = !widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    return FocusScope(
      child: GestureDetector(
        onTap: widget.onTap,
        child: AbsorbPointer(
          absorbing: widget.readOnly == true,
          child: TextFormField(
            autofocus: widget.autofocus ?? false,
            readOnly: widget.readOnly ?? false,
            focusNode: widget.focusNode,
            validator: widget.validator,
            controller: widget.controller,
            keyboardType: TextInputType.text,
            obscureText: widget.obscureText && !_passwordVisible,
            minLines: widget.minLines,
            maxLines: widget.obscureText ? 1 : widget.minLines,
            style: (widget.minLines ?? 1) > 1
                ? Typograph.body12r.copyWith(color: AppColor.greyTextColor)
                : Typograph.body14r.copyWith(color: AppColor.greyTextColor),
            decoration: InputDecoration(
              prefixIcon: widget.prefixIcon,
              filled: true,
              fillColor: AppColor.greyColor,
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColor.greyColor,
                ),
              ),
              disabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColor.greyColor,
                ),
              ),
              isDense: true,
              contentPadding: const EdgeInsets.all(16),
              hintText: widget.labelText,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: AppColor.greyColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: BorderSide.none,
              ),
              // Add suffix icon for password fields
              suffixIcon: widget.obscureText
                  ? IconButton(
                      icon: Icon(
                        _passwordVisible
                            ? Icons.visibility
                            : Icons.visibility_off,
                        color: AppColor.greyTextColor,
                      ),
                      onPressed: () {
                        setState(() {
                          _passwordVisible = !_passwordVisible;
                        });
                      },
                    )
                  : null,
            ),
          ),
        ),
      ),
    );
  }
}
