import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/auth_provider.dart';

class TestLoginScreen extends ConsumerStatefulWidget {
  const TestLoginScreen({super.key});

  @override
  ConsumerState<TestLoginScreen> createState() => _TestLoginScreenState();
}

class _TestLoginScreenState extends ConsumerState<TestLoginScreen> {
  bool _isLoggedIn = false;
  String _message = 'Not logged in';

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Test Login')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Test Email Field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Email',
                border: OutlineInputBorder(),
              ),
              onChanged: (value) {
                // Store email
              },
            ),
            const SizedBox(height: 16),

            // Test Password Field
            TextField(
              decoration: const InputDecoration(
                labelText: 'Password',
                border: OutlineInputBorder(),
              ),
              obscureText: true,
              onChanged: (value) {
                // Store password
              },
            ),
            const SizedBox(height: 24),

            // Status Display
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: authState.isAuthenticated
                    ? Colors.green.shade50
                    : Colors.grey.shade50,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                children: [
                  Text(
                    authState.isAuthenticated
                        ? '✅ Logged in successfully!'
                        : '🔴 Not logged in',
                    style: TextStyle(
                      color: authState.isAuthenticated
                          ? Colors.green
                          : Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (authState.userData != null) ...[
                    const SizedBox(height: 8),
                    Text('User: ${authState.userData!.user.email}'),
                  ],
                  if (authState.error != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Error: ${authState.error}',
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                  if (authState.isLoading) ...[
                    const SizedBox(height: 8),
                    const CircularProgressIndicator(),
                  ],
                ],
              ),
            ),
            const SizedBox(height: 24),

            // Login Button (temporary - hardcoded credentials)
            ElevatedButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      // Replace with your test credentials
                      ref
                          .read(authProvider.notifier)
                          .login(
                            'test@example.com', // Replace with test email
                            'password123', // Replace with test password
                          );
                    },
              child: const Text('Test Login'),
            ),

            const SizedBox(height: 12),

            // Logout Button
            ElevatedButton(
              onPressed: authState.isLoading
                  ? null
                  : () {
                      ref.read(authProvider.notifier).logout();
                    },
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
              child: const Text('Logout'),
            ),
          ],
        ),
      ),
    );
  }
}
