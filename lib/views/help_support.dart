import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:patient_tracker/core/theme/app_theme.dart';
import 'package:patient_tracker/widgets/common/theme_switch.dart';

class HelpSupportPage extends StatelessWidget {
  const HelpSupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Help & Support'),
        actions: const [
          Padding(
            padding: EdgeInsets.only(right: 16.0),
            child: ThemeSwitchIcon(),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _buildSectionCard(
            context,
            title: 'Frequently Asked Questions',
            icon: Icons.question_answer_outlined,
            color: AppTheme.primaryBlue,
            children: [
              _buildFaqItem(
                context,
                question: 'How do I add a new medical record?',
                answer:
                    'Currently, medical records are provided by your healthcare provider. In a future update, you\'ll be able to manually add records.',
              ),
              _buildFaqItem(
                context,
                question: 'How can I schedule an appointment?',
                answer:
                    'You can schedule appointments by visiting the Doctors page, selecting a doctor, and using the "Schedule" button.',
              ),
              _buildFaqItem(
                context,
                question: 'Is my data secure?',
                answer:
                    'Yes, we use industry-standard encryption to protect your health data. Your information is never shared without your consent.',
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title: 'Contact Support',
            icon: Icons.support_agent_outlined,
            color: AppTheme.secondaryGreen,
            children: [
              ListTile(
                leading: const Icon(Icons.email_outlined),
                title: const Text('Email Support'),
                subtitle: const Text('support@afyayangu.com'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Get.snackbar(
                      'Contact Support',
                      'Email feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.phone_outlined),
                title: const Text('Phone Support'),
                subtitle: const Text('+ 254 076545678'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Get.snackbar(
                      'Contact Support',
                      'Call feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
              ListTile(
                leading: const Icon(Icons.chat_outlined),
                title: const Text('Live Chat'),
                subtitle: const Text('Available 24/7'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Get.snackbar(
                      'Contact Support',
                      'Live chat feature coming soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 20),
          _buildSectionCard(
            context,
            title: 'App Information',
            icon: Icons.info_outline,
            color: Colors.purple,
            children: [
              const ListTile(
                title:  Text('App Version'),
                subtitle:  Text('2.0.0'),
              ),
              ListTile(
                title: const Text('Terms of Service'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Get.snackbar(
                      'Terms of Service',
                      'This feature will be available soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
              ListTile(
                title: const Text('Privacy Policy'),
                trailing: IconButton(
                  icon: const Icon(Icons.arrow_forward_ios, size: 16),
                  onPressed: () {
                    Get.snackbar(
                      'Privacy Policy',
                      'This feature will be available soon',
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSectionCard(
    BuildContext context, {
    required String title,
    required IconData icon,
    required Color color,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Icon(
                    icon,
                    color: color,
                  ),
                ),
                const SizedBox(width: 16),
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          ...children,
        ],
      ),
    );
  }

  Widget _buildFaqItem(
    BuildContext context, {
    required String question,
    required String answer,
  }) {
    return ExpansionTile(
      title: Text(
        question,
        style: Theme.of(context).textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.w500,
            ),
      ),
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
          child: Text(
            answer,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ),
      ],
    );
  }
}
