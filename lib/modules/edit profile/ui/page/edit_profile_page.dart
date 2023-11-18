import 'package:ateba_app/modules/auth/bloc/auth_bloc.dart';
import 'package:ateba_app/modules/auth/data/models/user.dart';
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
          create: (context) => EditProfileBloc()..loadProfileConfig(),
          lazy: false,
          builder: (context, child) => UserInfoWidget(
            user: context.select<AuthBloc, User>(
              (bloc) => bloc.userProfile ?? User(),
            ),
            isEditProfile: isEditProfile,
          ),
        )
      : ChangeNotifierProvider(
          create: (context) => EditProfileBloc(),
          builder: (context, child) => UserInfoWidget(
            user: context.select<AuthBloc, User>(
              (bloc) => bloc.userProfile ?? User(),
            ),
            isEditProfile: isEditProfile,
          ),
        );
}
