import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/app_localizations.dart';
import 'package:chewie/chewie.dart';

import 'package:video_player/video_player.dart';

class detailProblem extends StatelessWidget{
  
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
        title: Text("Problem Details"),
        ),
        body:
        ListView(
        
        children:<Widget>[
          Card(
            child:ListTile(

                      leading:  Text( document['Name']+'\n\n',style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,)),
                      trailing:  Text(document['phone']+'\n\n',style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,)),
                
              ),
          ),
          
          Card(
          
           elevation: 5.0,

           child :Container(
              padding: const EdgeInsets.all(16.0),
              child: Text("Following is the problem statement : \n"+document['problemText'],style: new TextStyle(height: 3.0, fontSize: 15.2, fontWeight: FontWeight.bold,)),
            ),
          ),
          
          document['photourl']!=''?Text("Following is the image uploaded !\n",style: new TextStyle(height: 3.0, fontSize: 20.2, fontWeight: FontWeight.bold,)):Text(""),
          
          
             Container(
              
              child: _image,

            ),

          
          
        document['videourl']!=''?Text('Following is the video uploaded !',style: new TextStyle(height: 3.0, fontSize: 20.2, fontWeight: FontWeight.bold,)):Text(""),
         Builder(
          builder: (context) => videoPlayer(videoPlayerController: VideoPlayerController.network(
              document['videourl'],
            ),),
        ),
        

        
        ]
        ),
    );
  }
}

class videoPlayer extends StatefulWidget{
  final VideoPlayerController videoPlayerController;
  final bool looping;
  
  videoPlayer({this.videoPlayerController,this.looping});
  @override 
  videoPlayerState createState() => videoPlayerState();
}

class videoPlayerState extends State<videoPlayer>{
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
    return new 
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
              Chewie(
                controller: _chewieController,
              ),
            );  
  }

  @override
  void dispose() {
    super.dispose();
    // IMPORTANT to dispose of all the used resources
    widget.videoPlayerController.dispose();
    _chewieController.dispose();
  }

}