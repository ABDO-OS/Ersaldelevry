import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/routing/app_router.dart';

import '../../components/dot_indicators.dart';
import 'components/onboard_content.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            // Skip button in top right
            Padding(
              padding: const EdgeInsets.all(AppConstants.defaultPadding),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () {
                      // Skip to home screen directly
                      context.go(AppRouter.home);
                    },
                    child: const Text(
                      "تخطي",
                      style: TextStyle(
                        color: Color(0xFFffc8dd),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Expanded(
              flex: 14,
              child: PageView.builder(
                itemCount: demoData.length,
                onPageChanged: (value) {
                  setState(() {
                    currentPage = value;
                  });
                },
                itemBuilder: (context, index) => OnboardContent(
                  illustration: demoData[index]["illustration"],
                  title: demoData[index]["title"],
                  text: demoData[index]["text"],
                ),
              ),
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                demoData.length,
                (index) => DotIndicator(isActive: index == currentPage),
              ),
            ),
            const Spacer(flex: 2),
            Padding(
              padding: const EdgeInsets.symmetric(
                  horizontal: AppConstants.defaultPadding),
              child: ElevatedButton(
                onPressed: () {
                  // Go to sign in screen
                  context.go(AppRouter.signIn);
                },
                child: Text("ابدأ الآن".toUpperCase()),
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}

// Demo data for our Onboarding screen
List<Map<String, dynamic>> demoData = [
  {
    "illustration": "",
    "title": "جميع المفضلات لديك",
    "text": "اطلب من أفضل المطاعم المحلية \nمع التوصيل السهل والسريع.",
  },
  {
    "illustration": "",
    "title": "عروض التوصيل المجاني",
    "text": "توصيل مجاني للعملاء الجدد عبر Apple Pay\nوطرق الدفع الأخرى.",
  },
  {
    "illustration": "",
    "title": "اختر طعامك",
    "text":
        "ابحث بسهولة عن نوع الطعام الذي تشتهيه\nوستحصل على التوصيل في نطاق واسع.",
  },
];
