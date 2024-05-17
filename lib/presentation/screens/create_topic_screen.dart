import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/dtos/create_topic.dto.dart';
import 'package:lexa/data/models/group.model.dart';
import 'package:lexa/domain/business/blocs/create_topic.bloc.dart';
import 'package:lexa/domain/business/events/create_topic_bloc.event.dart';
import 'package:lexa/domain/business/states/create_topic.state.dart';
import 'package:lexa/presentation/screens/create_vocabulary_screen.dart';
import 'package:lexa/presentation/views/form_drop_down.dart';
import 'package:lexa/presentation/views/form_text_field.dart';
import 'package:lexa/presentation/views/taggable_form_text_field.dart';
import 'package:lexa/presentation/views/thumbnail_picker_segment.dart';
import 'package:lexa/core/commons/constant.dart';
import 'package:lexa/presentation/views/back_app_bar.dart';
import 'package:lexa/presentation/views/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';

class CreateTopicScreen extends StatefulWidget {
  final String? rootId;

  const CreateTopicScreen({
    super.key,
    this.rootId,
  });

  @override
  State<CreateTopicScreen> createState() => _CreateTopicScreenState();
}

class _CreateTopicScreenState extends State<CreateTopicScreen> {
  late final CreateTopicBloc _createTopicBloc;

  @override
  void initState() {
    super.initState();
    _createTopicBloc = context.read<CreateTopicBloc>();
    _createTopicBloc.add(
      UpdateNewTopic(
        topic: _createTopicBloc.state.topic.copyWith(
          data: _createTopicBloc.state.topic.data.copyWith(
            folder: widget.rootId,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CreateTopicBloc, CreateTopicState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: const BackAppBar(
            title: "Create topic",
          ),
          body: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          ThumbnailPickerSegment(
                            onPicked: (image) {
                              _createTopicBloc.add(
                                UpdateNewTopic(
                                  topic: state.topic.copyWith(
                                    thumbnail: image,
                                  ),
                                ),
                              );
                            },
                          ),
                          Form(
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                FormTextField(
                                  hintText: "Topic name",
                                  onChanged: (name) {
                                    _createTopicBloc.add(
                                      UpdateNewTopic(
                                        topic: state.topic.copyWith(
                                          data: state.topic.data
                                              .copyWith(name: name),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FormTextField(
                                  hintText: "Description",
                                  onChanged: (description) {
                                    _createTopicBloc.add(
                                      UpdateNewTopic(
                                        topic: state.topic.copyWith(
                                          data: state.topic.data.copyWith(
                                              description: description),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                TaggableFormTextField(
                                  hintText: "tags",
                                  onChanged: (tags) {
                                    _createTopicBloc.add(
                                      UpdateNewTopic(
                                        topic: state.topic.copyWith(
                                          data: state.topic.data
                                              .copyWith(tags: tags),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                FormDropdown<Group>(
                                  items: const [],
                                  hintText: 'Group',
                                  onChanged: (group) {
                                    _createTopicBloc.add(
                                      UpdateNewTopic(
                                        topic: state.topic.copyWith(
                                          data: state.topic.data
                                              .copyWith(group: group?.id),
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      'Visibility:',
                                      style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    Radio(
                                      value: false,
                                      groupValue: state.topic.data.visibility,
                                      activeColor: ColorConstants.primary,
                                      onChanged: (visibility) {
                                        _createTopicBloc.add(
                                          UpdateNewTopic(
                                            topic: state.topic.copyWith(
                                                data: state.topic.data.copyWith(
                                                    visibility: visibility)),
                                          ),
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Private',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                    Radio(
                                      value: true,
                                      groupValue: state.topic.data.visibility,
                                      activeColor: ColorConstants.primary,
                                      onChanged: (visibility) {
                                        _createTopicBloc.add(
                                          UpdateNewTopic(
                                            topic: state.topic.copyWith(
                                                data: state.topic.data.copyWith(
                                                    visibility: visibility)),
                                          ),
                                        );
                                      },
                                    ),
                                    const Text(
                                      'Public',
                                      style: TextStyle(fontSize: 16.0),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                const Row(
                                  children: [
                                    Text(
                                      "Vocabularies:",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount:
                                      state.topic.data.vocabularies.length,
                                  itemBuilder: (context, index) {
                                    CreateVocabularyDto vocabulary =
                                        state.topic.data.vocabularies[index];
                                    return ListTile(
                                      contentPadding: const EdgeInsets.all(0),
                                      leading: vocabulary.thumbnail != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: Image.file(
                                                vocabulary.thumbnail!,
                                                width: 70,
                                                height: 50,
                                                fit: BoxFit.fill,
                                              ),
                                            )
                                          : const Icon(Icons.image),
                                      title: Text(vocabulary.word.toString()),
                                      subtitle:
                                          Text(vocabulary.meaning.toString()),
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Container(
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          top: BorderSide(
                        color: Color.fromARGB(255, 240, 240, 240),
                        width: 1,
                      ))),
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 20,
                  ),
                  child: Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            final validationResult = state.topic.validate();

                            if (validationResult == null) {
                              _createTopicBloc.add(SaveTopic(context: context));
                              Navigator.pop(context);
                            } else {
                              toastification.show(
                                context: context,
                                type: ToastificationType.error,
                                style: ToastificationStyle.fillColored,
                                title: Text(validationResult.message),
                                alignment: Alignment.bottomCenter,
                                animationDuration:
                                    const Duration(milliseconds: 300),
                                autoCloseDuration:
                                    const Duration(milliseconds: 3000),
                              );
                            }
                          },
                          padding: const EdgeInsets.all(15),
                          backgroundColor: ColorConstants.white,
                          overlayColor: Colors.grey[100],
                          borderRadius: 15,
                          textColor: Colors.black,
                          text: "Save",
                        ),
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Expanded(
                        child: PrimaryButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => CreateVocabularyPage(
                                  vocabularies: state.topic.data.vocabularies,
                                ),
                              ),
                            );
                          },
                          borderRadius: 15,
                          padding: const EdgeInsets.all(15),
                          text: "Add question",
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
