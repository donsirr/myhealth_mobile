import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/emergency_guide_screen.dart';

class HeartAttackScreen extends StatelessWidget {
  const HeartAttackScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmergencyGuideScreen(
      title: 'Heart Attack',
      subtitle: 'Recognize & Respond',
      color: const Color(0xFFEF4444),
      icon: LucideIcons.heart,
      emergencySigns: const [
        'Chest pain or discomfort (pressure, squeezing, fullness)',
        'Pain spreading to shoulders, arms, back, neck, jaw, or teeth',
        'Shortness of breath',
        'Cold sweat',
        'Nausea or vomiting',
        'Lightheadedness or sudden dizziness',
        'Unusual fatigue (especially in women)',
      ],
      notes: const [
        'Women may experience different symptoms: unusual fatigue, sleep disturbances, shortness of breath',
        'Chew and swallow an aspirin (if not allergic) while waiting for emergency services',
        'Do NOT drive yourself to the hospital',
        'Time is muscle - every minute counts',
      ],
      emergencyNumber: '911',
    );
  }
}
