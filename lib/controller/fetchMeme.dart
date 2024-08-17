import 'dart:convert';
import 'dart:math';
import 'package:http/http.dart';

class FetchMeme {
  static Future<Map<String, String>?> fetchNewMeme() async {
    try {
      Response response = await get(Uri.parse("https://api.imgflip.com/get_memes"));
      if (response.statusCode == 200) {
        Map<String, dynamic> bodyData = jsonDecode(response.body);
        List<dynamic> memes = bodyData["data"]["memes"];
        if (memes.isNotEmpty) {
          Random random = Random();
          Map<String, dynamic> randomMeme = memes[random.nextInt(memes.length)];
          String imageUrl = randomMeme["url"];
          String memeName = randomMeme["name"];
          return {
            "imageUrl": imageUrl,
            "memeName": memeName,
          };
        } else {
          throw Exception('No memes found');
        }
      } else {
        throw Exception('Failed to load image URL');
      }
    } catch (e) {
      return null;
    }
  }
}
