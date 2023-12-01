import 'package:flutter_riverpod/flutter_riverpod.dart';

//GPTからのレスポンスを受け取るためにproviderを使う

final sentenceResponseProvider = StateProvider<String?>((ref) => null);
