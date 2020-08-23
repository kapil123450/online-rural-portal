import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_localizations.dart';
import 'package:chewie/chewie.dart';
import 'package:cached_network_image/cached_network_image.dart';

import 'package:video_player/video_player.dart';

class detailProblem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
    final Image _image = Image.network(document['photourl']);
    final String image = document['photourl'];
    final String videoFile = document['videourl'];
    debugPrint(image);
    debugPrint(videoFile);
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context)
            .translate("Whole detail of the problem")),
      ),
      body: ListView(children: <Widget>[
        Card(
          child: ListTile(
            leading: Text(document['Name'] + '\n\n',
                style: new TextStyle(
                  height: 3.0,
                  fontSize: 15.2,
                  fontWeight: FontWeight.bold,
                )),
            trailing: Text(document['phone'] + '\n\n',
                style: new TextStyle(
                  height: 3.0,
                  fontSize: 15.2,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        Card(
          elevation: 5.0,
          child: Container(
            padding: const EdgeInsets.all(16.0),
            child: Text(
                Text(AppLocalizations.of(context)
                            .translate("Problem Description"))
                        .data +
                    " : \n" +
                    document['problemText'],
                style: new TextStyle(
                  height: 3.0,
                  fontSize: 15.2,
                  fontWeight: FontWeight.bold,
                )),
          ),
        ),
        document['photourl'] != ''
            ? Text(
                Text(AppLocalizations.of(context)
                            .translate("Following is the image uploaded"))
                        .data +
                    " !\n",
                style: new TextStyle(
                  height: 3.0,
                  fontSize: 20.2,
                  fontWeight: FontWeight.bold,
                ))
            : Text(""),
        CachedNetworkImage(
          imageUrl: document['photourl'],
          placeholder: (context, url) => Container(
            child: Center(
              child: new CircularProgressIndicator(),
            ),
          ),
          errorWidget: (context, url, error) => new Icon(Icons.error),
        ),
        document['videourl'] != ''
            ? Text(
                Text(AppLocalizations.of(context)
                            .translate("Following is the video uploaded"))
                        .data +
                    " !\n",
                style: new TextStyle(
                  height: 3.0,
                  fontSize: 20.2,
                  fontWeight: FontWeight.bold,
                ))
            : Text(""),
        Builder(
          builder: (context) => videoPlayer(
            videoPlayerController: VideoPlayerController.network(
              document['videourl'],
            ),
          ),
        ),
      ]),
    );
  }
}

class videoPlayer extends StatefulWidget {
  final VideoPlayerController videoPlayerController;
  final bool looping;

  videoPlayer({this.videoPlayerController, this.looping});
  @override
  videoPlayerState createState() => videoPlayerState();
}

class videoPlayerState extends State<videoPlayer> {
  ChewieController _chewieController;

  @override
  void initState() {
    super.initState();
    // Wrapper on top of the videoPlayerController
    _chewieController = ChewieController(
      videoPlayerController: widget.videoPlayerController,
      aspectRatio: 16 / 9,
      // Prepare the video to be played and display the first frame
      autoInitialize: true,
      looping: widget.looping,
      allowFullScreen: true,
      // Errors can occur for example when trying to play a video
      // from a non-existent URL
      errorBuilder: (context, errorMessage) {
        return Center(
          child: Text(
            errorMessage,
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return new Padding(
      padding: const EdgeInsets.all(16.0),
      child: Chewie(
        controller: _chewieController,
      ),
    );
  }
}
