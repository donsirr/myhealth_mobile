import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:url_launcher/url_launcher.dart';

class DengueScreen extends StatefulWidget {
  const DengueScreen({super.key});

  @override
  State<DengueScreen> createState() => _DengueScreenState();
}

class _DengueScreenState extends State<DengueScreen>
    with TickerProviderStateMixin {
  late final AnimationController _pulseController;

  final List<_Hotspot> hotspots = [
    _Hotspot(
      name: 'Brgy. Triangulo',
      location: const LatLng(13.6218, 123.1948),
      severity: 'High Risk',
      color: const Color(0xFFEF4444),
    ),
    _Hotspot(
      name: 'Brgy. Concepcion',
      location: const LatLng(13.6298, 123.1898),
      severity: 'High Risk',
      color: const Color(0xFFEF4444),
    ),
    _Hotspot(
      name: 'Brgy. San Felipe',
      location: const LatLng(13.6158, 123.2028),
      severity: 'Moderate',
      color: const Color(0xFFF97316),
    ),
  ];

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();
  }

  @override
  void dispose() {
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFC),
      appBar: AppBar(
        title: Text(
          'Dengue Radar',
          style: GoogleFonts.plusJakartaSans(fontWeight: FontWeight.w700),
        ),
      ),
      body: Column(
        children: [
          // Map
          Expanded(
            flex: 2,
            child: Container(
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(24),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.1),
                    blurRadius: 16,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              clipBehavior: Clip.antiAlias,
              child: FlutterMap(
                options: MapOptions(
                  initialCenter: const LatLng(13.6218, 123.1948),
                  initialZoom: 14.0,
                  minZoom: 13.0,
                  maxZoom: 18.0,
                  cameraConstraint: CameraConstraint.contain(
                    bounds: LatLngBounds(
                      const LatLng(13.58, 123.15),
                      const LatLng(13.66, 123.25),
                    ),
                  ),
                ),
                children: [
                  TileLayer(
                    urlTemplate:
                        'https://{s}.basemaps.cartocdn.com/light_all/{z}/{x}/{y}.png',
                    subdomains: const ['a', 'b', 'c'],
                    userAgentPackageName: 'com.myhealth.app',
                  ),
                  // Pulsing markers
                  ...hotspots.map((hotspot) => _buildPulsingMarker(hotspot)),
                ],
              ),
            ),
          ),

          // Legend
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildLegendItem('High Risk', const Color(0xFFEF4444)),
                const SizedBox(width: 24),
                _buildLegendItem('Moderate', const Color(0xFFF97316)),
              ],
            ),
          ),

          const SizedBox(height: 16),

          // Report Case Button - Placed here for visibility
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Container(
              width: double.infinity,
              height: 56,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFFEF4444), Color(0xFFDC2626)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFFEF4444).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: () => _launchPhone('(054) 473-2326'),
                  borderRadius: BorderRadius.circular(16),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        LucideIcons.phone,
                        color: Colors.white,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        'Report Dengue Case',
                        style: GoogleFonts.plusJakartaSans(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          // Prevention Tips (Accordion)
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 120),
              children: [
                Text(
                  'Prevention Tips',
                  style: GoogleFonts.plusJakartaSans(
                    fontSize: 18,
                    fontWeight: FontWeight.w700,
                    color: const Color(0xFF1E293B),
                  ),
                ),
                const SizedBox(height: 12),
                _buildPreventionTile(
                  title: 'Eliminate Standing Water',
                  icon: LucideIcons.droplets,
                  tips: [
                    'Empty flower pots and containers weekly',
                    'Clean roof gutters regularly',
                    'Cover water storage drums tightly',
                    'Change pet water bowls daily',
                  ],
                ),
                _buildPreventionTile(
                  title: 'Protect Your Home',
                  icon: LucideIcons.home,
                  tips: [
                    'Install window screens',
                    'Use mosquito nets while sleeping',
                    'Apply insect repellent on exposed skin',
                    'Wear long sleeves during peak hours (dawn/dusk)',
                  ],
                ),
                _buildPreventionTile(
                  title: 'Community Action',
                  icon: LucideIcons.users,
                  tips: [
                    'Participate in cleanup drives',
                    'Report breeding sites to barangay',
                    'Support fogging operations',
                    'Educate neighbors about prevention',
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPulsingMarker(_Hotspot hotspot) {
    return AnimatedBuilder(
      animation: _pulseController,
      builder: (context, child) {
        final scale = 1.0 + (_pulseController.value * 0.5);
        final opacity = 1.0 - _pulseController.value;

        return MarkerLayer(
          markers: [
            // Outer pulse
            Marker(
              point: hotspot.location,
              width: 60 * scale,
              height: 60 * scale,
              child: Container(
                decoration: BoxDecoration(
                  color: hotspot.color.withValues(alpha: opacity * 0.3),
                  shape: BoxShape.circle,
                ),
              ),
            ),
            // Inner circle
            Marker(
              point: hotspot.location,
              width: 40,
              height: 40,
              child: Container(
                decoration: BoxDecoration(
                  color: hotspot.color,
                  shape: BoxShape.circle,
                  border: Border.all(color: Colors.white, width: 3),
                  boxShadow: [
                    BoxShadow(
                      color: hotspot.color.withValues(alpha: 0.5),
                      blurRadius: 8,
                      spreadRadius: 2,
                    ),
                  ],
                ),
                child: const Icon(
                  LucideIcons.alertCircle,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: const Color(0xFF475569),
          ),
        ),
      ],
    );
  }

  Widget _buildPreventionTile({
    required String title,
    required IconData icon,
    required List<String> tips,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          leading: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: const Color(0xFFF97316).withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Icon(icon, color: const Color(0xFFF97316), size: 20),
          ),
          title: Text(
            title,
            style: GoogleFonts.plusJakartaSans(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: const Color(0xFF1E293B),
            ),
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: tips.map((tip) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text('• ', style: TextStyle(fontSize: 16)),
                        Expanded(
                          child: Text(
                            tip,
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: 14,
                              color: const Color(0xFF64748B),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
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

class _Hotspot {
  final String name;
  final LatLng location;
  final String severity;
  final Color color;

  _Hotspot({
    required this.name,
    required this.location,
    required this.severity,
    required this.color,
  });
}
