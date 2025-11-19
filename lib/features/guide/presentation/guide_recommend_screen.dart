import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/common/presentation/widgets/logo_header.dart';

class GuideRecommendScreen extends ConsumerWidget {
  const GuideRecommendScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final snacksAsync = ref.watch(snackListProvider);
    final instAsync = ref.watch(institutionListProvider);

    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const LogoHeader(title: '서로 및 간식 추천'),
            // 간식 추천 섹션
            _RecommendSection<SnackItem>(
              title: '서로 및 간식 추천',
              asyncValue: snacksAsync,
              itemBuilder: (item) => SnackCard(item: item),
            ),
            const SizedBox(height: 16),
            _RecommendSection<InstitutionItem>(
              title: '운동기관 추천',
              asyncValue: instAsync,
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
    required this.asyncValue,
    required this.itemBuilder,
  });

  final String title;
  final AsyncValue<List<T>> asyncValue;
  final Widget Function(T item) itemBuilder;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
          ),
        ),
        const SizedBox(height: 12),

        // AsyncValue 처리
        asyncValue.when(
          loading: () => const SizedBox(
            height: 120,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => SizedBox(
            height: 120,
            child: Center(child: Text('불러오지 못했어요')),
          ),
          data: (items) {
            if (items.isEmpty) {
              return SizedBox(
                height: 120,
                child: Center(child: Text('추천 항목이 없습니다')),
              );
            }

            return SizedBox(
              height: 140,
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  return itemBuilder(items[index]);
                },
              ),
            );
          },
        ),
      ],
    );
  }
}

class SnackCard extends StatelessWidget {
  const SnackCard({super.key, required this.item});

  final SnackItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
        boxShadow: const [
          BoxShadow(
            blurRadius: 4,
            color: Colors.black12,
            offset: Offset(0, 2),
          )
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // 이미지
          Container(
            height: 70,
            width: double.infinity,
            decoration: BoxDecoration(
              borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
              image: DecorationImage(
                image: NetworkImage(item.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 6),
          Text(
            item.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 2),
          Text(
            '${item.kcal} kcal',
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
          const SizedBox(height: 6),
        ],
      ),
    );
  }
}

class InstitutionCard extends StatelessWidget {
  const InstitutionCard({super.key, required this.item});

  final InstitutionItem item;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(color: Colors.black12),
      ),
      padding: const EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.location_on, size: 26, color: Colors.grey[700]),
          const SizedBox(height: 8),
          Text(
            item.name,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: 4),
          Text(
            item.type,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontSize: 11, color: Colors.grey),
          ),
        ],
      ),
    );
  }
}


