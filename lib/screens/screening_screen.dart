import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class ScreeningScreen extends StatelessWidget {
  const ScreeningScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final services = [
      _ScreeningService(
        title: 'Cervical Cancer Screening',
        icon: LucideIcons.activity,
        color: const Color(0xFFEC4899),
        description: 'Pap smear and HPV testing for early detection',
        eligibility: ['Women 21-65 years old', 'Sexually active women'],
        requirements: ['Valid ID', 'Health insurance card (if applicable)'],
      ),
      _ScreeningService(
        title: 'Prostate Health Check',
        icon: LucideIcons.stethoscope,
        color: const Color(0xFF3B82F6),
        description: 'PSA testing and digital rectal exam',
        eligibility: ['Men 50+ years old', 'Men 40+ with family history'],
        requirements: ['Valid ID', 'Fasting (8 hours before test)'],
      ),
      _ScreeningService(
        title: 'HIV/AIDS Testing',
        icon: LucideIcons.heartPulse,
        color: const Color(0xFFEF4444),
        description: 'Confidential and free HIV screening',
        eligibility: ['Anyone 15+ years old', 'Pregnant women'],
        requirements: ['Valid ID', 'Parental consent (if under 18)'],
      ),
      _ScreeningService(
        title: 'Diabetes Screening',
        icon: LucideIcons.droplet,
        color: const Color(0xFFF59E0B),
        description: 'Fasting blood sugar and HbA1c testing',
        eligibility: ['Adults 35+ years old', 'Overweight individuals'],
        requirements: ['Valid ID', 'Fasting (8-12 hours)'],
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Wellness Screening',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Free Health Screenings',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Preventive care services available at Naga City Health Office',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),

            ...services.map((service) => _buildServiceCard(service)),

            const SizedBox(height: 24),

            // Contact Info
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9).withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFF0EA5E9).withValues(alpha: 0.3),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      const Icon(
                        LucideIcons.info,
                        color: Color(0xFF0EA5E9),
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Schedule Your Screening',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: const Color(0xFF0EA5E9),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'Naga City Health Office',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Phone: (054) 473-2326',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF475569),
                    ),
                  ),
                  Text(
                    'Hours: Monday-Friday, 8:00 AM - 5:00 PM',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildServiceCard(_ScreeningService service) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent),
        child: ExpansionTile(
          tilePadding: const EdgeInsets.all(20),
          childrenPadding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
          leading: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: service.color.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(service.icon, color: service.color, size: 28),
          ),
          title: Text(
            service.title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          subtitle: Padding(
            padding: const EdgeInsets.only(top: 4),
            child: Text(
              service.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 13,
                color: const Color(0xFF64748B),
              ),
            ),
          ),
          children: [
            _buildSection('Eligibility', service.eligibility),
            const SizedBox(height: 12),
            _buildSection('Requirements', service.requirements),
          ],
        ),
      ),
    );
  }

  Widget _buildSection(String title, List<String> items) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: const Color(0xFF1E293B),
          ),
        ),
        const SizedBox(height: 8),
        ...items.map((item) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text('• ', style: TextStyle(fontSize: 14)),
                Expanded(
                  child: Text(
                    item,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 13,
                      color: const Color(0xFF475569),
                    ),
                  ),
                ),
              ],
            ),
          );
        }),
      ],
    );
  }
}

class _ScreeningService {
  final String title;
  final IconData icon;
  final Color color;
  final String description;
  final List<String> eligibility;
  final List<String> requirements;

  _ScreeningService({
    required this.title,
    required this.icon,
    required this.color,
    required this.description,
    required this.eligibility,
    required this.requirements,
  });
}
