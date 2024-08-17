import 'package:flutter/material.dart';

class splashScreen extends StatelessWidget {
  const splashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      backgroundColor: Colors.white,
        body: Column(
            mainAxisAlignment:MainAxisAlignment.center,
          children: [
            Image.network("https://raw.githubusercontent.com/tanmoymondal1312/resources/main/gettyimages-1289226280-1024x1024-removebg-preview.png"),
            const SizedBox(height: 20,),
            const Text("MEME HUB",style: TextStyle(fontSize: 50,fontWeight: FontWeight.bold),),
          ],
        )
    );
  }
}
