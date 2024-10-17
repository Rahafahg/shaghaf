import 'package:get_it/get_it.dart';
import 'package:shaghaf/data_layer/auth_layer.dart';
import 'package:shaghaf/data_layer/supabase_layer.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Future<void> setup() async {
  await GetStorage.init();
  await dotenv.load();
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON']!
  );
  GetIt.I.registerSingleton<AuthLayer>(AuthLayer());
  GetIt.I.registerSingleton<SupabaseLayer>(SupabaseLayer());
}