import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';

class RoadmapScreen extends StatelessWidget {
  const RoadmapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Roadmap',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Our Journey',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 32,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Building the future of civic health, one feature at a time',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),
            _buildPhase(
              phase: 'Phase 1',
              title: 'Public Beta & Awareness',
              status: 'Complete',
              statusColor: const Color(0xFF22C55E),
              progress: 1.0,
              features: const [
                'CVD Assessment (3 calculators)',
                'Dengue Map with live hotspots',
                'Digital Health Passport (LifeQR)',
                'Emergency Identification Hub (4 tools)',
                'Wellness Screening Catalog',
              ],
              date: 'December 2025',
            ),
            _buildPhase(
              phase: 'Phase 1.5',
              title: 'Mobile App Launch',
              status: 'In Planning',
              statusColor: const Color(0xFF0EA5E9),
              progress: 0.2,
              features: const [
                'iOS & Android native apps',
                'Push notifications for dengue alerts',
                'Location-based health services',
                'Offline mode for rural areas',
              ],
              date: 'Q1 2026',
            ),
            _buildPhase(
              phase: 'Phase 2',
              title: 'Hospital Data Integration',
              status: 'Planned',
              statusColor: const Color(0xFF8B5CF6),
              progress: 0.0,
              features: const [
                'Real-time bed availability',
                'Appointment scheduling',
                'Mobile app enhancements',
                'Hospital system API integration',
              ],
              date: 'Q2-Q4 2026',
            ),
            _buildPhase(
              phase: 'Phase 3',
              title: 'PhilSys National ID Sync',
              status: 'Future',
              statusColor: const Color(0xFF94A3B8),
              progress: 0.0,
              features: const [
                'National ID authentication',
                'Government health records integration',
                'Enhanced security with PhilSys',
              ],
              date: '2027+',
              isLast: true,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhase({
    required String phase,
    required String title,
    required String status,
    required Color statusColor,
    required double progress,
    required List<String> features,
    required String date,
    bool isLast = false,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(24),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                    decoration: BoxDecoration(
                      color: statusColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      status,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: statusColor,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Text(
                    date,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xFF64748B),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              Text(
                phase,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF64748B),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                title,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 24,
                  fontWeight: FontWeight.w800,
                  color: const Color(0xFF1E293B),
                ),
              ),
              const SizedBox(height: 16),

              // Progress bar
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: progress,
                  backgroundColor: const Color(0xFFE2E8F0),
                  valueColor: AlwaysStoppedAnimation<Color>(statusColor),
                  minHeight: 8,
                ),
              ),

              const SizedBox(height: 16),

              // Features
              ...features.map((feature) {
                return Padding(
                  padding: const EdgeInsets.only(bottom: 8),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        progress == 1.0
                            ? LucideIcons.checkCircle2
                            : LucideIcons.circle,
                        size: 20,
                        color: progress == 1.0
                            ? statusColor
                            : const Color(0xFF94A3B8),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Text(
                          feature,
                          style: GoogleFonts.plusJakartaSans(
                            fontSize: 14,
                            color: const Color(0xFF475569),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
        if (!isLast) const SizedBox(height: 24),
      ],
    );
  }
}
