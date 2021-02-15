import 'package:flutter/material.dart';

class CircularImage extends StatelessWidget {
  final radius;
  final url;
  const CircularImage(this.radius, this.url);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: radius,
      height: radius,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Image.network(
          url,
          fit: BoxFit.fitWidth,
          filterQuality: FilterQuality.low,
          loadingBuilder: (context, child, loadingProgress) =>
              loadingProgress == null ? child : const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
