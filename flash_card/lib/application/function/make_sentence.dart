import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:http/http.dart' as http;
import 'package:flash_card/secret.dart';
import 'package:flash_card/presentation/provider/provider_sentence.dart';

Future<void> makeSentence(BuildContext context, WidgetRef ref, String word1,
    String word2, String word3, String word4, String word5) async {
  try {
    final response = await http
        .post(
          Uri.parse('https://api.openai.com/v1/chat/completions'),
          headers: {
            'Authorization': 'Bearer $key',
            'Content-Type': 'application/json',
          },
          body: jsonEncode({
            "model": sentenceCreateModel,
            "messages": [
              {"role": "system", "content": sentenceCreateSystem},
              {
                "role": "user",
                "content": "word1, word2, word3, word4, word5",
              }
            ],
          }),
        )
        .timeout(const Duration(seconds: 18));

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(utf8.decode(response.body.codeUnits))
          as Map<String, dynamic>;
      final content = (jsonResponse['choices'] as List).first['message']
          ['content'] as String;
      // Update the state using the provider
      ref.read(sentenceResponseProvider.notifier).state = content;
    } else {
      // Handle the error or set an error message
      ref.read(sentenceResponseProvider.notifier).state =
          "Error: ${response.statusCode}";
      // ref.read(errorGptProvider.notifier).state = true;
    }
  } on TimeoutException catch (_) {
    // タイムアウトエラーの処理
    ref.read(sentenceResponseProvider.notifier).state =
        "Error: Request timed out";
    // ref.read(errorGptProvider.notifier).state = true;
  } catch (e) {
    // Handle the error or set an error message
    ref.read(sentenceResponseProvider.notifier).state = "Error: $e";
    // ref.read(errorGptProvider.notifier).state = true;
  }
}
