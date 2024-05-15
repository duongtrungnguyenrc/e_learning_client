import 'dart:io';

import 'package:lexa/presentation/shared/widgets/svg_icon.dart';
import 'package:flutter/material.dart';
import 'package:gradient_borders/box_borders/gradient_box_border.dart';
import 'package:image_picker/image_picker.dart';

class ThumbnailPickerSegment extends StatefulWidget {
  final File? image;
  final Function(File?) onPicked;

  const ThumbnailPickerSegment({
    super.key,
    required this.onPicked,
    this.image,
  });

  @override
  State<ThumbnailPickerSegment> createState() => _ThumbnailPickerSegmentState();
}

class _ThumbnailPickerSegmentState extends State<ThumbnailPickerSegment> {
  File? _image;
  final _picker = ImagePicker();

  @override
  initState() {
    super.initState();
    _image = widget.image;
  }

  Future<void> _getImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);

    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        widget.onPicked(_image);
      } else {
        debugPrint('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: _getImageFromGallery,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        decoration: BoxDecoration(
          border: _image == null
              ? const GradientBoxBorder(
                  gradient: LinearGradient(
                    colors: [
                      Color.fromARGB(255, 92, 179, 94),
                      Color.fromARGB(255, 211, 211, 33),
                    ],
                  ),
                  width: 5,
                )
              : Border.all(
                  width: 1,
                  color: Colors.grey[300]!,
                ),
          borderRadius: BorderRadius.circular(20),
        ),
        height: 200,
        child: _image == null
            ? const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgIcon(
                      assetUrl: "assets/icons/image_icon.svg",
                      size: 60,
                      color: Color.fromARGB(255, 130, 181, 89),
                    ),
                    Text(
                      "Add cover image",
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.w900,
                        fontSize: 18,
                      ),
                    )
                  ],
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Image.file(
                  _image!,
                  fit: BoxFit.cover,
                  width: MediaQuery.of(context).size.width,
                ),
              ),
      ),
    );
  }
}
