import 'package:flutter/material.dart';
import 'package:travel/widgets/circularImage.dart';

class ProfileTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
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
            width: double.infinity,
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
