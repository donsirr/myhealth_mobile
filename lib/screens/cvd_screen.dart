import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../widgets/risk_result_sheet.dart';

// Disease types
enum DiseaseType {
  cardiovascular('Cardiovascular Risk', LucideIcons.heart),
  stroke('Stroke Risk', LucideIcons.brain),
  heartAttack('Heart Attack Risk', LucideIcons.heartPulse);

  final String label;
  final IconData icon;
  const DiseaseType(this.label, this.icon);
}

// Question structure
class RiskQuestion {
  final String id;
  final String question;
  final List<RiskOption> options;
  final bool isNumeric;

  RiskQuestion({
    required this.id,
    required this.question,
    required this.options,
    this.isNumeric = false,
  });
}

class RiskOption {
  final String label;
  final int points;

  RiskOption({required this.label, required this.points});
}

class CvdScreen extends StatefulWidget {
  const CvdScreen({super.key});

  @override
  State<CvdScreen> createState() => _CvdScreenState();
}

class _CvdScreenState extends State<CvdScreen> {
  DiseaseType? selectedDisease;
  Map<String, dynamic> answers = {};

  // Question bank (ported from Next.js)
  final Map<DiseaseType, List<RiskQuestion>> questionBank = {
    DiseaseType.cardiovascular: [
      RiskQuestion(
        id: 'age_cardio',
        question: 'What is your age?',
        options: [
          RiskOption(label: '< 40', points: 0),
          RiskOption(label: '40-49', points: 1),
          RiskOption(label: '50-59', points: 2),
          RiskOption(label: '60+', points: 3),
        ],
      ),
      RiskQuestion(
        id: 'smoker',
        question: 'Do you smoke?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 4),
        ],
      ),
      RiskQuestion(
        id: 'bmi',
        question: 'What is your BMI?',
        options: [
          RiskOption(label: '< 25 (Normal)', points: 0),
          RiskOption(label: '25-29.9 (Overweight)', points: 2),
          RiskOption(label: '30+ (Obese)', points: 3),
        ],
      ),
      RiskQuestion(
        id: 'activity',
        question: 'Physical activity level?',
        options: [
          RiskOption(label: 'Active (3+ times/week)', points: 0),
          RiskOption(label: 'Moderate (1-2 times/week)', points: 1),
          RiskOption(label: 'Sedentary (None)', points: 3),
        ],
      ),
    ],
    DiseaseType.stroke: [
      RiskQuestion(
        id: 'age_stroke',
        question: 'What is your age?',
        options: [
          RiskOption(label: '< 50', points: 0),
          RiskOption(label: '50-64', points: 2),
          RiskOption(label: '65+', points: 4),
        ],
      ),
      RiskQuestion(
        id: 'high_bp',
        question: 'Do you have high blood pressure?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 5),
        ],
      ),
      RiskQuestion(
        id: 'irregular_heartbeat',
        question: 'Irregular heartbeat (AFib)?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 4),
        ],
      ),
      RiskQuestion(
        id: 'diabetes',
        question: 'Do you have diabetes?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 3),
        ],
      ),
    ],
    DiseaseType.heartAttack: [
      RiskQuestion(
        id: 'chest_pain',
        question: 'Chest pain frequency?',
        options: [
          RiskOption(label: 'Never', points: 0),
          RiskOption(label: 'Rarely', points: 2),
          RiskOption(label: 'Frequently', points: 5),
        ],
      ),
      RiskQuestion(
        id: 'cholesterol',
        question: 'High cholesterol?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 4),
        ],
      ),
      RiskQuestion(
        id: 'family_history',
        question: 'Family history of heart disease?',
        options: [
          RiskOption(label: 'No', points: 0),
          RiskOption(label: 'Yes', points: 3),
        ],
      ),
      RiskQuestion(
        id: 'stress',
        question: 'Stress level?',
        options: [
          RiskOption(label: 'Low', points: 0),
          RiskOption(label: 'Moderate', points: 1),
          RiskOption(label: 'High', points: 2),
        ],
      ),
    ],
  };

  @override
  Widget build(BuildContext context) {
    if (selectedDisease == null) {
      return _buildDiseaseSelection();
    } else {
      return _buildQuestionnaire();
    }
  }

  Widget _buildDiseaseSelection() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Risk Assessment',
          style: GoogleFonts.plusJakartaSans(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Risk Type',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 28,
                fontWeight: FontWeight.w800,
                color: const Color(0xFF0F172A),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Choose the assessment you\'d like to take',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 16,
                color: const Color(0xFF64748B),
              ),
            ),
            const SizedBox(height: 32),
            Expanded(
              child: ListView(
                children: DiseaseType.values.map((type) {
                  return _buildDiseaseCard(type);
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDiseaseCard(DiseaseType type) {
    final colors = {
      DiseaseType.cardiovascular: const Color(0xFF0EA5E9),
      DiseaseType.stroke: const Color(0xFF8B5CF6),
      DiseaseType.heartAttack: const Color(0xFFEF4444),
    };

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedDisease = type;
          answers.clear();
        });
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        padding: const EdgeInsets.all(24),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              colors[type]!,
              colors[type]!.withValues(alpha: 0.8),
            ],
          ),
          borderRadius: BorderRadius.circular(24),
          boxShadow: [
            BoxShadow(
              color: colors[type]!.withValues(alpha: 0.3),
              blurRadius: 16,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.2),
                borderRadius: BorderRadius.circular(16),
              ),
              child: Icon(type.icon, color: Colors.white, size: 32),
            ),
            const SizedBox(width: 20),
            Expanded(
              child: Text(
                type.label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: Colors.white,
                ),
              ),
            ),
            const Icon(LucideIcons.chevronRight, color: Colors.white),
          ],
        ),
      ),
    );
  }

  Widget _buildQuestionnaire() {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(LucideIcons.arrowLeft),
          onPressed: () {
            setState(() {
              selectedDisease = null;
              answers.clear();
            });
          },
        ),
        title: Text(
          selectedDisease!.label,
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: Stack(
        children: [
          // Scrollable questions
          Padding(
            padding:
                const EdgeInsets.only(top: 80), // Space for floating button
            child: ListView(
              padding: const EdgeInsets.all(24),
              children: questionBank[selectedDisease]!.map((question) {
                return _buildQuestionCard(question);
              }).toList(),
            ),
          ),
          // Floating button at TOP
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: Container(
              padding: const EdgeInsets.fromLTRB(24, 16, 24, 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 12,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: _buildCalculateButton(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuestionCard(RiskQuestion question) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
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
          Text(
            question.question,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: const Color(0xFF1E293B),
            ),
          ),
          const SizedBox(height: 16),
          ...question.options.map((option) {
            final isSelected = answers[question.id] == option.points;
            return GestureDetector(
              onTap: () {
                setState(() {
                  answers[question.id] = option.points;
                });
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 12),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: isSelected
                      ? const Color(0xFF0EA5E9).withValues(alpha: 0.1)
                      : const Color(0xFFF8FAFC),
                  border: Border.all(
                    color: isSelected
                        ? const Color(0xFF0EA5E9)
                        : const Color(0xFFE2E8F0),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 20,
                      height: 20,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: isSelected
                              ? const Color(0xFF0EA5E9)
                              : const Color(0xFFCBD5E1),
                          width: 2,
                        ),
                        color:
                            isSelected ? const Color(0xFF0EA5E9) : Colors.white,
                      ),
                      child: isSelected
                          ? const Icon(
                              Icons.check,
                              size: 14,
                              color: Colors.white,
                            )
                          : null,
                    ),
                    const SizedBox(width: 12),
                    Text(
                      option.label,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 14,
                        fontWeight:
                            isSelected ? FontWeight.w600 : FontWeight.w400,
                        color: const Color(0xFF475569),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ],
      ),
    );
  }

  Widget _buildCalculateButton() {
    final allAnswered = questionBank[selectedDisease]!.every(
      (q) => answers.containsKey(q.id),
    );

    return ElevatedButton(
      onPressed: allAnswered ? _calculateRisk : null,
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(double.infinity, 56),
        backgroundColor: const Color(0xFF0EA5E9),
        disabledBackgroundColor: const Color(0xFFCBD5E1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        'Analyze Risk',
        style: GoogleFonts.plusJakartaSans(
          fontSize: 16,
          fontWeight: FontWeight.w700,
        ),
      ),
    );
  }

  void _calculateRisk() {
    final totalPoints =
        answers.values.fold<int>(0, (sum, points) => sum + (points as int));

    // Risk levels based on points
    String riskLevel;
    Color riskColor;
    String advice;

    if (totalPoints <= 3) {
      riskLevel = 'Low Risk';
      riskColor = const Color(0xFF22C55E);
      advice =
          'Great! Maintain your healthy lifestyle with regular exercise and balanced diet.';
    } else if (totalPoints <= 7) {
      riskLevel = 'Moderate Risk';
      riskColor = const Color(0xFFF59E0B);
      advice =
          'Consider lifestyle changes. Schedule a check-up with your doctor for assessment.';
    } else {
      riskLevel = 'High Risk';
      riskColor = const Color(0xFFEF4444);
      advice =
          'Please consult a healthcare provider immediately. Consider activating your LifeQR for emergency preparedness.';
    }

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => RiskResultSheet(
        riskLevel: riskLevel,
        riskColor: riskColor,
        advice: advice,
        totalPoints: totalPoints,
        diseaseType: selectedDisease!.label,
      ),
    );
  }
}
