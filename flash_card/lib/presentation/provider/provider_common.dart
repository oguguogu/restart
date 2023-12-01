import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flash_card/presentation/widgets/in_flashcard/coponents/colorful_check_marks.dart';

//カードのマークを管理
final memorizedTypeProviderFamily =
    StateProvider.family<MemorizedType?, int>((ref, idKey) => null);

//filterの番号を管理
final filteredNumProvider = StateProvider<int>((ref) => 0);
