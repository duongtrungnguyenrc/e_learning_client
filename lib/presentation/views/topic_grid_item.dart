import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/screens/manage_topic_screen.dart';

class TopicGridItem extends StatefulWidget {
  final String? rootId;
  final dynamic data;
  final bool isLoading;

  final Function(dynamic, DragTargetDetails<Object?>) onDrop;

  const TopicGridItem({
    Key? key,
    required this.data,
    required this.onDrop,
    this.isLoading = false,
    this.rootId,
  }) : super(key: key);

  @override
  State<TopicGridItem> createState() => _TopicGridItemState();
}

class _TopicGridItemState extends State<TopicGridItem> {
  late Offset _tapDownPosition;

  @override
  void initState() {
    super.initState();
  }

  Widget _buildCachedImage() {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: widget.data is Topic
          ? CachedNetworkImage(
              imageUrl: (widget.data as Topic).thumbnail,
              width: 70,
              height: 60,
              fit: BoxFit.cover,
              placeholder: (context, url) => skeleton(
                60,
                70,
                borderRadius: 5,
              ),
              errorWidget: (context, url, error) => Image.asset(
                "assets/images/file.png",
                fit: BoxFit.fill,
                width: 70,
                height: 60,
              ),
            )
          : Image.asset(
              "assets/images/folder_contain.png",
              fit: BoxFit.cover,
              width: 70,
              height: 60,
            ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return DragTarget(
      onAcceptWithDetails: (target) => widget.onDrop(widget.data, target),
      builder: (context, candidateData, rejectedData) {
        return Stack(
          children: [
            InkWell(
              borderRadius: BorderRadius.circular(5),
              onTapDown: (details) {
                _tapDownPosition = details.globalPosition;
              },
              onLongPress: () async {
                final overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;

                showMenu(
                  position: RelativeRect.fromLTRB(
                    _tapDownPosition.dx,
                    _tapDownPosition.dy,
                    overlay.size.width - _tapDownPosition.dx,
                    overlay.size.height - _tapDownPosition.dy,
                  ),
                  context: context,
                  items: const <PopupMenuEntry>[
                    PopupMenuItem(
                      value: 10,
                      child: Row(
                        children: <Widget>[
                          Icon(Icons.delete),
                          Text("Delete"),
                        ],
                      ),
                    )
                  ],
                );
              },
              onTap: () {
                if (widget.data is Folder) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ManageTopicScreen(
                        rootId: widget.rootId,
                        folderId: widget.data.id,
                        folderName: widget.data.name,
                      ),
                    ),
                  );
                }
              },
              child: LongPressDraggable(
                data: widget.data,
                feedback: _buildCachedImage(),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      _buildCachedImage(),
                      const SizedBox(height: 5),
                      Text(
                        widget.data.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
            if (widget.isLoading)
              Positioned.fill(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: Colors.black.withOpacity(0.3),
                  ),
                  child: Center(
                    child: CircularProgressIndicator(
                      color: ColorConstants.white,
                    ), // Loading indicator
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}
