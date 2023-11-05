import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:ateba_app/modules/package%20details/data/models/tutorial_package.dart';
import 'package:ateba_app/modules/package%20details/ui/widgets/tutorial_package_card.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/tutorial_details.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonsWidget extends StatelessWidget {
  const LessonsWidget({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => Consumer<PackageDetailsBloc>(
        builder: (context, bloc, child) => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
          itemCount: bloc.packageDetails?.tutorials?.length ?? 0,
          separatorBuilder: (_, __) => const SizedBox(
            height: 12,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => TutorialPackageCard(
            slug: slug,
            index: index,
            tutorialPackage:
                bloc.packageDetails?.tutorials?[index] ?? TutorialPackage(),
          ),
        ),
      );
}
