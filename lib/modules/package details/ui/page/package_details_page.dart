import 'package:ateba_app/modules/package%20details/bloc/package_details_bloc.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class PackageDetailsPage extends StatelessWidget {
  const PackageDetailsPage({
    required this.slug,
    super.key,
  });

  final String slug;

  @override
  Widget build(BuildContext context) => ChangeNotifierProvider(
        create: (context) => PackageDetailsBloc(slug),
        lazy: false,
        builder: (context, child) => const Scaffold(),
      );
}
