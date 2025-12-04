import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:go_router/go_router.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../providers/stroke_timer_provider.dart';

class StrokeScreen extends StatefulWidget {
  const StrokeScreen({super.key});

  @override
  State<StrokeScreen> createState() => _StrokeScreenState();
}

class _StrokeScreenState extends State<StrokeScreen> {
  final Set<String> selectedChecks = {};

  final List<_FastCheck> fastChecks = [
    _FastCheck(
      id: 'face',
      letter: 'F',
      title: 'Face',
      question: 'Does one side of the face droop?',
      instruction: 'Ask the person to smile.',
      icon: LucideIcons.smile,
    ),
    _FastCheck(
      id: 'arms',
      letter: 'A',
      title: 'Arms',
      question: 'Does one arm drift downward?',
      instruction: 'Ask them to raise both arms.',
      icon: LucideIcons.userX,
    ),
    _FastCheck(
      id: 'speech',
      letter: 'S',
      title: 'Speech',
      question: 'Is speech slurred or strange?',
      instruction: 'Ask them to repeat a simple phrase.',
      icon: LucideIcons.messageCircle,
    ),
    _FastCheck(
      id: 'time',
      letter: 'T',
      title: 'Time',
      question: 'Call (054) 473-2326 IMMEDIATELY',
      instruction: 'Time is brain. Every second counts.',
      icon: LucideIcons.clock,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final timerProvider = context.watch<StrokeTimerProvider>();

    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () {
            if (timerProvider.isActive) {
              // Show warning
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: Text(
                    'Timer Active',
                    style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w700),
                  ),
                  content: Text(
                    'The stroke timer is still running. It will continue on other screens.',
                    style: GoogleFonts.plusJakartaSans(),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        Navigator.pop(ctx);
                        context.go('/identify');
                      },
                      child: const Text('Continue'),
                    ),
                  ],
                ),
              );
            } else {
              context.go('/identify');
            }
          },
        ),
        title: Text(
          'Stroke Detection',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(24, 16, 24, 100),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Inline Timer (shown ON stroke page when active)
            if (timerProvider.isActive) _buildInlineTimer(timerProvider),

            // Hero
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF8B5CF6), Color(0xFF7C3AED)],
                ),
                borderRadius: BorderRadius.circular(24),
              ),
              child: Column(
                children: [
                  const Icon(
                    LucideIcons.alertTriangle,
                    color: Colors.white,
                    size: 40,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'BRAIN EMERGENCY',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 16,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      letterSpacing: 1.5,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'F.A.S.T. Recognition Tool',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 24,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // F.A.S.T. Cards
            ...fastChecks.map((check) => _buildFastCard(check, timerProvider)),

            const SizedBox(height: 24),

            // Education Section (Always Visible)
            _buildEducationSection(),

            const SizedBox(height: 24),

            // Disclaimer
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color(0xFFFEF2F2),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: const Color(0xFFFECACA)),
              ),
              child: Row(
                children: [
                  const Icon(LucideIcons.info,
                      color: Color(0xFFEF4444), size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      'This tool is for educational purposes. Always call emergency services if you suspect a stroke.',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 12,
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
      floatingActionButton: selectedChecks.contains('time')
          ? FloatingActionButton.extended(
              onPressed: () => _launchPhone('0544732326'),
              backgroundColor: const Color(0xFFEF4444),
              icon: const Icon(LucideIcons.phone),
              label: Text(
                'Call Now',
                style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
              ),
            )
          : null,
    );
  }

  Widget _buildInlineTimer(StrokeTimerProvider provider) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      margin: const EdgeInsets.only(bottom: 24),
      decoration: BoxDecoration(
        color: const Color(0xFFDC2626),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFFDC2626).withValues(alpha: 0.3),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(LucideIcons.clock, color: Colors.white, size: 40),
              const SizedBox(width: 16),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'SYMPTOM DETECTED',
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      color: Colors.white,
                      letterSpacing: 1.2,
                    ),
                  ),
                  Text(
                    provider.formattedTime,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 48,
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      height: 1,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            'Call (054) 473-2326 or 911 immediately!',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildFastCard(_FastCheck check, StrokeTimerProvider provider) {
    final isSelected = selectedChecks.contains(check.id);
    final isTime = check.id == 'time';

    return GestureDetector(
      onTap: () {
        setState(() {
          if (isSelected) {
            selectedChecks.remove(check.id);
          } else {
            selectedChecks.add(check.id);
          }

          // Start timer if F, A, or S selected
          if (['face', 'arms', 'speech']
              .any((id) => selectedChecks.contains(id))) {
            if (!provider.isActive) {
              provider.startTimer();
            }
          } else {
            // Stop if all deselected
            if (selectedChecks.isEmpty) {
              provider.stopTimer();
            }
          }
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: isSelected
              ? (isTime ? const Color(0xFFDC2626) : const Color(0xFF8B5CF6))
              : Colors.white,
          border: Border.all(
            color: isSelected
                ? (isTime ? const Color(0xFFDC2626) : const Color(0xFF8B5CF6))
                : const Color(0xFFE2E8F0),
            width: 3,
          ),
          borderRadius: BorderRadius.circular(20),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: (isTime
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF8B5CF6))
                        .withValues(alpha: 0.3),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ]
              : [],
        ),
        child: Row(
          children: [
            // Letter Circle
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: isSelected
                    ? Colors.white.withValues(alpha: 0.2)
                    : const Color(0xFF8B5CF6).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: Center(
                child: Text(
                  check.letter,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 28,
                    fontWeight: FontWeight.w900,
                    color: isSelected
                        ? Colors.white
                        : (isTime
                            ? const Color(0xFFDC2626)
                            : const Color(0xFF8B5CF6)),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    check.title,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color:
                          isSelected ? Colors.white : const Color(0xFF1E293B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    check.question,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.9)
                          : const Color(0xFF64748B),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    check.instruction,
                    style: GoogleFonts.plusJakartaSans(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                      color: isSelected
                          ? Colors.white.withValues(alpha: 0.8)
                          : const Color(0xFF94A3B8),
                    ),
                  ),
                ],
              ),
            ),
            Icon(
              check.icon,
              color: isSelected ? Colors.white : const Color(0xFF94A3B8),
              size: 32,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEducationSection() {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFDEEBFF),
        borderRadius: BorderRadius.circular(20),
        border: const Border(
          left: BorderSide(color: Color(0xFF0EA5E9), width: 4),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Is Stroke Reversible?',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 24,
              fontWeight: FontWeight.w800,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            '⏰ TIME IS BRAIN',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF0EA5E9),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Yes! Many strokes (especially ischemic strokes caused by blood clots) are REVERSIBLE if treated within 3-4.5 hours.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 12),
          Text(
            'Modern treatments like tPA (clot-busting drugs) and mechanical thrombectomy can restore blood flow and prevent permanent brain damage.',
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              height: 1.6,
              color: const Color(0xFF475569),
            ),
          ),
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                  color: const Color(0xFF0EA5E9).withValues(alpha: 0.3)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '⚠️ DO NOT WAIT',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFFDC2626),
                  ),
                ),
                const SizedBox(height: 12),
                ...[
                  'Do not wait for symptoms to improve',
                  'Do not "sleep it off" - this can be fatal',
                  'Do not drive yourself to hospital',
                  'Call 911 - paramedics start treatment en route',
                  'Note the exact time symptoms appeared',
                ].map((text) => Padding(
                      padding: const EdgeInsets.only(bottom: 8),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text('• ', style: TextStyle(fontSize: 16)),
                          Expanded(
                            child: Text(
                              text,
                              style: GoogleFonts.plusJakartaSans(
                                fontSize: 14,
                                color: const Color(0xFF475569),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _launchPhone(String number) async {
    final uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }
}

class _FastCheck {
  final String id;
  final String letter;
  final String title;
  final String question;
  final String instruction;
  final IconData icon;

  _FastCheck({
    required this.id,
    required this.letter,
    required this.title,
    required this.question,
    required this.instruction,
    required this.icon,
  });
}
