import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:lexa/domain/utils/debounce.utils.dart';

class SearchTextField extends StatefulWidget {
  final Function(String keyword) onChanged;
  final Function(bool)? onFocusChange;
  final Border? border;

  const SearchTextField({
    super.key,
    this.onFocusChange,
    this.border,
    required this.onChanged,
  });

  @override
  State<StatefulWidget> createState() => _SearchTextFieldState();
}

class _SearchTextFieldState extends State<SearchTextField> {
  final TextEditingController _textEditingController = TextEditingController();
  final FocusNode _focusNode = FocusNode();
  late Function _onTextChange;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_onFocusChange);
    _onTextChange = DebounceUtils.debounce((keyword) {
      widget.onChanged(keyword ?? "");
    }, 500);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_onFocusChange);
    _focusNode.dispose();
    _textEditingController.dispose();
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });

    if (widget.onFocusChange != null) {
      widget.onFocusChange!(_focusNode.hasFocus);
    };
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _textEditingController,
      onChanged: (text) => _onTextChange(text),
      style: const TextStyle(
        fontSize: 14,
      ),
      focusNode: _focusNode,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: ColorConstants.primaryGrey, width: 1.0),
          borderRadius: BorderRadius.circular(10),
        ),
        prefixIcon: SvgPicture.asset(
          "assets/icons/search_icon.svg",
          color: ColorConstants.primaryGray,
        ),
        prefixIconConstraints: const BoxConstraints(
          minWidth: 50,
          maxWidth: 50,
          maxHeight: 22,
        ),
        suffixIcon: AnimatedSwitcher(
          duration: const Duration(milliseconds: 100),
          child: _isFocused
              ? RotationTransition(
                  turns: const AlwaysStoppedAnimation(0.25),
                  child: IconButton(
                    padding: const EdgeInsets.all(0),
                    color: ColorConstants.black,
                    onPressed: () {
                      _focusNode.unfocus();
                      _textEditingController.text = "";
                      _onTextChange("");
                    },
                    icon: SvgPicture.asset(
                      "assets/icons/x_icon.svg",
                      color: ColorConstants.primaryGray,
                      width: 28,
                      height: 28,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),
        hintText: "Topic, Profile,...",
        hintStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
        fillColor: _isFocused ? ColorConstants.white : Colors.grey[200],
        filled: true,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }
}
