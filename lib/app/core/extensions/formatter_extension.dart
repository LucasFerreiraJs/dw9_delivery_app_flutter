import 'package:intl/intl.dart';

extension FormatterExtension on double {
  String get currencyPTBR {
    final currencyFormat = NumberFormat.currency(
      locale: "pt_BR",
      symbol: r"R$",
    );
    return currencyFormat.format(this);
  }

  String get currencyENUS {
    final currencyFormat = NumberFormat.currency(
      locale: "en_US",
      symbol: r"$",
    );
    return currencyFormat.format(this);
  }
}
