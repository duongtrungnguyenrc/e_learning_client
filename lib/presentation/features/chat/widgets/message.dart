import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/message.model.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/presentation/shared/widgets/circular_avatar.dart';

class MessageItem extends StatelessWidget {
  final Message? message;

  const MessageItem({
    super.key,
    this.message,
  });

  @override
  Widget build(BuildContext context) {
    final currentProfile =
        context.read<ProfileBloc>().state.getAuthenticatedNode();
    final isMe = currentProfile?.id == message?.sender.id;

    return Align(
      alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
      child: Wrap(
        direction: Axis.horizontal,
        spacing: 10,
        children: [
          !isMe ? _buildAvatar() : const SizedBox.shrink(),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width * 0.7,
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isMe ? ColorConstants.primary : Colors.grey[200],
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(isMe ? 0 : 10),
                  topLeft: Radius.circular(isMe ? 10 : 0),
                  bottomLeft: const Radius.circular(10),
                  bottomRight: const Radius.circular(10),
                ),
              ),
              child: Text(
                message?.message ?? "",
                style: TextStyle(
                  fontSize: 13,
                  color: isMe ? ColorConstants.white : ColorConstants.black,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
          isMe ? _buildAvatar() : const SizedBox.shrink(),
        ],
      ),
    );
  }

  Widget _buildAvatar() {
    return CircularAvatar(
      imageUrl: message?.sender.avatar ?? "",
      borderColor: ColorConstants.primaryGrey,
      size: 25,
      errorWidget: Image.network(dotenv.env['RANDOM_AVATAR_URL'] ?? ""),
    );
  }
}
