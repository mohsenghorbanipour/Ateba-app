import 'package:easy_localization/easy_localization.dart';

extension PriceLable on int {
  String get withPriceLable => this > 0 ? seperateByComma : '';
  String get seperateByComma {
    final numberFormat = NumberFormat.decimalPattern();
    return numberFormat.format(this);
  }
}
