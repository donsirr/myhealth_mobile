import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'widgets/custom_scaffold.dart';
import 'screens/home_screen.dart';
import 'screens/cvd_screen.dart';
import 'screens/dengue_screen.dart';
import 'screens/identify_hub_screen.dart';
import 'screens/stroke_screen.dart';
import 'screens/heart_attack_screen.dart';
import 'screens/dengue_identify_screen.dart';
import 'screens/child_emergency_screen.dart';
import 'screens/passport_screen.dart';
import 'screens/roadmap_screen.dart';
import 'screens/screening_screen.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    ShellRoute(
      pageBuilder: (context, state, child) {
        return CustomTransitionPage(
          key: state.pageKey,
          child: CustomScaffold(
            currentRoute: state.uri.path,
            child: child,
          ),
          transitionsBuilder: (context, animation, secondaryAnimation, widget) {
            // Smooth scale + fade transition
            const begin = 0.94;
            const end = 1.0;
            const curve = Curves.easeInOutCubicEmphasized;

            final scaleTween = Tween(begin: begin, end: end).chain(
              CurveTween(curve: curve),
            );
            final fadeTween = Tween(begin: 0.0, end: 1.0).chain(
              CurveTween(curve: curve),
            );

            return FadeTransition(
              opacity: animation.drive(fadeTween),
              child: ScaleTransition(
                scale: animation.drive(scaleTween),
                child: widget,
              ),
            );
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 250),
        );
      },
      routes: [
        // Home Screen
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),

        // CVD Risk Calculator
        GoRoute(
          path: '/cvd',
          builder: (context, state) => const CvdScreen(),
        ),

        // Dengue Map
        GoRoute(
          path: '/dengue',
          builder: (context, state) => const DengueScreen(),
        ),

        // Identification Hub
        GoRoute(
          path: '/identify',
          builder: (context, state) => const IdentifyHubScreen(),
        ),

        // Stroke Tool
        GoRoute(
          path: '/identify/stroke',
          builder: (context, state) => const StrokeScreen(),
        ),

        // Heart Attack Tool
        GoRoute(
          path: '/identify/heart',
          builder: (context, state) => const HeartAttackScreen(),
        ),

        // Dengue Identify Tool
        GoRoute(
          path: '/identify/dengue',
          builder: (context, state) => const DengueIdentifyScreen(),
        ),

        // Child Emergency Tool
        GoRoute(
          path: '/identify/child',
          builder: (context, state) => const ChildEmergencyScreen(),
        ),

        // Passport (Edit/View)
        GoRoute(
          path: '/passport',
          builder: (context, state) => const PassportScreen(),
        ),

        // Roadmap
        GoRoute(
          path: '/roadmap',
          builder: (context, state) => const RoadmapScreen(),
        ),

        // Wellness Screening
        GoRoute(
          path: '/screening',
          builder: (context, state) => const ScreeningScreen(),
        ),
      ],
    ),
  ],
);
