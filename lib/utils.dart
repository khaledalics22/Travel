import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class Utils {
  static String dateDifference(int commDate) {
    var date = DateTime.fromMillisecondsSinceEpoch(commDate);
    final diff = DateTime.now().difference(date);
    final format = DateFormat(DateFormat.YEAR_MONTH_DAY);
    return diff.inDays > 6
        ? '${format.format(date)}d ago'
        : diff.inDays > 0
            ? '${diff?.inDays}d ago'
            : diff?.inHours != 0
                ? '${diff?.inHours}h ago'
                : diff?.inMinutes != 0
                    ? '${diff?.inMinutes}m ago'
                    : diff?.inMinutes != 0
                        ? '${diff?.inSeconds}s ago'
                        : 'now';
  }

  static Future<File> getImage() async {
    final picker = ImagePicker();
    final _pickedFile = await picker.getImage(source: ImageSource.gallery);
    if (_pickedFile != null) {
      return File(_pickedFile.path);
    } else {
      print('No image selected.');
    }
    return null;
  }

  static String buildId({String id1, String id2}) {
    List<String> ids = [id1, id2];
    ids.sort((a, b) =>
        a.toString().toLowerCase().compareTo(b.toString().toLowerCase()));
    return '${ids[0]}_${ids[1]}';
  }
}
