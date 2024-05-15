import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lexa/data/models/profile.model.dart';
import 'package:lexa/domain/business/blocs/profile.bloc.dart';
import 'package:lexa/domain/business/states/profile_bloc.state.dart';
import 'package:lexa/presentation/shared/widgets/double_text_row.dart';

class ProfileInformationTab extends StatelessWidget {
  const ProfileInformationTab({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
      final Profile? profile = state.getAuthenticatedNode();
      return Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          children: [
            DoubleTextRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainTextSize: 15,
              mainText: "Name:",
              subText: profile?.name ?? "",
            ),
            const SizedBox(
              height: 10,
            ),
            DoubleTextRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainTextSize: 15,
              mainText: "Email:",
              subText: profile?.email ?? "",
            ),
            const SizedBox(
              height: 10,
            ),
            DoubleTextRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainTextSize: 15,
              mainText: "Phone:",
              subText: profile?.phone ?? "",
            ),
          ],
        ),
      );
    });
  }
}
