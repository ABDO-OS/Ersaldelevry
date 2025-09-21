import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class UserTypeSlider extends StatefulWidget {
  final int selectedIndex;
  final ValueChanged<int> onChanged;
  final List<String> userTypes;

  const UserTypeSlider({
    super.key,
    required this.selectedIndex,
    required this.onChanged,
    required this.userTypes,
  });

  @override
  State<UserTypeSlider> createState() => _UserTypeSliderState();
}

class _UserTypeSliderState extends State<UserTypeSlider>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    ));
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(AppTheme.radiusL),
        boxShadow: AppTheme.cardShadow,
      ),
      child: Row(
        children: List.generate(
          widget.userTypes.length,
          (index) => Expanded(
            child: GestureDetector(
              onTap: () => widget.onChanged(index),
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                decoration: BoxDecoration(
                  color: widget.selectedIndex == index
                      ? AppTheme.primaryGreen
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(AppTheme.radiusL),
                ),
                child: Center(
                  child: AnimatedDefaultTextStyle(
                    duration: const Duration(milliseconds: 300),
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: widget.selectedIndex == index
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: widget.selectedIndex == index
                          ? AppTheme.white
                          : AppTheme.textSecondary,
                    ),
                    child: Text(
                      widget.userTypes[index],
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
