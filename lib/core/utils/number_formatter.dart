import 'package:intl/intl.dart';

String formatCount(int value) {
  return NumberFormat.decimalPattern('en_IN').format(value);
}

String formatAmount(String value) {
  if (value.endsWith('C') || value.endsWith('L')) {
    return value;
  }

  final amount = double.tryParse(value);

  if (amount == null) {
    return value;
  }

  if (amount >= 10000000) {
    return '${(amount / 10000000).toStringAsFixed(2)} C';
  }

  return '${(amount / 100000).toStringAsFixed(2)} L';
}
