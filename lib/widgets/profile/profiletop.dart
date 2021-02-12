import 'package:flutter/material.dart';
import 'package:travel/widgets/circularImage.dart';

class ProfileTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: (170.0 + 50.0),
      child: Stack(
        alignment: Alignment.topCenter,
        children: [
          Image.network(
            'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
            fit: BoxFit.cover,
            height: 170.0,
            filterQuality: FilterQuality.low,
            width: double.infinity,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null ? child : CircularProgressIndicator(),
          ),
          Positioned(
            bottom: 0,
            child: CircleAvatar(
              radius: 79,
              backgroundColor: Colors.white,
              child: CircularImage(
                150.0,
                'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
              ),
            ),
          ),
        ],
      ),
    );
  }
}
