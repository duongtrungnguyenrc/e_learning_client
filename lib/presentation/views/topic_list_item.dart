import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/topic.model.dart';

import '../screens/manage_topic_screen.dart';

class TopicListItem extends StatelessWidget {
  final dynamic data;
  final int index;

  final Function(dynamic, DragTargetDetails<Object?>) onDrop;

  const TopicListItem({
    Key? key,
    required this.data,
    required this.index,
    required this.onDrop,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAcceptWithDetails: (target) => onDrop(data, target),
      builder: (context, candidateData, rejectedData) {
        return LongPressDraggable(
          data: data,
          feedback: _buildFeedbackWidget(),
          child: _buildListItem(context),
        );
      },
    );
  }

  Widget _buildFeedbackWidget() {
    return data is Folder
        ? Image.asset(
            "assets/images/folder_contain.png",
            fit: BoxFit.cover,
            width: 70,
            height: 60,
          )
        : Image.asset(
            "assets/images/file.png",
            fit: BoxFit.cover,
            width: 70,
            height: 60,
          );
  }

  Widget _buildListItem(BuildContext context) {
    return InkWell(
      onTap: () => _navigateToManageTopicPage(context),
      child: Container(
        color: index % 2 == 0
            ? Colors.transparent
            : const Color.fromARGB(255, 246, 246, 246),
        child: ListTile(
          leading: _buildLeadingWidget(),
          title: Text(
            data.name,
            style: const TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 14,
            ),
          ),
          subtitle: Text(
            data is Topic ? data.description : "Topics folder",
            style: const TextStyle(
              fontSize: 12,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLeadingWidget() {
    return data is Topic
        ? ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: CachedNetworkImage(
              imageUrl: data.thumbnail,
              width: 50,
              height: 50,
              fit: BoxFit.cover,
              placeholder: (context, url) => Container(
                width: 50,
                height: 50,
                color: Colors.grey,
              ),
              errorListener: (error) {},
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/file.png",
                fit: BoxFit.fill,
                width: 70,
                height: 60,
              ),
            ),
          )
        : Image.asset(
            "assets/images/folder_contain.png",
            fit: BoxFit.cover,
            width: 50,
            height: 50,
          );
  }

  void _navigateToManageTopicPage(BuildContext context) {
    if (data is Folder) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ManageTopicScreen(
            folderId: data.id,
            folderName: data.name,
          ),
        ),
      );
    }
  }
}
