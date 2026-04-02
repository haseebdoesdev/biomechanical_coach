class Exercise {
  const Exercise({
    required this.id,
    required this.name,
    required this.category,
    required this.muscleGroup,
    required this.difficulty,
    required this.description,
    required this.referenceAngles,
    required this.imageUrl,
    required this.caloriesPerRep,
  });

  final String id;
  final String name;
  final String category;
  final String muscleGroup;
  final String difficulty;
  final String description;
  final Map<String, int> referenceAngles;
  final String imageUrl;
  final int caloriesPerRep;
}
