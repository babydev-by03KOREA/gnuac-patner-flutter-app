import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:patner_app/features/recommend/domain/institution_item.dart';
import 'package:patner_app/features/recommend/domain/snack_item.dart';

final snackListProvider = Provider<List<SnackItem>>((ref) {
  return [
    SnackItem(
      id: 1,
      title: '고구마 스낵',
      imageUrl: 'assets/dogfood_sweetpotato.jpg',
    ),
    SnackItem(id: 2, title: '연어 스낵', imageUrl: 'assets/dogfood_salmon.jpg'),
    SnackItem(id: 3, title: '단호박 스낵', imageUrl: 'assets/dogfood_pumpkin.png'),
  ];
});

final institutionListProvider = Provider<List<InstitutionItem>>((ref) {
  return [
    InstitutionItem(
      id: 1,
      name: '멍멍 훈련소',
      imageUrl: 'assets/dog_trainingcenter.jpg',
    ),
    InstitutionItem(
      id: 2,
      name: '해피 동물병원',
      imageUrl: 'assets/animal_hospital.png',
    ),
    InstitutionItem(
      id: 3,
      name: '애견 유치원',
      imageUrl: 'assets/pet_kindergarden.png',
    ),
  ];
});
