import 'package:flutter/material.dart';
import 'package:travel/widgets/circularImage.dart';
import '../home/postactions.dart';

class Post extends StatelessWidget {
  final post;
  Post(this.post);
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width > 500 ? 500 : size.width,
      height: size.width > 500 ? 500 : size.width,
      child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(5.0),
                child: PostTop(),
              ),
              flex: 1,
            ),
            Flexible(
              flex: 1,
              fit: FlexFit.loose,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text('it was an amazing trip :)'),
              ),
            ),
            Expanded(
              flex: 4,
              child: Image.network(
                'https://homepages.cae.wisc.edu/~ece533/images/airplane.png',
                fit: BoxFit.fitWidth,
                width: double.infinity,
              ),
            ),
            Expanded(
              flex: 1,
              child: PostActions(),
            ),
          ]),
    );
  }
}

class PostTop extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        CircularImage(
          40.0,
          'https://homepages.cae.wisc.edu/~ece533/images/cat.png',
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
        Expanded(
          flex: 1,
          child: IconButton(
            icon: Icon(Icons.more_vert),
            onPressed: () {},
          ),
        ),
      ],
    );
  }
}
