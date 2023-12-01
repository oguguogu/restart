import 'package:device_preview/device_preview.dart';
import 'package:flash_card/infrastructure/database/sqflite_db.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flash_card/presentation/router/app.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flash_card/secret.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();

  // await Supabase.initialize(
  //   url: supabaseURL,
  //   anonKey: supabaseAnonKey,
  // );

  const app = App();
  const scope = ProviderScope(child: app);
  // FFIの初期化
  sqfliteFfiInit();

  // databaseFactoryをdatabaseFactoryFfiに設定
  databaseFactory = databaseFactoryFfi;

  await createDb();

  if (kIsWeb) {
    final preview = DevicePreview(
      enabled: true,
      builder: (context) => scope,
    );
    runApp(preview);
  } else {
    runApp(scope);
  }
}
