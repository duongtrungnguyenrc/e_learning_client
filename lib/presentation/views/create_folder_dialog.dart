import 'package:lexa/core/commons/constant.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/form_text_field.dart';

class CreateFolderDialog extends StatefulWidget {
  final Function(String) onCreate;

  const CreateFolderDialog({
    super.key,
    required this.onCreate,
  });

  @override
  State<CreateFolderDialog> createState() => _CreateFolderDialogState();
}

class _CreateFolderDialogState extends State<CreateFolderDialog> {
  final TextEditingController _textEditingController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: ColorConstants.white,
      backgroundColor: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      child: IntrinsicHeight(
        child: Column(children: [
          const SizedBox(
            height: 20,
          ),
          const Text(
            "Create new folder",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: FormTextField(
              controller: _textEditingController,
              hintText: "Folder name",
              onChanged: (value) {},
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          const Divider(
            height: 1,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(13)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text(
                    "Cancel",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 1,
                height: 50,
                child: VerticalDivider(
                  width: 1,
                ),
              ),
              Expanded(
                child: TextButton(
                  onPressed: () {
                    widget.onCreate(_textEditingController.text);
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    padding: const MaterialStatePropertyAll(EdgeInsets.all(13)),
                    shape: MaterialStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                  ),
                  child: Text(
                    "Create",
                    style: TextStyle(
                      color: ColorConstants.primary,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ]),
      ),
    );
  }

  @override
  void dispose() {
    _textEditingController.dispose();
    super.dispose();
  }
}
