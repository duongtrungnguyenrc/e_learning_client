import 'package:flutter/material.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';

class ChatHomeScreen extends StatelessWidget {
  const ChatHomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const BackAppBar(title: "Chat"),
      body: ListView.builder(
        itemBuilder: (context, index) => _buildItem(),
      ),
    );
  }

  Widget _buildItem() {
    return const Placeholder();
  }
}
