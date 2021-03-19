import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/user.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/screens/addpost.dart';
import 'package:travel/screens/createtirp.dart';

class AddPost extends StatefulWidget {
  final Function isExtended;
  const AddPost(this.isExtended);
  @override
  _AddPostState createState() => _AddPostState();
}

class HomeTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print('build addpost.dart');
    CustomUser user = Provider.of<Auther>(context, listen: false).user;
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(40),
            child: user?.profileUrl != null
                ? Image.network(
                    user.profileUrl,
                    fit: BoxFit.fitWidth,
                    filterQuality: FilterQuality.low,
                    loadingBuilder: (context, child, loadingProgress) =>
                        loadingProgress == null
                            ? child
                            : SizedBox(
                                width: 40,
                                height: 40,
                              ),
                  )
                : const Icon(Icons.person),
          ),
        ),
        Expanded(
          flex: 7,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              user.name,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ),
        ),
      ],
    );
  }
}

class _AddPostState extends State<AddPost> with TickerProviderStateMixin {
  CustomUser user;
  Widget button(String title, Function action, IconData icon) {
    return FlatButton.icon(
      height: 30,
      icon: Icon(icon),
      textColor: Theme.of(context).primaryColorDark,
      onPressed: action,
      label: Text(
        title,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    print('build addpost.dart');
    user = Provider.of<Auther>(context, listen: false).user;
    return Container(
      width: double.infinity,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        child: AnimatedSize(
          duration: const Duration(milliseconds: 300),
          vsync: this,
          child: Wrap(
            children: [
              HomeTop(),
              GestureDetector(
                onTap: () => Navigator.of(context).pushNamed(
                    AddPostScreen.route,
                    arguments: 0 /**no action =0  */),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Text(
                      'Share your experience here',
                      style: TextStyle(color: Colors.grey, fontSize: 18),
                    ),
                  ),
                ),
              ),
              Container(
                  height: 40,
                  child: Row(
                    children: [
                      Expanded(
                          child: FlatButton.icon(
                        icon: Icon(
                          Icons.video_collection_outlined,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        label: Text(
                          'video',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddPostScreen.route,
                              arguments: 2 /**upload video = 2 */);
                        },
                      )),
                      VerticalDivider(
                        thickness: 1,
                        indent: 5,
                        color: Theme.of(context).primaryColorDark,
                      ),
                      if (Platform.isIOS)
                        Expanded(
                            child: button('Create Trip', () {
                          Navigator.of(context).pushNamed(CreateTrip.route);
                        }, null)),
                      if (Platform.isIOS)
                        VerticalDivider(
                          thickness: 1,
                          indent: 5,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      Expanded(
                          child: FlatButton.icon(
                        icon: Icon(
                          Icons.photo,
                          color: Theme.of(context).primaryColorDark,
                        ),
                        label: Text(
                          'photo',
                          style: TextStyle(
                            color: Theme.of(context).primaryColorDark,
                          ),
                        ),
                        onPressed: () {
                          Navigator.of(context).pushNamed(AddPostScreen.route,
                              arguments: 1 /**upload photo = 1 */);
                        },
                      ))
                    ],
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
