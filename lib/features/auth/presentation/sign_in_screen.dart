import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/app/theme.dart';
import '../../../app/router.dart';
import '../application/auth_controller.dart';
import 'package:go_router/go_router.dart';

class SignInScreen extends ConsumerStatefulWidget {
  const SignInScreen({super.key});
  @override
  ConsumerState<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignInScreen> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _pw = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(authControllerProvider);
    return GradientScaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 420),
          child: Form(
            key: _formKey,
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              TextFormField(
                controller: _email,
                decoration: const InputDecoration(labelText: '이메일'),
                validator: (v) => (v?.contains('@') ?? false) ? null : '이메일 형식',
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _pw,
                decoration: const InputDecoration(labelText: '비밀번호'),
                obscureText: true,
                validator: (v) => (v != null && v.length >= 6) ? null : '6자 이상',
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: state.loading ? null : () async {
                  if (!_formKey.currentState!.validate()) return;
                  final ok = await ref.read(authControllerProvider.notifier)
                      .signIn(_email.text.trim(), _pw.text);
                  if (ok && context.mounted) context.go('/home');
                },
                child: state.loading ? const CircularProgressIndicator() : const Text('로그인'),
              ),
              TextButton(
                onPressed: () => context.push('/sign-up'),
                child: const Text('회원가입'),
              ),
              if (state.error != null) Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(state.error!, style: const TextStyle(color: Colors.red)),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
