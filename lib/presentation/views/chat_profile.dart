import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';

class ChatProfile extends StatelessWidget {
  final Profile? profile;
  const ChatProfile({super.key, this.profile});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        top: 10,
        bottom: 30,
      ),
      child: Column(
        children: [
          CircularAvatar(
            imageUrl: profile?.avatar ?? "",
            size: MediaQuery.of(context).size.width / 4,
            errorWidget: Image.network(dotenv.env['RANDOM_AVATAR_URL'] ?? ""),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            profile?.name ?? "",
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w900,
            ),
          ),
          Text(
            profile?.email ?? "",
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }
}
