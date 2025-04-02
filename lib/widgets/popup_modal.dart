import 'package:flutter/material.dart';

class PopupModal extends StatelessWidget {
  final Widget content;
  final List<Widget> actions;
  final String? title;
  final int? id;
  const PopupModal({
    super.key,
    required this.content,
    this.id,
    required this.actions,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      contentPadding: const EdgeInsets.symmetric(
        horizontal: 120.0,
        vertical: 20.0,
      ),
      titlePadding: const EdgeInsets.symmetric(
        horizontal: 120.0,
        vertical: 20.0,
      ),
      title: Text(title ?? "Test"),
      actions: actions,
      content: content,
    );
  }

  static Future<void> showModal(
    BuildContext context, {
    required Widget content,
    required List<Widget> actions,
    String? title,
    int? id,
  }) {
    return showDialog(
      context: context,
      builder:
          (context) =>
              PopupModal(content: content, actions: actions, title: title),
    );
  }
}
