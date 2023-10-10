import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/course_toturials_card.dart';
import 'package:ateba_app/modules/home/data/models/tutorial.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LessonsWidget extends StatelessWidget {
  const LessonsWidget({super.key});

  @override
  Widget build(BuildContext context) =>
      Selector<CourseDetailsBloc, List<Tutorial>>(
        selector: (context, bloc) => bloc.courseDetails?.tutorials ?? [],
        builder: (context, tutorials, child) => ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          padding: const EdgeInsets.fromLTRB(16, 24, 16, 100),
          itemCount: tutorials.length,
          separatorBuilder: (_, __) => const SizedBox(
            height: 12,
          ),
          shrinkWrap: true,
          itemBuilder: (context, index) => CourseToturialsCard(
            tutorial: tutorials[index],
          ),
        ),
      );
}
