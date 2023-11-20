import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/text%20viewer/bloc/text_viewer_bloc.dart';
import 'package:ateba_app/modules/tutorial%20details/data/models/file_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TextViewerPage extends StatelessWidget {
  const TextViewerPage({
    required this.file,
    super.key,
  });

  final FileData file;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => TextViewerBloc(),
        builder: (context, child) => Consumer<TextViewerBloc>(
          builder: (context, bloc, child) => Scaffold(
            backgroundColor: bloc.darkMode
                ? ColorPalette.dark.scaffoldBackground
                : ColorPalette.light.scaffoldBackground,
            appBar: AppBar(
              backgroundColor: bloc.darkMode
                  ? ColorPalette.dark.scaffoldBackground
                  : ColorPalette.light.scaffoldBackground,
              surfaceTintColor: bloc.darkMode
                  ? ColorPalette.dark.scaffoldBackground
                  : ColorPalette.light.scaffoldBackground,
              title: Text(
                file.title ?? '',
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: bloc.darkMode
                          ? ColorPalette.dark.textPrimary
                          : ColorPalette.light.textPrimary,
                    ),
              ),
              automaticallyImplyLeading: false,
              leading: IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: Icon(
                  Icons.close_rounded,
                  color: bloc.darkMode
                      ? ColorPalette.dark.textPrimary
                      : ColorPalette.light.textPrimary,
                ),
              ),
              centerTitle: false,
              actions: [
                IconButton(
                  onPressed: () {
                    bloc.darkMode = !bloc.darkMode;
                  },
                  icon: Icon(
                    bloc.darkMode
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: bloc.darkMode
                        ? ColorPalette.dark.textPrimary
                        : ColorPalette.light.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    bloc.increaseTextSize();
                  },
                  icon: Icon(
                    Icons.text_increase,
                    color: bloc.darkMode
                        ? ColorPalette.dark.textPrimary
                        : ColorPalette.light.textPrimary,
                  ),
                ),
                IconButton(
                  onPressed: () {
                    bloc.decreaseTextSize();
                  },
                  icon: Icon(
                    Icons.text_decrease,
                    color: bloc.darkMode
                        ? ColorPalette.dark.textPrimary
                        : ColorPalette.light.textPrimary,
                  ),
                ),
              ],
            ),
            body: ListView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(16),
              children: [
                Text(
                  file.title ?? '',
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: bloc.darkMode
                          ? ColorPalette.dark.textPrimary
                          : ColorPalette.light.textPrimary,
                      fontSize: bloc.textSize),
                ),
                Text(
                  file.text ?? '',
                  style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      color: bloc.darkMode
                          ? ColorPalette.dark.textPrimary
                          : ColorPalette.light.textPrimary,
                      fontSize: bloc.textSize),
                ),
              ],
            ),
          ),
        ),
      );
}
