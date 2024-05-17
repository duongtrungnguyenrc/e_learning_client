import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/svg_icon.dart';

class CircularAvatar extends StatelessWidget {
  final String imageUrl;
  final double size;
  final double borderWidth;
  final Color borderColor;
  final Widget? errorWidget;

  const CircularAvatar({
    Key? key,
    required this.imageUrl,
    required this.size,
    this.borderWidth = 0,
    this.borderColor = Colors.grey,
    this.errorWidget,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: borderColor,
          width: borderWidth,
        ),
      ),
      child: ClipOval(
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (context, url) => skeleton(size, size),
          errorListener: (err) {},
          errorWidget: (context, url, error) =>
              errorWidget ??
              ClipOval(
                child: Container(
                  color: ColorConstants.white,
                  child: SvgIcon(
                    assetUrl: "assets/icons/person_filled_icon.svg",
                    color: ColorConstants.primaryGrey,
                  ),
                ),
              ),
        ),
      ),
    );
  }
}
