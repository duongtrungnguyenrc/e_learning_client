// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

class ConfirmDialog extends StatelessWidget {
  final Function action;
  final String title;
  final String message;
  final VoidCallback? onCancel;

  const ConfirmDialog({
    Key? key,
    required this.action,
    required this.title,
    required this.message,
    this.onCancel,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      surfaceTintColor: ColorConstants.white,
      backgroundColor: ColorConstants.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: IntrinsicWidth(
        child: IntrinsicHeight(
          child: Column(children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              title.toUpperCase(),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(
                message,
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: ColorConstants.primaryGray,
                ),
              ),
            ),
            const SizedBox(
              height: 15,
            ),
            Divider(
              height: 1,
              color: Colors.grey[200]!,
            ),
            Row(
              children: [
                Expanded(
                  child: TextButton(
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    onPressed: () {
                      Navigator.pop(context);
                      if (onCancel != null) onCancel!();
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
                SizedBox(
                  width: 1,
                  height: 50,
                  child: VerticalDivider(
                    width: 1,
                    color: Colors.grey[200]!,
                  ),
                ),
                Expanded(
                  child: TextButton(
                    onPressed: () {
                      action();
                      Navigator.pop(context);
                    },
                    style: ButtonStyle(
                      padding: const WidgetStatePropertyAll(EdgeInsets.all(10)),
                      shape: WidgetStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(0),
                        ),
                      ),
                    ),
                    child: Text(
                      "Yes",
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
      ),
    );
  }
}
