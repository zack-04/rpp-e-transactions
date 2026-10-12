import 'package:intl/intl.dart';

String formatLastUpdated(DateTime? time) {
  return 'Last updated: ${DateFormat('hh:mm a').format(time!)}';
}
