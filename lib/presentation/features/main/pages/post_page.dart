import 'package:flutter/material.dart';
import 'package:lexa/presentation/shared/widgets/back_app_bar.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: BackAppBar(title: "Post"),
      body: Hero(
        tag: 'post',
        child: Placeholder(),
      ),
    );
  }
}
