import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';

class IdentifyHubScreen extends StatelessWidget {
  const IdentifyHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final tools = [
      _ToolCard(
        id: 'stroke',
        title: 'Stroke',
        subtitle: 'Brain Emergency',
        description: 'F.A.S.T. symptom identification',
        icon: LucideIcons.brain,
        color: const Color(0xFF8B5CF6),
        route: '/identify/stroke',
      ),
      _ToolCard(
        id: 'heart',
        title: 'Heart Attack',
        subtitle: 'Cardiac Emergency',
        description: 'Recognize heart attack signs',
        icon: LucideIcons.heart,
        color: const Color(0xFFEF4444),
        route: '/identify/heart',
      ),
      _ToolCard(
        id: 'dengue',
        title: 'Dengue',
        subtitle: 'Fever & Warning Signs',
        description: 'Identify dengue symptoms',
        icon: LucideIcons.thermometer,
        color: const Color(0xFFF97316),
        route: '/identify/dengue',
      ),
      _ToolCard(
        id: 'child',
        title: 'Child Emergency',
        subtitle: 'Pediatric Alerts',
        description: 'Common child emergencies',
        icon: LucideIcons.baby,
        color: const Color(0xFF14B8A6),
        route: '/identify/child',
      ),
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () => context.go('/'),
        ),
        title: Text(
          'Emergency Tools',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 120),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Emergency Type',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the tool to identify critical symptoms',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 24),

            // Grid of emergency tools (2x2)
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
                childAspectRatio: 0.85,
              ),
              itemCount: tools.length,
              itemBuilder: (context, index) {
                final tool = tools[index];
                return _buildToolCard(context, tool);
              },
            ),

            const SizedBox(height: 24),

            // Disclaimer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: const Color(0xFFFECACA),
                  width: 1,
                ),
              ),
              child: Row(
                children: [
                  const Icon(
                    LucideIcons.alertCircle,
                    color: Color(0xFFEF4444),
                    size: 20,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'For educational purposes. When in doubt, call emergency services immediately.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xFF991B1B),
                      ),
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

  Widget _buildToolCard(BuildContext context, _ToolCard tool) {
    return GestureDetector(
      onTap: () => context.push(tool.route),
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: tool.color.withValues(alpha: 0.2),
            width: 3,
          ),
          boxShadow: [
            BoxShadow(
              color: tool.color.withValues(alpha: 0.1),
              blurRadius: 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: tool.color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(
                tool.icon,
                color: Colors.white,
                size: 40,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              tool.title,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 4),
            Text(
              tool.subtitle,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 12,
                fontWeight: FontWeight.w600,
                color: tool.color,
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 8),
            Text(
              tool.description,
              style: GoogleFonts.plusJakartaSans(
                fontSize: 11,
                fontWeight: FontWeight.w400,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _ToolCard {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final String route;

  _ToolCard({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.route,
  });
}
