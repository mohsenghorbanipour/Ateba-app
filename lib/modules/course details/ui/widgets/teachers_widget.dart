import 'package:ateba_app/modules/course%20details/bloc/course_details_bloc.dart';
import 'package:ateba_app/modules/course%20details/ui/widgets/teacher_tile.dart';
import 'package:ateba_app/modules/home/data/models/teacher.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TeachersWidget extends StatelessWidget {
  const TeachersWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
        // mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 32, left: 16, right: 16),
            child: Text(
              'introduction_of_professors'.tr(),
              style: Theme.of(context).textTheme.titleSmall,
            ),
          ),
          Selector<CourseDetailsBloc, List<Teacher>>(
            selector: (context, bloc) => bloc.courseDetails?.teachers ?? [],
            builder: (context, teachers, child) => ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.fromLTRB(16, 23, 16, 150),
              itemCount: teachers.length,
              shrinkWrap: true,
              separatorBuilder: (context, index) => const SizedBox(
                height: 12,
              ),
              itemBuilder: (context, index) => TeacherTile(
                teacher: teachers[index],
              ),
            ),
          ),
        ],
      );
}
