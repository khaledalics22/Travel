import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {
  final String imgUrl; 
  PostBody(this.imgUrl); 
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgUrl,
      fit: BoxFit.fitWidth,
      width: double.infinity,
    );
  }
}
