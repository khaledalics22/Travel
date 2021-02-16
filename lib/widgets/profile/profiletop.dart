import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/Requests.dart';
import 'package:travel/providers/auth.dart';
import 'package:travel/utils.dart';
import 'package:travel/widgets/circularImage.dart';

class ProfileTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auther>(context).user;
    return Container(
      width: double.infinity,
      height: (170.0 + 50.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            user.coverUrl != null
                ? user.coverUrl
                : Requests.appImgUrl+Provider.of<Auther>(context).user.token,
            fit: BoxFit.cover,
            height: 170.0,
            filterQuality: FilterQuality.low,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null ? child : CircularProgressIndicator(),
          ),
          Positioned(
            child: Container(
              height: 2,
              width: MediaQuery.of(context).size.width,
              child: Divider(
                thickness: 2,
              ),
            ),
            top: 170,
          ),
          Positioned(
            bottom: 0,
            child: Stack(children: [
              CircleAvatar(
                radius: 79,
                backgroundColor: Colors.grey,
                child: CircularImage(
                  150.0,
                  user.profileUrl != null
                      ? user.profileUrl
                      : Requests.appImgUrl+Provider.of<Auther>(context).user.token,
                ),
              ),
              Positioned(
                bottom: 0,
                right: 0,
                child: CircleAvatar(
                  child: IconButton(
                    icon: Icon(Icons.add_a_photo),
                    onPressed: () async {
                      File _image = await Utils.getImage();
                      final auther =
                          Provider.of<Auther>(context, listen: false);
                      String url = await auther.uploadProfileImage(_image);
                      user.profileUrl = url;
                      await auther.updateUser(user);
                      Scaffold.of(context).showSnackBar(
                          SnackBar(content: Text('photo uploaded')));
                    },
                  ),
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }
}
