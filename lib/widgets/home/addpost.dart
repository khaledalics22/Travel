import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travel/widgets/home/addpostactions.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: Image.network(
              'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
              fit: BoxFit.fitWidth,
            ),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              'Owner Name',
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPostState extends State<AddPost> with TickerProviderStateMixin {
  var _inputText = '';
  var inputController = TextEditingController();
  var inputTapped = false;
  File _pickedImage;
  void displayPickedImage(File img) {
    setState(() {
      _pickedImage = img;
    });
  }

  @override
  Widget build(BuildContext context) {
    inputController.text = _inputText;
    var size = MediaQuery.of(context).size;

    return Container(
      width: double.infinity,
      child: Container(
        padding: EdgeInsets.all(8.0),
        child: AnimatedSize(
          duration: Duration(milliseconds: 300),
          vsync: this,
          child: Container(
            height: size.height > 500
                ? size.height / ((inputTapped || _pickedImage != null) ? 2 : 3)
                : size.height / 2,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  HomeTop(),
                  Divider(),
                  Expanded(
                    flex: 3,
                    child: TextField(
                      textDirection: TextDirection.ltr,
                      decoration: InputDecoration(
                          hintText: 'Share your experience here!',
                          border: InputBorder.none),
                      minLines: null,
                      expands: true,
                      onTap: () {
                        setState(() {
                          inputTapped = !inputTapped;
                          if (!inputTapped) FocusScope.of(context).unfocus();
                        });
                      },
                      maxLines: null,
                      onChanged: (text) {
                        setState(() {
                          _inputText = text;
                        });
                      },
                      style: TextStyle(fontSize: 18),
                      cursorColor: Colors.orange,
                    ),
                  ),
                  if (_pickedImage != null)
                    Container(
                      width: double.infinity,
                      height: 100,
                      alignment: Alignment.centerLeft,
                      child: Stack(children: [
                        Image.file(
                          _pickedImage,
                          fit: BoxFit.scaleDown,
                          height: 100,
                          width: 100,
                        ),
                        Positioned(
                          right: 1,
                          top: 1,
                          child: IconButton(
                              icon: Icon(
                                Icons.close,
                                size: 25,
                                color: Theme.of(context).primaryColorDark,
                              ),
                              onPressed: () {
                                setState(() {
                                  _pickedImage = null;
                                });
                              }),
                        )
                      ]),
                    ),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: Divider(
                      thickness: 1,
                      color: Theme.of(context).primaryColorLight,
                    ),
                  ),
                  AddPostActions(
                    _inputText,
                    displayPickedImage,
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}
