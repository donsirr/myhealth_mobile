import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import '../providers/stroke_timer_provider.dart';

class CustomScaffold extends StatelessWidget {
  final Widget child;
  final String currentRoute;

  const CustomScaffold({
    super.key,
    required this.child,
    required this.currentRoute,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      body: Stack(
        children: [
          // Main content with proper bottom padding for dock
          SafeArea(
            bottom: false, // Don't use system bottom padding
            child: Padding(
              padding:
                  const EdgeInsets.only(bottom: 100), // Reserve space for dock
              child: child,
            ),
          ),

          // Stroke Timer Toast (only show when NOT on stroke page)
          Consumer<StrokeTimerProvider>(
            builder: (context, timerProvider, _) {
              if (!timerProvider.isActive ||
                  currentRoute == '/identify/stroke') {
                return const SizedBox.shrink();
              }

              return Positioned(
                bottom: 100, // Above the nav dock
                right: 16,
                child: _buildTimerToast(context, timerProvider),
              );
            },
          ),

          // Glass Floating Dock (Bottom Navigation)
          Positioned(
            left: 16,
            right: 16,
            bottom: 16,
            child: _buildFloatingDock(context),
          ),
        ],
      ),
    );
  }

  /// Stroke Timer Toast (Bottom-right floating widget)
  Widget _buildTimerToast(BuildContext context, StrokeTimerProvider provider) {
    return Material(
      elevation: 8,
      borderRadius: BorderRadius.circular(20),
      shadowColor: Colors.red.withValues(alpha: 0.4),
      child: Container(
        width: 280,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: const Color(0xFFDC2626),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              children: [
                const Icon(
                  LucideIcons.clock,
                  color: Colors.white,
                  size: 40,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'SYMPTOM DETECTED',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              fontSize: 10,
                              letterSpacing: 1.2,
                            ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        provider.formattedTime,
                        style:
                            Theme.of(context).textTheme.displayLarge?.copyWith(
                                  color: Colors.white,
                                  fontSize: 36,
                                  height: 1,
                                ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () => provider.stopTimer(),
                  icon: const Icon(
                    LucideIcons.x,
                    color: Colors.white,
                    size: 20,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Text(
              'Call (054) 473-2326 or 911 immediately!',
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w600,
                    fontSize: 12,
                  ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }

  /// Glass Floating Dock (Beautiful Glassmorphism Nav)
  Widget _buildFloatingDock(BuildContext context) {
    final items = [
      _NavItem(icon: LucideIcons.home, label: 'Home', route: '/'),
      _NavItem(icon: LucideIcons.heartPulse, label: 'Health', route: '/cvd'),
      _NavItem(icon: LucideIcons.siren, label: 'Emergency', route: '/identify'),
      _NavItem(
          icon: LucideIcons.creditCard, label: 'Passport', route: '/passport'),
    ];

    return Container(
      height: 72,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.8),
        borderRadius: BorderRadius.circular(28),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.5),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(28),
        child: BackdropFilter(
          filter: ColorFilter.mode(
            Colors.white.withValues(alpha: 0.5),
            BlendMode.srcOver,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: items.map((item) {
              final isActive = currentRoute == item.route ||
                  (item.route == '/identify' &&
                      currentRoute.startsWith('/identify'));

              return _buildNavButton(
                context,
                item: item,
                isActive: isActive,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }

  Widget _buildNavButton(
    BuildContext context, {
    required _NavItem item,
    required bool isActive,
  }) {
    return InkWell(
      onTap: () => context.go(item.route),
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              item.icon,
              size: 24,
              color:
                  isActive ? const Color(0xFF0EA5E9) : const Color(0xFF94A3B8),
            ),
            const SizedBox(height: 4),
            Text(
              item.label,
              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                    fontSize: 11,
                    fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                    color: isActive
                        ? const Color(0xFF0EA5E9)
                        : const Color(0xFF94A3B8),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}

class _NavItem {
  final IconData icon;
  final String label;
  final String route;

  _NavItem({
    required this.icon,
    required this.label,
    required this.route,
  });
}
