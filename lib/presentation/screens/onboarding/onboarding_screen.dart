import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_strings.dart';
import '../../../core/routing/app_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../widgets/custom_button.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<OnboardingData> _onboardingData = [
    const OnboardingData(
      title: 'جميع المفضلات لديك',
      description: 'اطلب من أفضل المطاعم المحلية\nمع التوصيل السهل والسريع.',
      icon: Icons.restaurant,
    ),
    const OnboardingData(
      title: 'عروض التوصيل المجاني',
      description:
          'توصيل مجاني للعملاء الجدد عبر Apple Pay\nوطرق الدفع الأخرى.',
      icon: Icons.local_offer,
    ),
    const OnboardingData(
      title: 'اختر طعامك',
      description:
          'ابحث بسهولة عن نوع الطعام الذي تشتهيه\nوستحصل على التوصيل في نطاق واسع.',
      icon: Icons.search,
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _onboardingData.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      context.go(AppRouter.signIn);
    }
  }

  void _skip() {
    context.go(AppRouter.home);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: _skip,
                    child: const Text(AppStrings.skip),
                  ),
                ],
              ),
            ),

            // Page view
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) {
                  final data = _onboardingData[index];
                  return Padding(
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: 200,
                          height: 200,
                          decoration: const BoxDecoration(
                            color: AppTheme.lightestGreen,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            data.icon,
                            size: 100,
                            color: AppTheme.primaryGreen,
                          ),
                        ),
                        const SizedBox(height: 48),
                        Text(
                          data.title,
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          data.description,
                          style:
                              Theme.of(context).textTheme.bodyLarge?.copyWith(
                                    color: Colors.grey[600],
                                  ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            // Page indicators
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                _onboardingData.length,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: _currentPage == index ? 24 : 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: _currentPage == index
                        ? AppTheme.primaryGreen
                        : AppTheme.grey300,
                    borderRadius: BorderRadius.circular(AppTheme.radiusS),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Get started button
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: CustomButton(
                text: AppStrings.getStarted,
                onPressed: _nextPage,
              ),
            ),

            const SizedBox(height: 32),

            // Change User Type Button
            TextButton(
              onPressed: () => context.go(AppRouter.userTypeSelection),
              child: Text(
                AppStrings.changeUserType,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: AppTheme.primaryGreen,
                      fontWeight: FontWeight.w600,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class OnboardingData {
  final String title;
  final String description;
  final IconData icon;

  const OnboardingData({
    required this.title,
    required this.description,
    required this.icon,
  });
}
