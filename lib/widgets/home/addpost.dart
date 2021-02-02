import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travel/widgets/home/addpostactions.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  var _inputText = '';
  var inputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    inputController.text = _inputText;
    return Container(
      height: MediaQuery.of(context).size.height / 3,
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: Column(children: [
          Expanded(
            flex: 3,
            child: TextField(
              textDirection: TextDirection.ltr,
              decoration: InputDecoration(
                  hintText: 'Share your experience here!',
                  border: InputBorder.none),
              minLines: 4,
              maxLines: 4,
              onChanged: (text) {
                setState(() {
                  _inputText = text;
                });
              },
              style: TextStyle(fontSize: 18),
              cursorColor: Colors.orange,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(5.0),
            child: Divider(
              height: 1,
              thickness: 1,
              color: Theme.of(context).primaryColorLight,
            ),
          ),
          Expanded(
            flex: 1,
            child: AddPostActions(_inputText),
          )
        ]),
      ),
    );
  }
}
