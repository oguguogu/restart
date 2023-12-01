import 'dart:math';
import 'package:flash_card/domain/models/word.dart';

List<Word> getRandomWords(List<Word> wordList, int count) {
  // リストのコピーを作成（元のリストを変更しないように）
  List<Word> shuffledList = List<Word>.from(wordList);

  // リストをシャッフル
  shuffledList.shuffle(Random());

  // 最初の`count`要素を取得（ここでは5つ）
  return shuffledList.take(count).toList();
}
