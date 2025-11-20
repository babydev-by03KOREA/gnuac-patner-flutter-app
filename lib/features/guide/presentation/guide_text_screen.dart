import 'package:flutter/material.dart';
import 'package:patner_app/features/common/presentation/widgets/logo_header.dart';

class GuideTextScreen extends StatelessWidget {
  const GuideTextScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoHeader(),
            Card(
              color: Color(0xffC87D80),
              child: Padding(
                padding: const EdgeInsets.all(30),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "반려견을 위한\n산책 만보기 및\n건강상담 준비중",
                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 45,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
