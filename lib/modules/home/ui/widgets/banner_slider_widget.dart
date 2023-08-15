import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/home/bloc/home_bloc.dart';
import 'package:ateba_app/modules/home/ui/widgets/banner_tile.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class BannerSliderWidget extends StatefulWidget {
  const BannerSliderWidget({super.key});

  @override
  State<BannerSliderWidget> createState() => _BannerSliderWidgetState();
}

class _BannerSliderWidgetState extends State<BannerSliderWidget> {
  int _current = 0;

  @override
  Widget build(BuildContext context) => Consumer<HomeBloc>(
        builder: (context, bloc, child) => Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider.builder(
              itemCount: bloc.sliders.length,
              itemBuilder: (context, index, i) => BannerTile(
                bannerSlider: bloc.sliders[index],
              ),
              options: CarouselOptions(
                autoPlay: true,
                height: (MediaQuery.of(context).size.width * 0.9) / 1080 * 500,
                viewportFraction: 0.85,
                onPageChanged: (index, reason) {
                  setState(() {
                    _current = index;
                  });
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: List.generate(
                bloc.sliders.length,
                (index) => Container(
                  width: index == _current ? 30 : 18,
                  height: 4,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: _current == index
                        ? ColorPalette.of(context).error
                        : ColorPalette.of(context).textPrimary.withOpacity(0.2),
                  ),
                ),
              ),
            )
          ],
        ),
      );
}
