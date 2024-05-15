import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/presentation/shared/widgets/circular_icon_button.dart';

class AuthTextField extends StatefulWidget {
  final String iconPath;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(String?)? onSubmitted;
  final bool? isPassword;

  const AuthTextField({
    super.key,
    this.controller,
    this.iconPath = "",
    this.hintText = "",
    this.onChanged,
    this.onSubmitted,
    this.isPassword,
  });

  @override
  State<AuthTextField> createState() => _AuthTextFieldState();
}

class _AuthTextFieldState extends State<AuthTextField> {
  late bool _isShowContent;

  @override
  void initState() {
    super.initState();
    setState(() {
      _isShowContent = widget.isPassword ?? false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10.0),
        border: Border.all(
          color: ColorConstants.primaryGrey,
        ),
      ),
      child: TextField(
        controller: widget.controller,
        onSubmitted: (value) {
          if (widget.onSubmitted != null) widget.onSubmitted!(value);
        },
        onChanged: (value) => {
          if (widget.onChanged != null) {widget.onChanged!(value)}
        },
        style: const TextStyle(
          fontSize: 13,
          fontWeight: FontWeight.w700,
        ),
        obscureText: _isShowContent,
        decoration: InputDecoration(
          prefixIcon: SvgPicture.asset(widget.iconPath),
          prefixIconConstraints: BoxConstraints(
            maxWidth: widget.iconPath.isEmpty ? 15 : 44,
            maxHeight: 24,
            minWidth: widget.iconPath.isEmpty ? 15 : 44,
          ),
          suffixIcon: widget.isPassword != null
              ? CircularIconButton(
                  iconPath: _isShowContent
                      ? "assets/icons/eye_open_icon.svg"
                      : "assets/icons/eye_close_icon.svg",
                  size: 40,
                  elevation: 0,
                  onTap: () {
                    setState(() {
                      _isShowContent = !_isShowContent;
                    });
                  },
                )
              : null,
          hintText: widget.hintText,
          hintStyle: const TextStyle(
            fontSize: 13,
            fontWeight: FontWeight.w700,
            color: Colors.grey,
          ),
          fillColor: ColorConstants.white,
          filled: true,
          contentPadding: const EdgeInsets.all(15),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10.0),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }
}
