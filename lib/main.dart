import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'views/home_page.dart'; // Ensure this path is correct

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Supabase.initialize(
    url: 'https://sjcdcokcwoodlmftgkii.supabase.co',
    anonKey: 'sb_publishable_jFp7OiG-tHtqf9DFK0uXrQ__XfPbw6J',
  );
  runApp(const PasalubongApp());
}

class PasalubongApp extends StatelessWidget {
  const PasalubongApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(), // This should now work without 'const'
    );
  }
}