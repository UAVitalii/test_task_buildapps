import 'dart:convert';
import 'dart:io';

import 'package:cronet_http/cronet_http.dart';
import 'package:cupertino_http/cupertino_http.dart';
import 'package:http/http.dart' as http;

import '../models/post.dart';

class PostRepository {
  final _client = _buildClient();

  static const _url = 'https://jsonplaceholder.typicode.com/posts';

  Future<List<Post>> getPosts() async {
    try {
      final response = await _client.get(Uri.parse(_url));

      if (response.statusCode != 200) {
        throw Exception('Server error (${response.statusCode}).');
      }

      final list = jsonDecode(response.body) as List<dynamic>;
      return list
          .map((e) => Post.fromJson(e as Map<String, dynamic>))
          .toList();
    } on SocketException {
      throw Exception('No internet connection.');
    } on FormatException {
      throw Exception('Failed to parse server response.');
    }
  }
}

http.Client _buildClient() {
  if (Platform.isAndroid) {
    return CronetClient.defaultCronetEngine();
  }
  if (Platform.isIOS || Platform.isMacOS) {
    return CupertinoClient.defaultSessionConfiguration();
  }
  return http.Client();
}
