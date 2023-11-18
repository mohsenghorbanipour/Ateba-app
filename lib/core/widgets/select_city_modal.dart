import 'package:ateba_app/core/components/button_component.dart';
import 'package:ateba_app/core/components/modal_component.dart';
import 'package:ateba_app/core/components/shimmer_components.dart';
import 'package:ateba_app/core/components/textfiled_component.dart';
import 'package:ateba_app/core/theme/style/color_palatte.dart';
import 'package:ateba_app/modules/auth/data/models/config_item.dart';
import 'package:ateba_app/modules/edit%20profile/bloc/edit_profile_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SelectCityModal extends StatefulWidget {
  const SelectCityModal({
    this.isEditedProfile = true,
    super.key,
  });

  final bool isEditedProfile;

  @override
  State<SelectCityModal> createState() => _SelectCityModalState();
}

class _SelectCityModalState extends State<SelectCityModal> {
  @override
  void initState() {
    selectedCity =
        Provider.of<EditProfileBloc>(context, listen: false).selectedCity;
    super.initState();
  }

  ConfigItem? selectedCity;

  String searchKey = '';

  @override
  Widget build(BuildContext context) => Modal(
        backgroundColor: ColorPalette.of(context).scaffoldBackground,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
          child: SizedBox(
            height: MediaQuery.of(context).size.height / 2,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 65,
                  height: 6,
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.3),
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                TextFieldComponent(
                  name: 'search',
                  showLabel: false,
                  hintText: 'city'.tr(),
                  textAlign: TextAlign.right,
                  onChanged: (val) {
                    setState(() {
                      searchKey = val;
                    });
                  },
                  prefixIcon: Icon(
                    Icons.search,
                    color:
                        ColorPalette.of(context).textPrimary.withOpacity(0.4),
                  ),
                ),
                if (context.select<EditProfileBloc, bool>(
                    (bloc) => bloc.loadingCities))
                  Expanded(
                    child: ListView.separated(
                      padding: const EdgeInsets.symmetric(vertical: 12),
                      itemCount: 7,
                      itemBuilder: (_, __) => const ShimmerContainer(
                        width: double.infinity,
                        height: 50,
                      ),
                      separatorBuilder: (_, __) => const SizedBox(
                        height: 12,
                      ),
                    ),
                  )
                else
                  Selector<EditProfileBloc, List<ConfigItem>>(
                    selector: (context, bloc) => bloc.cities
                        .where((e) => e.name?.contains(searchKey) ?? false)
                        .toList(),
                    builder: (context, cities, child) => Expanded(
                      child: ListView.separated(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        itemCount: cities.length,
                        itemBuilder: (_, index) => InkWell(
                          onTap: () {
                            setState(() {
                              selectedCity = cities[index];
                            });
                          },
                          child: AnimatedContainer(
                            duration: const Duration(milliseconds: 300),
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                width: 1,
                                color: selectedCity == cities[index]
                                    ? ColorPalette.of(context).primary
                                    : ColorPalette.of(context).border,
                              ),
                            ),
                            padding: const EdgeInsets.all(8),
                            child: Column(
                              children: [
                                Text(
                                  cities[index].name ?? '',
                                )
                              ],
                            ),
                          ),
                        ),
                        separatorBuilder: (_, __) => const SizedBox(
                          height: 12,
                        ),
                      ),
                    ),
                  ),
                ButtonComponent(
                  onPressed: () {
                    Provider.of<EditProfileBloc>(context, listen: false)
                        .selectedCity = selectedCity;
                    Navigator.of(context).pop();
                  },
                  height: 40,
                  child: Text(
                    'select'.tr(),
                  ),
                )
              ],
            ),
          ),
        ),
      );
}
