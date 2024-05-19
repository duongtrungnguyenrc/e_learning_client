import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_message.dto.dart';
import 'package:lexa/data/models/chat_room.model.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/domain/business/blocs/chat.bloc.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/events/chat_bloc.event.dart';
import 'package:lexa/domain/business/states/chat_bloc.state.dart';
import 'package:lexa/presentation/views/chat_app_bar.dart';
import 'package:lexa/presentation/views/chat_profile.dart';
import 'package:lexa/presentation/views/chat_input_segment.dart';
import 'package:lexa/presentation/views/chat_message.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  late final ChatBloc _chatBloc;
  late final ProfileBloc _authenticatedProfileBloc;
  late final Profile? _authenticatedProfile;
  late final Profile? _currentProfile;
  final TextEditingController _inputController = TextEditingController();
  final RefreshController _refreshController =
      RefreshController(initialRefresh: false);
  final ScrollController _scrollController = ScrollController();

  @override
  initState() {
    super.initState();
    _authenticatedProfileBloc = context.read<ProfileBloc>();
    _authenticatedProfile =
        _authenticatedProfileBloc.state.getAuthenticatedNode();
    _currentProfile = _authenticatedProfileBloc.state.getCurrentNode();

    _chatBloc = context.read<ChatBloc>();
    _chatBloc.add(LoadRoom(receiverId: _currentProfile?.id ?? "", page: 1));
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.jumpTo(_scrollController.position.maxScrollExtent);
    });
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _scrollDown();
  }

  @override
  void dispose() {
    super.dispose();
    _chatBloc.add(LeaveRoom());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatBloc, ChatState>(
      builder: (context, state) {
        final ChatRoom? room = state.getCurrentNode();

        return Scaffold(
          backgroundColor: ColorConstants.white,
          resizeToAvoidBottomInset: true,
          appBar: ChatAppBar(profile: _currentProfile),
          body: Column(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: SmartRefresher(
                    onRefresh: () {
                      _chatBloc.add(LoadMessages(page: (room?.page ?? 1) + 1));
                      _refreshController.refreshCompleted();
                    },
                    enablePullDown: true,
                    controller: _refreshController,
                    header: const WaterDropHeader(),
                    child: ListView.separated(
                      controller: _scrollController,
                      itemCount: (room?.messages.length ?? 0) + 1,
                      separatorBuilder: (context, index) => const SizedBox(
                        height: 10,
                      ),
                      itemBuilder: (context, index) {
                        if (index == 0) {
                          return ChatProfile(
                            profile: _currentProfile,
                          );
                        } else if (room?.messages != null &&
                            index <= room!.messages.length) {
                          return MessageItem(
                            message: room.messages[index - 1],
                          );
                        } else {
                          return const SizedBox();
                        }
                      },
                    ),
                  ),
                ),
              ),
              SafeArea(
                child: Container(
                  color: ColorConstants.white,
                  padding: const EdgeInsets.only(
                    left: 15,
                    right: 15,
                    bottom: 10,
                    top: 10,
                  ),
                  child: InputSegment(
                    inputController: _inputController,
                    onSend: _onSend,
                  ),
                ),
              ),
            ],
          ),
          // bottomNavigationBar:
        );
      },
    );
  }

  void _onSend() {
    if (_inputController.text.trim().isNotEmpty) {
      _chatBloc.add(
        SendMessage(
          message: CreateMessageDto(
            userId: _authenticatedProfile?.id ?? "",
            roomId: _chatBloc.state
                    .getNode(_chatBloc.state.currentNode ?? "")
                    ?.id ??
                "",
            message: _inputController.text,
          ),
        ),
      );
      _clearInputField();
      _scrollDown();
    }
  }

  void _clearInputField() {
    _inputController.text = "";
  }

  void _scrollDown() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.fastOutSlowIn,
      );
    });
  }
}
