import 'package:flutter/material.dart';
import '../widgets/emergency_guide_screen.dart';

class DengueIdentifyScreen extends StatelessWidget {
  const DengueIdentifyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmergencyGuideScreen(
      title: 'Dengue Alert',
      warningSignsData: const [
        'High fever (40°C)',
        'Severe headache',
        'Pain behind the eyes',
        'Severe joint and muscle pain',
        'Nausea and vomiting',
        'Skin rash (appears 2-5 days after fever)',
        'Mild bleeding (nose, gums)',
      ],
      additionalNotes: const [
        'CRITICAL PERIOD: Days 3-7 after symptom onset',
        'DO NOT take aspirin or ibuprofen - use paracetamol only',
        'Watch for severe dengue: persistent vomiting, severe abdominal pain, bleeding',
        'Drink plenty of fluids',
        'Get a platelet count test if fever persists',
      ],
      accentColor: const Color(0xFFF97316),
      phoneNumber: '(054) 473-2326',
    );
  }
}
