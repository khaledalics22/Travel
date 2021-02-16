import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Utils {
  static String dateDifference(int commDate) {
    var date = DateTime.fromMillisecondsSinceEpoch(commDate);
    return DateTime.now().difference(date)?.inDays != 0
        ? '${DateTime.now().difference(date)?.inDays}d ago'
        : DateTime.now().difference(date)?.inHours != 0
            ? '${DateTime.now().difference(date)?.inHours}h ago'
            : DateTime.now().difference(date)?.inMinutes != 0
                ? '${DateTime.now().difference(date)?.inMinutes}m ago'
                : DateTime.now().difference(date)?.inMinutes != 0
                    ? '${DateTime.now().difference(date)?.inSeconds}s ago'
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
}
