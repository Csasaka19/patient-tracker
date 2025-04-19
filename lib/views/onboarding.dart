import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/models/onboarding_model.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/app_logo.dart';

class OnboardingController extends GetxController {
  final pageController = PageController();
  final currentPage = 0.obs;

  final List<OnboardingItem> items = [
    OnboardingItem(
      title: 'Welcome to Afya Yangu',
      description:
          'Your complete health companion that makes managing your health records simple and accessible.',
      imagePath: 'assets/onboarding/onboarding_1.jpg',
    ),
    OnboardingItem(
      title: 'Track Medical Records',
      description:
          'Keep all your medical history, prescriptions, and test results in one secure place.',
      imagePath: 'assets/onboarding/onboarding_2.jpg',
    ),
    OnboardingItem(
      title: 'Doctor Appointments',
      description:
          'Manage appointments with your healthcare providers and get timely reminders.',
      imagePath: 'assets/onboarding/onboarding_3.jpg',
    ),
    OnboardingItem(
      title: 'Medication Management',
      description: 'Never miss a dose with medication tracking and reminders.',
      imagePath: 'assets/onboarding/onboarding_1.jpg',
      actionText: 'Get Started',
    ),
  ];

  bool get isLastPage => currentPage.value == items.length - 1;

  void nextPage() {
    if (isLastPage) {
      Get.offAllNamed('/login');
    } else {
      pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void skip() {
    Get.offAllNamed('/login');
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}

class OnboardingView extends StatelessWidget {
  OnboardingView({Key? key}) : super(key: key);

  final OnboardingController controller = Get.put(OnboardingController());

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
        body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  AppLogo(
                    size: 40,
                    darkMode: isDarkMode,
                    showText: false,
                  ),
                  TextButton(
                    onPressed: controller.skip,
                    child: Text(
                      'Skip',
                      style: TextStyle(
                        color: isDarkMode
                            ? AppTheme.accentBlue
                            : AppTheme.primaryBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: controller.pageController,
                onPageChanged: (index) => controller.currentPage.value = index,
                itemCount: controller.items.length,
                itemBuilder: (context, index) {
                  return OnboardingPage(item: controller.items[index]);
                },
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 16.0),
                                child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Page indicator
                  Row(
                                  children: List.generate(
                      controller.items.length,
                                    (index) => Obx(() {
                        return Container(
                          margin: const EdgeInsets.only(right: 8),
                          width: controller.currentPage.value == index ? 20 : 8,
                          height: 8,
                                         decoration: BoxDecoration( 
                            color: controller.currentPage.value == index
                                ? (isDarkMode
                                    ? AppTheme.accentBlue
                                    : AppTheme.primaryBlue)
                                : Colors.grey.shade300,
                            borderRadius: BorderRadius.circular(4),
                                       ),
                                     );
                                    }),
                                  ),
                  ),
                  // Next button
                  Obx(() {
                    return ElevatedButton(
                      onPressed: controller.nextPage,
                      style: ElevatedButton.styleFrom(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 24, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: Text(
                        controller.isLastPage ? 'Get Started' : 'Next',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingPage extends StatelessWidget {
  final OnboardingItem item;

  const OnboardingPage({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 32),
          Expanded(
            flex: 2,
            child: Column(
              children: [
                Text(
                  item.title,
                  style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Text(
                  item.description,
                  style: Theme.of(context).textTheme.bodyLarge,
                  textAlign: TextAlign.center,
                ),
                if (item.actionText != null) ...[
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () => Get.offAllNamed('/login'),
                    child: Text(item.actionText!),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
