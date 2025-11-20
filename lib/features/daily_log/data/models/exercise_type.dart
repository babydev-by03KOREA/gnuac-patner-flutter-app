enum ExerciseType {
  boldExplorer,   // 용감한 활동가형
  shyExplorer,    // 소심 탐험가형
}

extension ExerciseTypeInfo on ExerciseType {
  String get label {
    switch (this) {
      case ExerciseType.boldExplorer:
        return "용감한 활동가형";
      case ExerciseType.shyExplorer:
        return "소심 탐험가형";
    }
  }

  String get recommend {
    switch (this) {
      case ExerciseType.boldExplorer:
        return "어질리티 코스(장애물 넘기, 터널 통과), 하이킹·트래킹, 수영을 시도해보세요!";
      case ExerciseType.shyExplorer:
        return "슬로우 산책, 실내 터그놀이, 노즈워크 간식찾기, 마사지·교감 시간을 시도해보세요!";
    }
  }

  static ExerciseType fromName(String? name) {
    if (name == null) return ExerciseType.boldExplorer;
    return ExerciseType.values.firstWhere(
          (e) => e.name == name,
      orElse: () => ExerciseType.boldExplorer,
    );
  }
}
