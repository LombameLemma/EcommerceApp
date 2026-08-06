import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Provider
final appNameProvider = Provider<String>((ref) {
  return 'E-Commerce App';
});

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final appName = ref.watch(appNameProvider);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: appName,
      home: Scaffold(
        appBar: AppBar(title: Text(appName), centerTitle: true),
        body: Center(
          child: Text(
            appName,
            style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
        ),
      ),
    );
  }
}
