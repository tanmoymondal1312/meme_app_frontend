import 'package:flutter/material.dart';
import 'package:your_memes/controller/fetchMeme.dart';
import 'package:your_memes/controller/saveMyData.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  String imgname = "";
  String imgurl = "";
  int? memeNo;
  bool isLoading = true;
  int target_meme = 200;

  @override
  void initState() {
    super.initState();
    UpdateImage(); // Load initial meme when the screen is initialized
    GetInitMemeNo();
  }

  Future<void> GetInitMemeNo() async {
    memeNo = await SaveMyData.fetchData() ?? 0;
    if(memeNo! >=200){
      target_meme = 300;
    }
    if(memeNo! >=300){
      target_meme = 500;
    }
    setState(() {});
  }

  Future<void> UpdateImage() async {
    setState(() {
      isLoading = true; // Start loading
    });
    var newmeme = await FetchMeme.fetchNewMeme();
    if (newmeme != null) {
      setState(() {
        imgurl = newmeme["imageUrl"] ?? "";
        imgname = newmeme["memeName"] ?? "";
        isLoading = false; // End loading
      });
    } else {
      setState(() {
        isLoading = false; // End loading even if there is no new meme
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 90,
            ),
            Text(
              'Current memeNo: ${memeNo ?? "Not Set"}',
              style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w600),
            ),
            const SizedBox(
              height: 1,
            ),
             Text(
              'TARGET: ${target_meme} MEME',
              style: TextStyle(fontSize: 18, color: Color(0xFFC371FF)),
            ),
            const SizedBox(
              height: 30,
            ),
            SizedBox(
              width: 400,
              height: 400,
              child: isLoading
                  ? const Center(
                child: CircularProgressIndicator(), // Show loading indicator
              )
                  : Image.network(
                imgurl,
                fit: BoxFit.contain,
                loadingBuilder: (context, child, loadingProgress) {
                  if (loadingProgress == null) return child;
                  return const Center(
                    child: CircularProgressIndicator(), // Show loading indicator while image loads
                  );
                },
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                await UpdateImage(); // Ensure UpdateImage completes before proceeding
                if (memeNo != null) {
                  print("Current memeNo: $memeNo");

                  // Increment memeNo and save
                  int newMemeNo = memeNo! + 1;
                  bool isSaved = await SaveMyData.saveData(newMemeNo);

                  await GetInitMemeNo(); // Ensure this is awaited
                }
              },
              child: const SizedBox(
                height: 50,
                width: 150,
                child: Center(
                  child: Text(
                    "More Fun!!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
              ),
            ),
            const Spacer(),
            const Text("APP CREATED BY"),
            const Text(
              "TANMOY MONDAL",
              style: TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w800,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}
