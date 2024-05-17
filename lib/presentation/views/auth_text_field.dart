import 'package:flutter/services.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/presentation/views/circular_icon_button.dart';

class AuthTextField extends StatefulWidget {
  final String iconPath;
  final String hintText;
  final Function(String)? onChanged;
  final TextEditingController? controller;
  final Function(String?)? onSubmitted;
  final bool? isPassword;
  final String? Function(String?)? validator;
  final bool? isLoading;
  final List<TextInputFormatter> formats;
  final TextInputType? textInputType;

  const AuthTextField({
    Key? key,
    this.controller,
    this.iconPath = "",
    this.hintText = "",
    this.onChanged,
    this.onSubmitted,
    this.isPassword,
    this.validator,
    this.isLoading,
    this.formats = const [],
    this.textInputType,
  }) : super(key: key);

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
    return TextFormField(
      keyboardType: widget.textInputType,
      inputFormatters: widget.formats,
      enabled: !(widget.isLoading ?? false),
      autovalidateMode: AutovalidateMode.onUserInteraction,
      controller: widget.controller,
      onSaved: (value) {
        if (widget.onSubmitted != null) widget.onSubmitted!(value);
      },
      onChanged: (value) {
        if (widget.onChanged != null) {
          widget.onChanged!(value);
        }
      },
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
      obscureText: _isShowContent,
      decoration: InputDecoration(
        prefixIcon: widget.iconPath.isNotEmpty
            ? SvgPicture.asset(widget.iconPath)
            : null,
        prefixIconConstraints: BoxConstraints(
          maxWidth: widget.iconPath.isEmpty ? 15 : 44,
          maxHeight: 24,
          minWidth: widget.iconPath.isEmpty ? 15 : 44,
        ),
        suffixIconConstraints: const BoxConstraints(
          maxWidth: 50,
          maxHeight: 40,
        ),
        suffixIcon: widget.isLoading != null && widget.isLoading!
            ? Container(
                padding: const EdgeInsets.all(10),
                child: const SizedBox(
                  width: 15,
                  height: 15,
                  child: Center(
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.grey,
                    ),
                  ),
                ),
              )
            : (widget.isPassword != null
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
                : null),
        hintText: widget.hintText,
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
          color: Colors.grey,
        ),
        fillColor: ColorConstants.white,
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.primaryGrey,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.primaryGrey,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.primaryBlue,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10.0),
          borderSide: BorderSide(
            color: ColorConstants.red,
          ),
        ),
      ),
      validator: widget.validator,
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.controller?.dispose();
  }
}
