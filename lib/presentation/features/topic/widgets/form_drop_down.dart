// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/nameable.model.dart';

class FormDropdown<T extends Nameable> extends StatefulWidget {
  final List<T> items;
  final String iconPath;
  final String hintText;
  final T? value;
  final ValueChanged<T?> onChanged;

  const FormDropdown({
    Key? key,
    required this.items,
    this.iconPath = "",
    this.hintText = "",
    this.value,
    required this.onChanged,
  }) : super(key: key);

  @override
  State<FormDropdown<T>> createState() => _FormDropdownState<T>();
}

class _FormDropdownState<T extends Nameable> extends State<FormDropdown<T>> {
  T? _value;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButtonFormField<T>(
        value: _value,
        onChanged: (value) {
          widget.onChanged(value);
          setState(() {
            _value = value;
          });
        },
        decoration: InputDecoration(
          labelText: widget.hintText,
          labelStyle: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
          floatingLabelStyle: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: ColorConstants.primary,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide(
              color: ColorConstants.primary,
              width: 1.0,
            ),
          ),
        ),
        items: widget.items.map((item) {
          return DropdownMenuItem<T>(
            value: item,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: Row(
                children: [
                  if (widget.iconPath.isNotEmpty) ...[
                    SvgPicture.asset(
                      widget.iconPath,
                      width: 24,
                      height: 24,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(item.name),
                ],
              ),
            ),
          );
        }).toList(),
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        dropdownColor: ColorConstants.white,
      ),
    );
  }
}
