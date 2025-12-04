import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:provider/provider.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../providers/passport_provider.dart';

class PassportScreen extends StatefulWidget {
  const PassportScreen({super.key});

  @override
  State<PassportScreen> createState() => _PassportScreenState();
}

class _PassportScreenState extends State<PassportScreen> {
  bool isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _nameController;
  late TextEditingController _contactController;
  late TextEditingController _allergiesController;
  String? _selectedBloodType;

  final List<String> bloodTypes = [
    'A+',
    'A-',
    'B+',
    'B-',
    'AB+',
    'AB-',
    'O+',
    'O-'
  ];

  @override
  void initState() {
    super.initState();
    final provider = context.read<PassportProvider>();
    _nameController = TextEditingController(text: provider.fullName);
    _contactController = TextEditingController(text: provider.emergencyContact);
    _allergiesController = TextEditingController(text: provider.allergies);
    _selectedBloodType = provider.bloodType.isEmpty ? null : provider.bloodType;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _contactController.dispose();
    _allergiesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Health Passport',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
        actions: [
          if (!isEditing)
            IconButton(
              icon: const Icon(LucideIcons.edit),
              onPressed: () => setState(() => isEditing = true),
            ),
        ],
      ),
      body: Consumer<PassportProvider>(
        builder: (context, provider, _) {
          if (!provider.hasData && !isEditing) {
            return _buildEmptyState();
          }

          return isEditing
              ? _buildEditForm(provider)
              : _buildViewMode(provider);
        },
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                color: const Color(0xFF0EA5E9).withValues(alpha: 0.1),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                LucideIcons.creditCard,
                size: 60,
                color: Color(0xFF0EA5E9),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              'No Passport Yet',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: const Color(0xFF1E293B),
              ),
            ),
            const SizedBox(height: 12),
            Text(
              'Create your digital health passport for emergency situations',
              style: GoogleFonts.plusJakartaSans(
                fontSize: 14,
                color: const Color(0xFF64748B),
              ),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: () => setState(() => isEditing = true),
              icon: const Icon(LucideIcons.plus, size: 20),
              label: const Text('Create Passport'),
              style: ElevatedButton.styleFrom(
                padding:
                    const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildViewMode(PassportProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          // QR Code Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(32),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
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
                    const Icon(
                      LucideIcons.qrCode,
                      color: Color(0xFF0EA5E9),
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      'Your LifeQR Code',
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: const Color(0xFF1E293B),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(
                      color: const Color(0xFF0EA5E9),
                      width: 4,
                    ),
                  ),
                  child: QrImageView(
                    data: provider.qrData,
                    version: QrVersions.auto,
                    size: 200,
                    backgroundColor: Colors.white,
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Scannable by emergency responders',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    color: const Color(0xFF64748B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // Details Card
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(24),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.08),
                  blurRadius: 16,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Emergency Information',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 20),
                _buildInfoRow(
                  icon: LucideIcons.user,
                  label: 'Full Name',
                  value: provider.fullName,
                ),
                _buildInfoRow(
                  icon: LucideIcons.droplet,
                  label: 'Blood Type',
                  value: provider.bloodType,
                ),
                _buildInfoRow(
                  icon: LucideIcons.phone,
                  label: 'Emergency Contact',
                  value: provider.emergencyContact,
                ),
                _buildInfoRow(
                  icon: LucideIcons.alertCircle,
                  label: 'Allergies',
                  value: provider.allergies,
                  isLast: true,
                ),
              ],
            ),
          ),

          const SizedBox(height: 100), // Space for nav dock
        ],
      ),
    );
  }

  Widget _buildInfoRow({
    required IconData icon,
    required String label,
    required String value,
    bool isLast = false,
  }) {
    return Padding(
      padding: EdgeInsets.only(bottom: isLast ? 0 : 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 20, color: const Color(0xFF0EA5E9)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                    color: const Color(0xFF64748B),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  value.isEmpty ? 'Not set' : value,
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: const Color(0xFF1E293B),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEditForm(PassportProvider provider) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(24),
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Full Name
            _buildFormField(
              label: 'Full Name',
              icon: LucideIcons.user,
              controller: _nameController,
              hint: 'Juan Dela Cruz',
            ),

            // Blood Type
            _buildBloodTypeSelector(),

            // Emergency Contact
            _buildFormField(
              label: 'Emergency Contact',
              icon: LucideIcons.phone,
              controller: _contactController,
              hint: '0917-123-4567',
              keyboardType: TextInputType.phone,
            ),

            // Allergies
            _buildFormField(
              label: 'Known Allergies',
              icon: LucideIcons.alertCircle,
              controller: _allergiesController,
              hint: 'None or list medications/food allergies',
              maxLines: 3,
            ),

            const SizedBox(height: 32),

            // Save Button
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        isEditing = false;
                        // Reset to original values
                        _nameController.text = provider.fullName;
                        _contactController.text = provider.emergencyContact;
                        _allergiesController.text = provider.allergies;
                        _selectedBloodType = provider.bloodType.isEmpty
                            ? null
                            : provider.bloodType;
                      });
                    },
                    child: const Text('Cancel'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 2,
                  child: ElevatedButton.icon(
                    onPressed: _savePassport,
                    icon: const Icon(LucideIcons.save, size: 20),
                    label: const Text('Save Passport'),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 100), // Space for nav dock
          ],
        ),
      ),
    );
  }

  Widget _buildFormField({
    required String label,
    required IconData icon,
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, size: 16, color: const Color(0xFF0EA5E9)),
              const SizedBox(width: 8),
              Text(
                label,
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          TextFormField(
            controller: controller,
            keyboardType: keyboardType,
            maxLines: maxLines,
            decoration: InputDecoration(
              hintText: hint,
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFFE2E8F0), width: 2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide:
                    const BorderSide(color: Color(0xFF0EA5E9), width: 2),
              ),
            ),
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'This field is required';
              }
              return null;
            },
          ),
        ],
      ),
    );
  }

  Widget _buildBloodTypeSelector() {
    return Padding(
      padding: const EdgeInsets.only(bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(LucideIcons.droplet,
                  size: 16, color: Color(0xFF0EA5E9)),
              const SizedBox(width: 8),
              Text(
                'Blood Type',
                style: GoogleFonts.plusJakartaSans(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF1E293B),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 4,
              mainAxisSpacing: 8,
              crossAxisSpacing: 8,
              childAspectRatio: 2,
            ),
            itemCount: bloodTypes.length,
            itemBuilder: (context, index) {
              final type = bloodTypes[index];
              final isSelected = _selectedBloodType == type;
              return GestureDetector(
                onTap: () => setState(() => _selectedBloodType = type),
                child: Container(
                  decoration: BoxDecoration(
                    color: isSelected ? const Color(0xFF0EA5E9) : Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    border: Border.all(
                      color: isSelected
                          ? const Color(0xFF0EA5E9)
                          : const Color(0xFFE2E8F0),
                      width: 2,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      type,
                      style: GoogleFonts.plusJakartaSans(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        color:
                            isSelected ? Colors.white : const Color(0xFF475569),
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  Future<void> _savePassport() async {
    if (!_formKey.currentState!.validate() || _selectedBloodType == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _selectedBloodType == null
                ? 'Please select blood type'
                : 'Please fill all fields',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFFEF4444),
        ),
      );
      return;
    }

    final provider = context.read<PassportProvider>();
    final success = await provider.saveData(
      fullName: _nameController.text,
      bloodType: _selectedBloodType!,
      emergencyContact: _contactController.text,
      allergies: _allergiesController.text,
    );

    if (success && mounted) {
      setState(() => isEditing = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            'Passport saved successfully!',
            style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w600),
          ),
          backgroundColor: const Color(0xFF22C55E),
        ),
      );
    }
  }
}
