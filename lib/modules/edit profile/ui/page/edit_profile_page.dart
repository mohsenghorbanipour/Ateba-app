import 'package:ateba_app/modules/edit%20profile/bloc/edit_profile_bloc.dart';
import 'package:ateba_app/modules/edit%20profile/ui/widgets/user_info_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class EditProfilePage extends StatelessWidget {
  const EditProfilePage({
    this.isEditProfile = true,
    super.key,
  });

  final bool isEditProfile;

  @override
  Widget build(BuildContext context) => isEditProfile
      ? ChangeNotifierProvider(
          create: (context) => EditProfileBloc(),
          builder: (context, child) => UserInfoWidget(
            isEditProfile: isEditProfile,
          ),
        )
      : ChangeNotifierProvider(
          create: (context) => EditProfileBloc(),
          builder: (context, child) => UserInfoWidget(
            isEditProfile: isEditProfile,
          ),
        );
}
