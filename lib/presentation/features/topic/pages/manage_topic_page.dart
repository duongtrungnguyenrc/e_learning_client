import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_folder.dto.dart';
import 'package:lexa/data/dtos/update_folder.dto.dart';
import 'package:lexa/data/dtos/update_topic.dto.dart';
import 'package:lexa/data/models/folder.model.dart';
import 'package:lexa/domain/business/blocs/create_topic.bloc.dart';
import 'package:lexa/domain/business/blocs/manage_topic.bloc.dart';
import 'package:lexa/domain/business/events/manage_topic.event.dart';
import 'package:lexa/domain/business/states/create_topic.state.dart';
import 'package:lexa/domain/business/states/manage_topic.state.dart';
import 'package:lexa/presentation/features/topic/pages/create_topic_page.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/features/topic/widgets/create_folder_dialog.dart';
import 'package:lexa/presentation/features/topic/widgets/topic_grid_item.dart';
import 'package:lexa/presentation/features/topic/widgets/topic_list_item.dart';
import 'package:lexa/presentation/shared/widgets/back_app_bar.dart';
import 'package:lexa/presentation/shared/widgets/confirm_dialog.dart';
import 'package:lexa/presentation/shared/widgets/list_order_mode_toggle_button.dart';
import 'package:lexa/presentation/shared/widgets/svg_icon.dart';

class ManageTopicPage extends StatelessWidget {
  final String? rootId;
  final String? folderId;
  final String? folderName;

  const ManageTopicPage({
    Key? key,
    this.rootId,
    this.folderId,
    this.folderName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _ManageTopicPageContent(
      rootId: rootId,
      folderId: folderId,
      folderName: folderName,
    );
  }
}

class _ManageTopicPageContent extends StatefulWidget {
  final String? rootId;
  final String? folderId;
  final String? folderName;

  const _ManageTopicPageContent({
    Key? key,
    this.folderId,
    this.folderName,
    this.rootId,
  }) : super(key: key);

  @override
  State<_ManageTopicPageContent> createState() => _ManageTopicPageContentState();
}

class _ManageTopicPageContentState extends State<_ManageTopicPageContent> {
  bool isListMode = false;
  late CreateTopicBloc _createTopicBloc;

  @override
  void initState() {
    _loadInitialData();
    super.initState();

    _createTopicBloc = context.read<CreateTopicBloc>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ManageTopicBloc, ManageTopicState>(
      listener: (context, state) {},
      builder: _buildScaffold,
    );
  }

  void _loadInitialData() {
    context.read<ManageTopicBloc>().add(LoadTopics(id: widget.folderId));
  }

  Widget _buildScaffold(BuildContext context, ManageTopicState state) {
    TopicTreeNode? node = state.find(widget.folderId) ?? const TopicTreeNode();

    return Scaffold(
      backgroundColor: ColorConstants.white,
      appBar: BackAppBar(
        title: widget.folderName ?? "Manage topics",
        onDrop: (dragItem) {
          _handleDrop(widget.rootId, dragItem);
        },
        actions: [
          ListOrderModeToggleButton(
            isList: !isListMode,
            onTap: () {
              setState(() {
                isListMode = !isListMode;
              });
            },
          ),
        ],
      ),
      body: BlocBuilder<CreateTopicBloc, CreateTopicState>(builder: (context, state) {
        return Column(
          children: [
            Expanded(
              child: isListMode
                  ? ListView.builder(
                      key: UniqueKey(),
                      itemCount: node.children.length,
                      itemBuilder: (context, index) => _buildListItem(context, node.children[index], index),
                    )
                  : Padding(
                      key: UniqueKey(),
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: GridView.builder(
                        itemCount: state.loading ? node.children.length + 1 : node.children.length,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: (MediaQuery.of(context).size.width / 110).round(),
                          crossAxisSpacing: 10,
                          mainAxisSpacing: 10,
                        ),
                        itemBuilder: (context, index) {
                          if (index < node.children.length) {
                            return _buildGridItem(context, node.children[index], index);
                          }
                          return Column(
                            children: [
                              Stack(
                                children: [
                                  skeleton(70, 60, borderRadius: 5),
                                  const Positioned.fill(
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: CupertinoActivityIndicator(),
                                    ),
                                  )
                                ],
                              ),
                              const SizedBox(height: 5),
                              skeleton(60, 10, borderRadius: 5),
                            ],
                          );
                        },
                      ),
                    ),
            ),
          ],
        );
      }),
      floatingActionButton: _buildFloatingActionButton(),
    );
  }

  Widget _buildListItem(BuildContext context, dynamic data, int index) {
    return TopicListItem(
      data: data,
      index: index,
      onDrop: _handleDrop,
    );
  }

  Widget _buildGridItem(BuildContext context, dynamic data, int index) {
    return TopicGridItem(
      rootId: widget.folderId,
      data: data,
      onDrop: _handleDrop,
    );
  }

  Widget _buildFloatingActionButton() {
    return Container(
      decoration: BoxDecoration(
        color: ColorConstants.primary,
        borderRadius: BorderRadius.circular(15),
      ),
      child: PopupMenuButton(
        surfaceTintColor: ColorConstants.white,
        color: ColorConstants.white,
        itemBuilder: _buildPopupMenuItems,
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SvgIcon(
            assetUrl: "assets/icons/plus_icon.svg",
            color: ColorConstants.white,
            size: 20,
          ),
        ),
      ),
    );
  }

  List<PopupMenuEntry<void>> _buildPopupMenuItems(BuildContext context) {
    return [
      PopupMenuItem(
        onTap: () => showDialog(
          context: context,
          builder: (context) => CreateFolderDialog(
            onCreate: _handleCreateFolder,
          ),
        ),
        child: const Text("Create folder"),
      ),
      PopupMenuItem(
        onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CreateTopicPage(
              rootId: widget.folderId,
            ),
          ),
        ),
        child: const Text("Create topic"),
      ),
    ];
  }

  void _handleCreateFolder(String name) {
    context.read<ManageTopicBloc>().add(
          CreateTopicFolder(
            data: CreateFolderDto(
              name: name,
              root: widget.folderId,
            ),
          ),
        );
  }

  void _handleDrop(dynamic dropData, DragTargetDetails<Object?> target) {
    final data = target.data;
    if (dropData is Folder && (data is Folder ? data.id != dropData.id : true)) {
      showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          action: () {
            _handleMoveResource(data, dropData);
          },
          title: "Move folder",
          message: "Do you want to move?",
        ),
      );
    } else if ((dropData is String || dropData == null) && widget.folderId != null) {
      showDialog(
        context: context,
        builder: (context) => ConfirmDialog(
          action: () {
            _handleMoveResource(data, dropData);
          },
          title: "Move folder",
          message: "Do you want to move?",
        ),
      );
    }
  }

  void _handleMoveResource(dynamic from, dynamic target) {
    if (from is Folder) {
      context.read<ManageTopicBloc>().add(
            UpdateFolder(
              data: UpdateFolderDto(
                folder: from.id,
                target: target is Folder ? target.id : target,
              ),
              root: widget.folderId,
            ),
          );
    } else if (from is Topic) {
      context.read<ManageTopicBloc>().add(
            UpdateTopic(
              data: UpdateTopicDto(
                id: from.id,
                folderId: target is Folder ? target.id : target,
              ),
              root: widget.folderId,
            ),
          );
    }
  }
}
