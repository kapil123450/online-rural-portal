import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_app/screens/app_localizations.dart';
import 'package:chewie/chewie.dart';

import 'package:video_player/video_player.dart';

class detailProblem extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    final DocumentSnapshot document = ModalRoute.of(context).settings.arguments;
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
          
          Image.network(
          document['photourl'],
          //"https://cdn.pixabay.com/photo/2017/02/21/21/13/unicorn-2087450_1280.png",
          fit: BoxFit.cover,
          
          alignment: Alignment.center,
        ),
          
        document['videourl']!=''?Text('Following is the video uploaded !',style: new TextStyle(height: 3.0, fontSize: 20.2, fontWeight: FontWeight.bold,)):Text(""),
         Builder(
          builder: (context) => videoPlayer(videoFile),
        ),
        

        
        ]
        ),
    );
  }
}

class videoPlayer extends StatefulWidget{
  final String videoFile; 
  videoPlayer(this.videoFile);
  @override 
  videoPlayerState createState() => videoPlayerState();
}

class videoPlayerState extends State<videoPlayer>{
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;
  String videoFile = '';

  @override
  void initState() {
    videoFile = widget.videoFile;
    debugPrint(videoFile);
    _controller = VideoPlayerController.network(
      
      videoFile,
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  
   @override
  Widget build(BuildContext context) {
    return new 
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: 
            videoFile!=null&&mounted?Chewie(
                          controller: ChewieController(
                            videoPlayerController: _controller,
                            aspectRatio: 3/2,
                            autoPlay: true,
                            //looping:true,
                  ),
                ):Text(""),
              );
                
         
        
  }

}