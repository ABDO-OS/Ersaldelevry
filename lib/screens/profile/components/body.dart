import 'package:flutter/material.dart';
import 'package:foodly_ui/constants.dart';
import 'package:foodly_ui/screens/auth/sign_in_screen.dart';
import 'package:foodly_ui/screens/profile/order_history_screen.dart';

class Body extends StatelessWidget {
  const Body({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: defaultPadding),
              Text("إعدادات الحساب",
                  style: Theme.of(context).textTheme.headlineMedium),
              Text(
                "قم بتحديث تفاصيل طلبك.",
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 16),
              ProfileMenuCard(
                icon: Icons.shopping_cart,
                title: "تاريخ طلباتك",
                subTitle: "تتبع حالة توصيل الطعام.",
                press: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const OrderHistoryScreen(),
                    ),
                  );
                },
              ),
              ProfileMenuCard(
                icon: Icons.logout,
                title: "تسجيل الخروج",
                subTitle: "انقر هنا عندما تريد تسجيل الخروج",
                press: () async {
                  // TODO: Implement sign out logic

                  if (!context.mounted) return;
                  Route route = MaterialPageRoute(
                      builder: (context) => const SignInScreen());
                  Navigator.pushReplacement(context, route);
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileMenuCard extends StatelessWidget {
  const ProfileMenuCard({
    super.key,
    this.title,
    this.subTitle,
    this.icon,
    this.press,
  });

  final String? title, subTitle;
  final IconData? icon;
  final VoidCallback? press;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: defaultPadding / 2),
      child: InkWell(
        borderRadius: const BorderRadius.all(Radius.circular(8)),
        onTap: press,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 5),
          child: Row(
            children: [
              Icon(
                icon!,
                size: 24,
                color: titleColor.withOpacity(0.64),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title!,
                      maxLines: 1,
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      subTitle!,
                      maxLines: 1,
                      style: TextStyle(
                        fontSize: 14,
                        color: titleColor.withOpacity(0.54),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 20,
              )
            ],
          ),
        ),
      ),
    );
  }
}
