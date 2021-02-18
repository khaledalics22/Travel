import 'package:flutter/material.dart';

class TripDetailsTop extends StatelessWidget {
  final String _imgUrl;
  const TripDetailsTop(this._imgUrl);
  @override
  Widget build(BuildContext context) {
    print('build tripdetailstop.dart');

    return ClipRRect(
        borderRadius: const BorderRadius.only(
            bottomRight: const Radius.circular(20),
            bottomLeft: const Radius.circular(20)),
        child: Container(
          width: double.infinity,
          height: MediaQuery.of(context).size.height / 3,
          child: Image.network(
            _imgUrl,
            fit: BoxFit.fitWidth,
            filterQuality: FilterQuality.low,
            loadingBuilder: (context, child, loadingProgress) =>
                loadingProgress == null
                    ? child
                    :  SizedBox(
                      height: MediaQuery.of(context).size.height / 3,
                    ),
          ),
        ));
  }
}
