import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/core/commons/constant.dart';

class FormTextField extends StatefulWidget {
  final String iconPath;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(String?)? onSubmit;
  final int? maxLines;
  final String? initialValue;
  final bool enabled;
  final bool secure;
  final double? contentPadding;
  final double? borderRadius;

  const FormTextField({
    Key? key,
    this.controller,
    this.iconPath = "",
    this.hintText = "",
    this.onChanged,
    this.onSubmit,
    this.maxLines,
    this.initialValue,
    this.enabled = true,
    this.secure = false,
    this.contentPadding,
    this.borderRadius,
  }) : super(key: key);

  @override
  State<FormTextField> createState() => _FormTextFieldState();
}

class _FormTextFieldState extends State<FormTextField> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
      ),
      child: TextFormField(
        obscureText: widget.secure & widget.enabled,
        enabled: widget.enabled,
        initialValue: widget.initialValue,
        maxLines: widget.maxLines,
        controller: widget.controller,
        onChanged: (value) {
          if (widget.onChanged != null) widget.onChanged!(value);
        },
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
        decoration: InputDecoration(
          prefixIcon: widget.iconPath.isNotEmpty ? SvgPicture.asset(widget.iconPath) : null,
          prefixIconConstraints: BoxConstraints(
            maxWidth: widget.iconPath.isEmpty ? 15 : 44,
            maxHeight: 24,
            minWidth: widget.iconPath.isEmpty ? 15 : 44,
          ),
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
          fillColor: Colors.transparent,
          filled: true,
          contentPadding: EdgeInsets.all(widget.contentPadding ?? 20),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            borderSide: const BorderSide(
              color: Colors.white,
              width: 1.0,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(widget.borderRadius ?? 10.0),
            borderSide: BorderSide(
              color: ColorConstants.primary,
              width: 1.0,
            ),
          ),
        ),
        onSaved: (value) {
          if (widget.onSubmit != null) {
            widget.onSubmit!(value);
          }
        },
      ),
    );
  }
}
