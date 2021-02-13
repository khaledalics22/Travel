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
  bool error = false;
  VideoPlayerController _controller;
  @override
  void initState() {
    super.initState();
    initVid();
  }

  void initVid() {
    _controller = VideoPlayerController.network(
      widget.url,
    );
    _controller.initialize().then(
      (value) => setState(() {}),
      onError: (result) {
        setState(() {
          error = true;
        });
      },
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // print('videoooooooooooooo rul : ${widget.url}');
    return VisibilityDetector(
      onVisibilityChanged: (info) {
        if (info.visibleFraction == 0)
          setState(() {
            _controller.pause();
          });
      },
      key: Key('video key'),
      child: Container(
        width: double.infinity,
        // height: MediaQuery.of(context).size.height / 3,
        child: error
            ? Center(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      IconButton(
                        iconSize: 40,
                        color: Colors.grey,
                        onPressed: initVid,
                        icon: Icon(
                          Icons.replay_rounded,
                        ),
                      ),
                      Text(
                        'reload video',
                        style: TextStyle(color: Colors.grey, fontSize: 16),
                      )
                    ]),
              )
            : Container(
                height: MediaQuery.of(context).size.height / 3,
                child: Stack(alignment: Alignment.center, children: [
                  _controller.value.initialized
                      ? AspectRatio(
                          aspectRatio: _controller.value.aspectRatio,
                          child: VideoPlayer(_controller),
                        )
                      : SizedBox(
                          height: 40,
                          width: 40,
                          child: CircularProgressIndicator()),
                  if (_controller.value.initialized)
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
              ),
      ),
    );
  }
}
