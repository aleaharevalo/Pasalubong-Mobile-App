import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'views/get_started_page.dart'; // Import your new page

Future<void> main() async {
  // 1. Ensure Flutter bindings are initialized
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Initialize Supabase with your project details
  await Supabase.initialize(
    url: 'https://sjcdcokcwoodlmftgkii.supabase.co',
    anonKey: 'sb_publishable_jFp7OiG-tHtqf9DFK0uXrQ__XfPbw6J',
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pasalubong',
      theme: ThemeData(
        useMaterial3: true,
        // You can set global font styles here if you like
      ),
      // 3. Set the GetStartedPage as the very first screen
      home: const GetStartedPage(),
    );
  }
}