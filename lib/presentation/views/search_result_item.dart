import 'package:flutter/material.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/data/models/topic.model.dart';
import 'package:lexa/presentation/views/circular_avatar.dart';

class SearchResultItem extends StatelessWidget {
  final dynamic result;

  const SearchResultItem({
    super.key,
    required this.result,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      leading: CircularAvatar(
        imageUrl: _getImageUrl(),
        size: 50,
      ),
      title: Text(
        _getTitle(),
        style: theme.textTheme.bodyLarge,
      ),
      subtitle: Text(
        _getSubTitle(),
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  String _getImageUrl() {
    if (result is Profile) {
      return (result as Profile).avatar;
    } else if (result is Topic) {
      return (result as Topic).thumbnail;
    }
    return "";
  }

  String _getTitle() {
    if (result is Profile) {
      return (result as Profile).name;
    } else if (result is Topic) {
      return (result as Topic).name;
    }
    return "";
  }

  String _getSubTitle() {
    if (result is Profile) {
      return (result as Profile).email;
    } else if (result is Topic) {
      return (result as Topic).description;
    }
    return "";
  }
}
