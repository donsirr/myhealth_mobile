import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/emergency_guide_screen.dart';

class ChildEmergencyScreen extends StatelessWidget {
  const ChildEmergencyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmergencyGuideScreen(
      title: 'Child Emergency',
      subtitle: 'Pediatric Warning Signs',
      color: const Color(0xFF14B8A6),
      icon: LucideIcons.baby,
      emergencySigns: const [
        'High fever in infants < 3 months (≥38°C) - ER immediately',
        'Difficulty breathing or rapid breathing',
        'Blue or pale skin, lips, or fingernails',
        'Severe dehydration (no tears, dry mouth, no wet diapers)',
        'Unresponsive or difficult to wake',
        'Seizures or convulsions',
        'Severe vomiting or diarrhea',
        'Stiff neck with fever',
        'Head injury with loss of consciousness',
      ],
      notes: const [
        'FEVER GUIDE:',
        '• 0-3 months: Any fever ≥38°C → ER immediately',
        '• 3-6 months: Fever ≥38.3°C → Call doctor',
        '• 6+ months: Fever ≥39.4°C or lasting >3 days → Seek care',
        '',
        'Trust your parental instinct - if something feels wrong, seek help',
      ],
      emergencyNumber: '911',
    );
  }
}
