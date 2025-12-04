import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'providers/passport_provider.dart';
import 'providers/stroke_timer_provider.dart';
import 'router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize providers
  final passportProvider = PassportProvider();
  await passportProvider.loadData();

  // Set status bar style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: passportProvider),
        ChangeNotifierProvider(create: (_) => StrokeTimerProvider()),
      ],
      child: const MyHealthApp(),
    ),
  );
}

class MyHealthApp extends StatelessWidget {
  const MyHealthApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'MyHealth',
      debugShowCheckedModeBanner: false,

      // Premium Minimalist Theme (NO Material 3)
      theme: ThemeData(
        useMaterial3: false, // CRITICAL: Disable Material 3

        // Color Scheme
        scaffoldBackgroundColor: const Color(0xFFF8FAFC), // Off-white
        primaryColor: const Color(0xFF0EA5E9), // Medical blue
        colorScheme: const ColorScheme.light(
          primary: Color(0xFF0EA5E9),
          secondary: Color(0xFF22C55E),
          surface: Color(0xFFFFFFFF),
          error: Color(0xFFEF4444),
        ),

        // Typography - Plus Jakarta Sans
        textTheme: GoogleFonts.plusJakartaSansTextTheme(
          ThemeData.light().textTheme,
        ).copyWith(
          displayLarge: GoogleFonts.plusJakartaSans(
            fontSize: 32,
            fontWeight: FontWeight.w800,
            color: const Color(0xFF1E293B),
          ),
          displayMedium: GoogleFonts.plusJakartaSans(
            fontSize: 28,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
          headlineMedium: GoogleFonts.plusJakartaSans(
            fontSize: 24,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF1E293B),
          ),
          bodyLarge: GoogleFonts.plusJakartaSans(
            fontSize: 16,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF475569),
          ),
          bodyMedium: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w400,
            color: const Color(0xFF64748B),
          ),
        ),

        // Card Theme - Glassmorphism
        cardTheme: CardThemeData(
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          color: Colors.white.withValues(alpha: 0.8),
        ),

        // Elevated Button - Premium Style
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: const Color(0xFF0EA5E9),
            foregroundColor: Colors.white,
            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            textStyle: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),

        // App Bar - Clean & Minimal
        appBarTheme: AppBarTheme(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: const Color(0xFF1E293B),
          titleTextStyle: GoogleFonts.plusJakartaSans(
            fontSize: 20,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
          systemOverlayStyle: SystemUiOverlayStyle.dark,
        ),
      ),

      routerConfig: router,
    );
  }
}
