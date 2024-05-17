import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

enum StyledDropdownButtonStyle {
  outline,
  contained,
}

class StyledDropdownButton<T> extends StatefulWidget {
  final List<T> items;
  final Function(dynamic) onChanged;
  final String? hint;
  final StyledDropdownButtonStyle style;
  final Color fillColor;
  final String? coverText;
  final bool showIcon;
  final T? defaultValue;

  const StyledDropdownButton({
    super.key,
    required this.items,
    required this.onChanged,
    this.hint,
    this.style = StyledDropdownButtonStyle.contained,
    this.fillColor = Colors.black,
    this.coverText,
    this.showIcon = false,
    this.defaultValue,
  });

  @override
  State<StyledDropdownButton> createState() => _StyledDropdownButtonState();
}

class _StyledDropdownButtonState<T> extends State<StyledDropdownButton<T>> {
  T? _value;

  @override
  void initState() {
    super.initState();
    _value = widget.defaultValue;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: widget.style == StyledDropdownButtonStyle.contained ? widget.fillColor : Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      height: 35,
      child: Align(
        child: DropdownButtonFormField<T>(
          isExpanded: true,
          alignment: Alignment.center,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(
                width: 1,
                color: widget.fillColor,
              ),
              borderRadius: BorderRadius.circular(15),
            ),
            contentPadding: const EdgeInsets.symmetric(
              vertical: 0,
              horizontal: 10,
            ),
            hintText: widget.hint,
          ),
          borderRadius: BorderRadius.circular(15),
          dropdownColor:
              widget.style == StyledDropdownButtonStyle.contained ? ColorConstants.black : ColorConstants.white,
          style: TextStyle(
            color: widget.style == StyledDropdownButtonStyle.contained ? ColorConstants.white : ColorConstants.black,
            fontWeight: FontWeight.bold,
            overflow: TextOverflow.ellipsis,
          ),
          value: _value,
          icon: widget.showIcon
              ? const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Icon(Icons.expand_more),
                )
              : const SizedBox.shrink(),
          elevation: 1,
          items: widget.items
              .map(
                (item) => DropdownMenuItem<T>(
                  value: item,
                  child: Align(
                    alignment: Alignment.center,
                    child: Text(
                      "${item.toString()} ${widget.coverText ?? ""}",
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              )
              .toList(),
          onChanged: (T? value) {
            widget.onChanged(value);
            setState(() {
              _value = value;
            });
          },
        ),
      ),
    );
  }
}
