class OnboardingItem {
  final String title;
  final String description;
  final String imagePath;
  final String? actionText;

  OnboardingItem({
    required this.title,
    required this.description,
    required this.imagePath,
    this.actionText,
  });
}
