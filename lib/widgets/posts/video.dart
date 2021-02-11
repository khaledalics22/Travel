import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

class VideoWidget extends StatefulWidget {
  final String url;
  VideoWidget(this.url);
  @override
  _VieoWidgetState createState() => _VieoWidgetState();
}

class _VieoWidgetState extends State<VideoWidget> {
  VideoPlayerController _controller;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = VideoPlayerController.network(widget.url);
    _controller.initialize().then((value) => setState(() {}));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print('videoooooooooooooo rul : ${widget.url}');
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0)
          setState(() {
            _controller.pause();
          });
      },
      key: Key('video key'),
      child: Stack(alignment: Alignment.center, children: [
        Container(
          width: double.infinity,
          // height: MediaQuery.of(context).size.height / 3,
          child: _controller.value.initialized
              ? AspectRatio(
                  aspectRatio: _controller.value.aspectRatio,
                  child: VideoPlayer(_controller),
                )
              : RaisedButton(
                  child: Text('try again!'),
                  onPressed: () {
                    setState(() {});
                  }),
        ),
        AnimatedOpacity(
          opacity: _controller.value.isPlaying ? 0.0 : 1.0,
          duration: Duration(milliseconds: 500),
          child: Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black45,
            child: IconButton(
              onPressed: () => setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              }),
              icon: Icon(
                _controller.value.isPlaying
                    ? Icons.pause_circle_outline
                    : Icons.play_circle_outline_outlined,
                color: Theme.of(context).primaryColorDark,
                size: 40,
              ),
            ),
          ),
        )
      ]),
    );
  }
}
