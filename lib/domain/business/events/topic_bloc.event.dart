class TopicEvent {}

class Loadtopic extends TopicEvent {
  final String id;

  Loadtopic({required this.id});
}
