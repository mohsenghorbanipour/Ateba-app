// ignore_for_file: use_build_context_synchronously

import 'dart:isolate';

import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/video%20player/bloc/video_player_bloc.dart';
import 'package:ateba_app/modules/video%20player/data/models/video_quiz.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class QuizModal extends StatefulWidget {
  const QuizModal({
    required this.videoQuiz,
    this.isRotate = false,
    super.key,
  });

  final VideoQuiz videoQuiz;
  final bool isRotate;

  @override
  State<QuizModal> createState() => _QuizModalState();
}

class _QuizModalState extends State<QuizModal> {
  int? selectedAnswerId;

  @override
  Widget build(BuildContext context) => RotatedBox(
        quarterTurns: widget.isRotate ? 1 : 0,
        child: Modal(
          margin: const EdgeInsets.all(8),
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 6, 8, 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: Container(
                    width: 65,
                    height: 6,
                    margin: const EdgeInsets.only(bottom: 12),
                    decoration: BoxDecoration(
                        color: ColorPalette.of(context)
                            .textPrimary
                            .withOpacity(0.3),
                        borderRadius: BorderRadius.circular(6)),
                  ),
                ),
                Text(
                  widget.videoQuiz.text ?? '',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                ListView.separated(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: widget.videoQuiz.choices?.length ?? 0,
                  separatorBuilder: (_, __) => const SizedBox(
                    height: 12,
                  ),
                  itemBuilder: (_, index) => InkWell(
                    onTap: () {
                      setState(() {
                        selectedAnswerId = widget.videoQuiz.choices?[index].id;
                      });
                    },
                    child: Row(
                      children: [
                        Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(
                              width: 1,
                              color: ColorPalette.of(context).border,
                            ),
                          ),
                          child: selectedAnswerId ==
                                  widget.videoQuiz.choices?[index].id
                              ? Center(
                                  child: Container(
                                    width: 7,
                                    height: 7,
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        color:
                                            ColorPalette.of(context).primary),
                                  ),
                                )
                              : null,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 6),
                          child: Text(
                            widget.videoQuiz.choices?[index].text ?? '',
                          ),
                        )
                      ],
                    ),
                  ),
                  shrinkWrap: true,
                ),
                ButtonComponent(
                  onPressed: () async {
                    await Provider.of<VideoPlayerBloc>(context, listen: false)
                        .answerQuestion(
                      widget.videoQuiz.id!,
                      selectedAnswerId!,
                    );
                    context.pop();
                  },
                  height: 40,
                  loading: context.select<VideoPlayerBloc, bool>(
                      (bloc) => bloc.answerQuestionLoading),
                  enabled: selectedAnswerId != null,
                  child: Text(
                    'register_answer'.tr(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
