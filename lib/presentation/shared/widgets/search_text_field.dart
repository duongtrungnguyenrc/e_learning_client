import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SearchTextField extends StatelessWidget {
  final VoidCallback? onFocusChange;

  const SearchTextField({
    super.key,
    this.onFocusChange,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      style: const TextStyle(
        fontSize: 14,
      ),
      decoration: InputDecoration(
        prefixIcon: SvgPicture.asset(
          "assets/icons/search_icon.svg",
          color: ColorConstants.primaryGray,
        ),
        prefixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 24,
        ),
        hintText: "Topic, Profile,...",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        fillColor: ColorConstants.white,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
