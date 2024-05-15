import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/core/commons/constant.dart';

class TaggableFormTextField extends StatefulWidget {
  final String iconPath;
  final String hintText;
  final Function(List<String>) onChanged;
  final TextEditingController? controller;
  final Function(String?)? onSubmit;

  const TaggableFormTextField({
    Key? key,
    this.controller,
    this.iconPath = "",
    this.hintText = "",
    required this.onChanged,
    this.onSubmit,
  }) : super(key: key);

  @override
  State<TaggableFormTextField> createState() => _TaggableFormTextFieldState();
}

class _TaggableFormTextFieldState extends State<TaggableFormTextField> {
  bool _isValid = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: TextFormField(
        validator: (value) {
          return _isValid ? null : "Tag need # character";
        },
        maxLines: null,
        controller: widget.controller,
        onChanged: (text) {
          final regex = RegExp(r'^#[a-zA-Z]+(\s+#[a-zA-Z]+)*$');

          if (text != "" && regex.hasMatch(text)) {
            widget.onChanged(text.split(" "));
            setState(() {
              _isValid = true;
            });
          } else {
            setState(() {
              _isValid = false;
            });
          }
        },
        style: TextStyle(
          fontWeight: FontWeight.w600,
          color: _isValid ? ColorConstants.primaryBlue : Colors.black,
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
          contentPadding: const EdgeInsets.all(20),
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
        onSaved: (value) {
          if (widget.onSubmit != null) {
            widget.onSubmit!(value);
          }
        },
      ),
    );
  }
}
