// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

Future<String?> shortenUrl({required String url}) async {
  try {
    final result = await http.post(
        Uri.parse(
          'https://cleanuri.com/api/v1/shorten',
        ),
        body: {'url': url});

    if (result.statusCode == 200) {
      final jsonResult = jsonDecode(result.body);
      return jsonResult['result_url'];
    }
  } catch (e) {
    if (kDebugMode) {
      print(e.toString());
    }
  }
  return null;
}
