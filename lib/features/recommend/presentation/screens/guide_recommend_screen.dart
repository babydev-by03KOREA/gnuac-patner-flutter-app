import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/common/presentation/widgets/logo_header.dart';
import 'package:patner_app/features/recommend/data/recommend_providers.dart';
import 'package:patner_app/features/recommend/domain/institution_item.dart';
import 'package:patner_app/features/recommend/domain/snack_item.dart';
import 'package:patner_app/features/recommend/presentation/widgets/insitution_card_widget.dart';
import 'package:patner_app/features/recommend/presentation/widgets/snack_card_widget.dart';

class GuideRecommendScreen extends ConsumerWidget {
  const GuideRecommendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snacks = ref.watch(snackListProvider);
    final institutions = ref.watch(institutionListProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoHeader(title: '사료 및 간식 추천'),
            // 간식 추천 섹션
            _RecommendSection<SnackItem>(
              title: '사료 및 간식 추천',
              items: snacks,
              itemBuilder: (item) => SnackCard(item: item),
            ),
            const SizedBox(height: 16),
            _RecommendSection<InstitutionItem>(
              title: '운동기관 추천',
              items: institutions,
              itemBuilder: (item) => InstitutionCard(item: item),
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendSection<T> extends StatelessWidget {
  const _RecommendSection({
    super.key,
    required this.title,
    required this.items,
    required this.itemBuilder,
  });

  final String title;
  final List<T> items;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w800),
        ),
        const SizedBox(height: 12),

        if (items.isEmpty)
          const SizedBox(height: 120, child: Center(child: Text('항목이 없습니다')))
        else
          SizedBox(
            height: 140,
            child: ListView.separated(
              scrollDirection: Axis.horizontal,
              itemCount: items.length,
              separatorBuilder: (_, __) => const SizedBox(width: 12),
              itemBuilder: (context, index) {
                return itemBuilder(items[index]);
              },
            ),
          ),
      ],
    );
  }
}
