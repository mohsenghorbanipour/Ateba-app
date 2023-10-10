import 'package:ateba_app/core/components/loading_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:flutter/material.dart';

class ButtonComponent extends StatelessWidget {
  const ButtonComponent({
    this.width = double.infinity,
    this.height = 48,
    required this.onPressed,
    required this.child,
    this.borderRadius,
    this.borderSide = BorderSide.none,
    this.enabled = true,
    this.loading = false,
    this.color,
    this.splashColor,
    this.loadingColor,
    this.maxWidth,
    this.minwidth,
    this.margin,
    Key? key,
  }) : super(key: key);

  final double? width;
  final double? height;
  final Widget child;
  final Function onPressed;
  final BorderRadiusGeometry? borderRadius;
  final Color? color;
  final BorderSide borderSide;
  final bool enabled;
  final bool loading;
  final Color? splashColor;
  final Color? loadingColor;
  final double? maxWidth;
  final double? minwidth;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) => Container(
        width: width,
        height: height,
        margin: margin,
        child: ElevatedButton(
          onPressed: !loading && enabled
              ? () {
                  onPressed();
                  FocusScope.of(context).requestFocus(FocusNode());
                }
              : null,
          style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: MaterialStateProperty.resolveWith(
                  (states) => !enabled
                      ? ColorPalette.of(context).primary
                      : color ?? ColorPalette.of(context).primary,
                ),
                overlayColor: MaterialStateProperty.resolveWith((states) =>
                    states.contains(MaterialState.disabled)
                        ? Colors.transparent
                        : states.contains(MaterialState.pressed)
                            ? ColorPalette.of(context)
                                .lightPrimary
                                .withOpacity(0.6)
                            : splashColor ??
                                ColorPalette.of(context)
                                    .primary
                                    .withOpacity(0.1)),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: borderRadius ?? BorderRadius.circular(6),
                    side: borderSide,
                  ),
                ),
                elevation: MaterialStateProperty.all(0),
              ),
          child: loading
              ? Center(
                  child: LoadingComponent(
                  color: loadingColor ?? ColorPalette.of(context).white,
                  size: 24,
                ))
              : child,
        ),
      );
}
