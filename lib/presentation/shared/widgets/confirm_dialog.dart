// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';

class ConfirmDialog extends StatelessWidget {
  final Function action;
  final String title;
  final String message;

  const ConfirmDialog({
    Key? key,
    required this.action,
    required this.title,
    required this.message,
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
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Text(message),
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
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
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
                      padding: const MaterialStatePropertyAll(EdgeInsets.all(10)),
                      shape: MaterialStateProperty.all(
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
