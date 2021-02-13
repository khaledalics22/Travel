import 'package:flutter/material.dart';

class PostBody extends StatelessWidget {
  final String imgUrl;
  PostBody(this.imgUrl);
  @override
  Widget build(BuildContext context) {
    return Image.network(
      imgUrl,
      fit: BoxFit.fitWidth,
      filterQuality: FilterQuality.low,
      width: double.infinity,
      height: MediaQuery.of(context).size.height / 3,
      loadingBuilder: (context, child, loadingProgress) =>
          loadingProgress == null ? child : CircularProgressIndicator(),
    );
  }
}
