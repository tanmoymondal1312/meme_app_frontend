import 'dart:convert';
import 'package:http/http.dart';

class FetchMeme {
  static Future<Map<String, String>?> fetchNewMeme() async {
    try {
      // Send the HTTP GET request
      Response response = await get(Uri.parse("http://192.168.0.105:8000/memes/api/image-urls/"));
      print('HTTP Response Status Code: ${response.statusCode}');  // Print the HTTP status code
      print('HTTP Response Body: ${response.body}');  // Print the raw response body

      // Check if the response status code indicates success
      if (response.statusCode == 200) {
        // Parse the JSON response body
        Map<String, dynamic> bodyData = jsonDecode(response.body);
        print('Parsed JSON Data: $bodyData');  // Print the parsed JSON data

        // Extract the image URL and meme name from the parsed data
        String? imageUrl = bodyData["image_url"];
        String memeName = bodyData["name"];
        print('Extracted Image URL: $imageUrl');  // Print the extracted image URL

        return {
          "imageUrl": imageUrl!,
          "memeName": memeName,
        };
      } else {
        print('Failed to load image URL');  // Print a failure message if the status code is not 200
        throw Exception('Failed to load image URL');
      }
    } catch (e) {
      print('Exception: $e');  // Print the exception message
      return null;
    }
  }
}
