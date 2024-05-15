import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/domain/business/blocs/create_topic.bloc.dart';
import 'package:lexa/domain/business/events/create_topic_bloc.event.dart';
import 'package:lexa/domain/business/states/create_topic.state.dart';
import 'package:lexa/presentation/features/topic/widgets/adding_vocabulary_list.dart';
import 'package:lexa/presentation/features/topic/widgets/create_answer_dialog.dart';
import 'package:lexa/presentation/features/topic/widgets/create_answers_segment.dart';
import 'package:lexa/presentation/features/topic/widgets/styled_dropdown_button.dart';
import 'package:lexa/presentation/features/topic/widgets/thumbnail_picker_segment.dart';
import 'package:lexa/presentation/shared/widgets/back_app_bar.dart';
import 'package:flutter/material.dart';
import 'package:lexa/presentation/shared/widgets/confirm_dialog.dart';
import 'package:lexa/utils/debounce.utils.dart';
import 'package:toastification/toastification.dart';

class CreateVocabularyPage extends StatefulWidget {
  final List<CreateVocabularyDto> vocabularies;

  const CreateVocabularyPage({
    super.key,
    required this.vocabularies,
  });

  @override
  State<CreateVocabularyPage> createState() => _CreateVocabularyPageState();
}

class _CreateVocabularyPageState extends State<CreateVocabularyPage> {
  int activeTab = 0;
  final PageController _pageController = PageController();
  late final Function _debouncedVocabulary;
  late final CreateTopicBloc _createTopicBloc;

  @override
  void initState() {
    super.initState();
    _createTopicBloc = context.read<CreateTopicBloc>();
    _createTopicBloc.add(
      UpdateNewTopic(
        topic: _createTopicBloc.state.topic.copyWith(
          data: _createTopicBloc.state.topic.data.copyWith(
            vocabularies: [CreateVocabularyDto()],
          ),
        ),
      ),
    );
    _debouncedVocabulary = DebounceUtils.debounce((text) {
      final updatingVocabularies = _createTopicBloc.state.topic.data.vocabularies;
      updatingVocabularies[activeTab].word = text;

      _createTopicBloc.add(
        UpdateNewTopic(
          topic: _createTopicBloc.state.topic.copyWith(
            data: _createTopicBloc.state.topic.data.copyWith(vocabularies: updatingVocabularies),
          ),
        ),
      );
    }, 300);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CreateTopicBloc, CreateTopicState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: BackAppBar(
            title: "Create vocabulary",
            actions: [
              TextButton(
                onPressed: _saveButtonPressed,
                child: const Text(
                  "Save",
                  style: TextStyle(
                    color: Colors.black,
                  ),
                ),
              ),
            ],
          ),
          body: PageView(
            controller: _pageController,
            onPageChanged: _changeTab,
            children: state.topic.data.vocabularies.map((vocabulary) => _buildBody(vocabulary, state)).toList(),
          ),
          bottomNavigationBar: SafeArea(
            child: AddingVocabularyControlSegment(
              activeIndex: activeTab,
              vocabularies: state.topic.data.vocabularies,
              onItemTap: _changeTab,
              onItemRemove: _onRemoveVocabulary,
              onAddItem: () => _onAddVocabulary(state),
            ),
          ),
        );
      },
    );
  }

  Widget _buildBody(CreateVocabularyDto vocabulary, CreateTopicState state) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: ThumbnailPickerSegment(
              image: vocabulary.thumbnail,
              onPicked: (image) {
                final updatedVocabularies = state.topic.data.vocabularies;
                updatedVocabularies[activeTab].thumbnail = image;
                _updateTopic(state.topic.copyWith(data: state.topic.data.copyWith(vocabularies: updatedVocabularies)));
              },
            ),
          ),
          _buildGeneralInfoSegment(state),
          TextField(
            textAlign: TextAlign.center,
            maxLines: 2,
            style: const TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w900,
            ),
            decoration: InputDecoration(
              hintText: state.topic.data.vocabularies[activeTab].word ?? "Enter your vocabulary here...",
              border: InputBorder.none,
            ),
            onChanged: (text) {
              _debouncedVocabulary(text);
            },
          ),
          CreateAnswerSegment(
            answers: state.topic.data.vocabularies[activeTab].multipleChoiceAnswers,
            onTap: (index) => _showCreateAnswerDialog(context, state, index),
          ),
        ],
      ),
    );
  }

  Widget _buildGeneralInfoSegment(CreateTopicState state) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Row(
        children: [
          Expanded(
            child: StyledDropdownButton<int>(
              items: const [2, 3, 4],
              defaultValue: 4,
              hint: "Answers count",
              coverText: "answers",
              onChanged: (count) => _updateAnswerCount(state, count),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StyledDropdownButton<QuestionLayout>(
              items: QuestionLayout.values,
              hint: "Layout",
              defaultValue: QuestionLayout.grid,
              coverText: "Layout",
              onChanged: (value) {},
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: StyledDropdownButton<int>(
              items: const [5, 10, 15, 20, 30],
              defaultValue: 5,
              hint: "Duration",
              coverText: "Seccons",
              onChanged: (value) {
                debugPrint(value.toString());
              },
            ),
          ),
        ],
      ),
    );
  }

  void _changeTab(int tab) {
    setState(() {
      activeTab = tab;
    });
    _tabNavigation(tab);
  }

  void _tabNavigation(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 200),
      curve: Curves.linear,
    );
  }

  void _onAddVocabulary(CreateTopicState state) {
    final validationResult = state.topic.data.vocabularies[activeTab].validate();

    if (validationResult == null) {
      state.topic.data.vocabularies.add(CreateVocabularyDto());
      _changeTab(state.topic.data.vocabularies.length - 1);
    } else {
      toastification.show(
        context: context,
        type: ToastificationType.error,
        style: ToastificationStyle.fillColored,
        title: Text(validationResult.message),
        alignment: Alignment.bottomCenter,
        animationDuration: const Duration(milliseconds: 300),
        autoCloseDuration: const Duration(milliseconds: 3000),
      );
    }
  }

  void _onRemoveVocabulary(int index) {
    showDialog(
      context: context,
      builder: (context) => ConfirmDialog(
        action: () {
          if (index == activeTab) {
            _changeTab(activeTab - 1);
          }
          final updatingVocabularies = _createTopicBloc.state.topic.data.vocabularies;
          updatingVocabularies.removeAt(index);

          _updateTopic(_createTopicBloc.state.topic
              .copyWith(data: _createTopicBloc.state.topic.data.copyWith(vocabularies: updatingVocabularies)));
        },
        title: "Remove confirm",
        message:
            "Do you want to remove ${_createTopicBloc.state.topic.data.vocabularies[index].word ?? "this question"}?",
      ),
    );
  }

  void _saveButtonPressed() {
    bool isValid = true;
    final state = _createTopicBloc.state;

    for (var i = 0; i < state.topic.data.vocabularies.length; i++) {
      final validationResult = state.topic.data.vocabularies[i].validate();

      if (validationResult != null) {
        toastification.show(
          context: context,
          type: ToastificationType.error,
          style: ToastificationStyle.fillColored,
          title: Text("In vocabulary ${i + 1}: ${validationResult.message}"),
          alignment: Alignment.bottomCenter,
          animationDuration: const Duration(milliseconds: 300),
          autoCloseDuration: const Duration(milliseconds: 3000),
        );
        _tabNavigation(i);
        isValid = false;
        break;
      }
    }

    if (isValid) {
      Navigator.pop(context);
    }
  }

  void _updateAnswerCount(CreateTopicState state, int count) {
    final updatingVocabularies = _createTopicBloc.state.topic.data.vocabularies;
    updatingVocabularies[activeTab].answerCount = count;

    if (count < updatingVocabularies[activeTab].multipleChoiceAnswers.length) {
      updatingVocabularies[activeTab].multipleChoiceAnswers =
          updatingVocabularies[activeTab].multipleChoiceAnswers.sublist(0, count);
    } else {
      updatingVocabularies[activeTab].multipleChoiceAnswers.add(CreateMultipleChoiceAnswerDto());
    }

    _updateTopic(state.topic.copyWith(data: state.topic.data.copyWith(vocabularies: updatingVocabularies)));
  }

  void _updateTopic(CreateTopicDTO topic) {
    _createTopicBloc.add(UpdateNewTopic(topic: topic));
  }

  void _showCreateAnswerDialog(BuildContext context, CreateTopicState state, int index) {
    showDialog(
      context: context,
      builder: (context) => CreateAnswerDialog(
        color: multipleChoiceAnswerColors[index]!,
        answer: state.topic.data.vocabularies[activeTab].multipleChoiceAnswers[index],
        onChanged: (answer) {
          final updatingVocabularies = state.topic.data.vocabularies;
          updatingVocabularies[activeTab].meaning = answer.content;
          updatingVocabularies[activeTab].multipleChoiceAnswers[index] = answer;

          _updateTopic(state.topic.copyWith(data: state.topic.data.copyWith(vocabularies: updatingVocabularies)));
        },
      ),
    );
  }
}
