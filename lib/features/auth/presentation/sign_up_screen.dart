import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:patner_app/app/theme.dart';
import 'package:patner_app/features/auth/application/auth_controller.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  // 반려인 정보
  final _idController = TextEditingController();
  final _pwController = TextEditingController();

  // 반려동물 정보
  final _petNameController = TextEditingController();
  final _petSpeciesController = TextEditingController();
  final _petWeightController = TextEditingController();
  final _petFatController = TextEditingController();

  bool get _isFormValid => _formKey.currentState?.validate() ?? false;

  @override
  void dispose() {
    _idController.dispose();
    _pwController.dispose();
    _petNameController.dispose();
    _petSpeciesController.dispose();
    _petWeightController.dispose();
    _petFatController.dispose();
    super.dispose();
  }

  Future<void> _onSubmit() async {
    if (!_formKey.currentState!.validate()) return;

    final notifier = ref.read(authControllerProvider.notifier);

    final ok = await notifier.signUp(
      _idController.text.trim(),
      _pwController.text,
      meta: {
        'pet_name': _petNameController.text.trim(),
        'pet_species': _petSpeciesController.text.trim(),
        'pet_weight': _petWeightController.text.trim(),
        'pet_fat_per_day': _petFatController.text.trim(),
      },
    );

    if (!mounted) return;

    final state = ref.read(authControllerProvider);
    if (!ok) {
      debugPrint(state.error);
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(state.error ?? '회원가입에 실패했어요')));
      return;
    }

    context.go('/home');
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authControllerProvider);

    return GradientScaffold(
      appBar: null,
      extendBodyBehindAppBar: false,
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // 로고
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset("assets/logo.jpg", width: 50, height: 50),
                      ],
                    ),
                    // 회원가입 타이틀
                    const Text(
                      '회원가입',
                      style: TextStyle(
                        fontSize: 26,
                        fontWeight: FontWeight.w800,
                        color: Colors.black,
                      ),
                    ),

                    // 반려인 정보 섹션
                    const Text(
                      '반려인 정보',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _idController,
                            decoration: const InputDecoration(
                              labelText: '이메일',
                              hintText: '이메일 주소',
                            ),
                            keyboardType: TextInputType.emailAddress,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return '이메일를 입력해 주세요';
                              }
                              if (!v.contains('@')) {
                                return '이메일 형식이 아니에요';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _pwController,
                            decoration: const InputDecoration(
                              labelText: '비밀번호',
                            ),
                            obscureText: true,
                            validator: (v) {
                              if (v == null || v.isEmpty) {
                                return '비밀번호를 입력해 주세요';
                              }
                              if (v.length < 6) {
                                return '6자 이상 입력해 주세요';
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // 반려동물 정보 섹션
                    const Text(
                      '반려동물 정보',
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 16,
                        vertical: 14,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.95),
                        borderRadius: BorderRadius.circular(22),
                      ),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _petNameController,
                            decoration: const InputDecoration(labelText: '이름'),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _petSpeciesController,
                            decoration: const InputDecoration(
                              labelText: '종 (예: 강아지, 고양이)',
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _petWeightController,
                            decoration: const InputDecoration(
                              labelText: '몸무게 (kg)',
                            ),
                            keyboardType: const TextInputType.numberWithOptions(
                              decimal: true,
                            ),
                          ),
                          const SizedBox(height: 12),
                          TextFormField(
                            controller: _petFatController,
                            decoration: const InputDecoration(
                              labelText: '비만도 (%)',
                            ),
                            keyboardType: TextInputType.number,
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // 회원가입 버튼
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: authState.loading
                            ? null
                            : () async {
                                // 눌렀을 때 한 번 더 validate
                                if (_formKey.currentState?.validate() ??
                                    false) {
                                  await _onSubmit();
                                }
                              },
                        style: ElevatedButton.styleFrom(
                          minimumSize: const Size.fromHeight(52),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(26),
                          ),
                          // 스케치처럼 연한 회색 느낌을 내고 싶으면 상태에 따라 조절
                          backgroundColor: _isFormValid && !authState.loading
                              ? AppColors.primary
                              : const Color(0xFFE0E0E0),
                          foregroundColor: _isFormValid && !authState.loading
                              ? Colors.white
                              : Colors.black.withOpacity(0.4),
                          elevation: 0,
                        ),
                        child: authState.loading
                            ? const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator(
                                  strokeWidth: 2,
                                ),
                              )
                            : const Text(
                                '회원가입',
                                style: TextStyle(
                                  fontWeight: FontWeight.w700,
                                  fontSize: 16,
                                ),
                              ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    // 이미 계정이 있다면
                    Align(
                      alignment: Alignment.center,
                      child: TextButton(
                        onPressed: () => context.go('/sign-in'),
                        child: const Text('이미 계정이 있으신가요? 로그인'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
