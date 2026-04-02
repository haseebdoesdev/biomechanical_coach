class UserProfile {
  const UserProfile({
    required this.name,
    required this.age,
    required this.heightCm,
    required this.weightKg,
    required this.fitnessLevel,
    required this.goals,
    this.profileImageUrl,
  });

  final String name;
  final int age;
  final int heightCm;
  final int weightKg;
  final String fitnessLevel;
  final List<String> goals;
  final String? profileImageUrl;

  UserProfile copyWith({
    String? name,
    int? age,
    int? heightCm,
    int? weightKg,
    String? fitnessLevel,
    List<String>? goals,
    String? profileImageUrl,
  }) {
    return UserProfile(
      name: name ?? this.name,
      age: age ?? this.age,
      heightCm: heightCm ?? this.heightCm,
      weightKg: weightKg ?? this.weightKg,
      fitnessLevel: fitnessLevel ?? this.fitnessLevel,
      goals: goals ?? this.goals,
      profileImageUrl: profileImageUrl ?? this.profileImageUrl,
    );
  }
}
