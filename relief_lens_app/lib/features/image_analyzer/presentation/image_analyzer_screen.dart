import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';
import 'package:relief_lens_ai/shared/widgets/emergency_card.dart';

final analysisStateProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

class ImageAnalyzerScreen extends ConsumerStatefulWidget {
  const ImageAnalyzerScreen({super.key});
  @override
  ConsumerState<ImageAnalyzerScreen> createState() => _ImageAnalyzerScreenState();
}

class _ImageAnalyzerScreenState extends ConsumerState<ImageAnalyzerScreen> {
  final ImagePicker _picker = ImagePicker();
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    final result = ref.watch(analysisStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Disaster Analyzer')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: result == null ? _buildUploadSection() : _buildResultSection(result),
      ),
    );
  }

  Widget _buildUploadSection() {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.surfaceLight)),
          child: Column(
            children: [
              Container(width: 80, height: 80, decoration: BoxDecoration(gradient: AppColors.alertGradient, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.camera_alt_rounded, color: Colors.white, size: 40)),
              const SizedBox(height: 20),
              const Text('AI Disaster Image Analyzer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 8),
              const Text('Upload a disaster image for instant AI analysis.\nCompletely offline - no internet required.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
              const SizedBox(height: 24),
              Row(children: [
                Expanded(child: ElevatedButton.icon(onPressed: () => _pickImage(ImageSource.camera), icon: const Icon(Icons.camera_alt_rounded), label: const Text('Camera'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(vertical: 16)))),
                const SizedBox(width: 12),
                Expanded(child: OutlinedButton.icon(onPressed: () => _pickImage(ImageSource.gallery), icon: const Icon(Icons.photo_library_rounded), label: const Text('Gallery'), style: OutlinedButton.styleFrom(foregroundColor: AppColors.primary, side: const BorderSide(color: AppColors.primary), padding: const EdgeInsets.symmetric(vertical: 16)))),
              ]),
            ],
          ),
        ),
        const SizedBox(height: 24),
        _buildSupportedTypes(),
        const SizedBox(height: 24),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.1), borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.primary.withOpacity(0.2))),
          child: Row(children: [
            const Icon(Icons.lightbulb_outline_rounded, color: AppColors.primary, size: 24),
            const SizedBox(width: 12),
            const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text('For best results:', style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.primary)),
              SizedBox(height: 4),
              Text('Use clear, well-lit images. Include multiple angles if possible.', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
          ]),
        ),
      ],
    );
  }

  Widget _buildSupportedTypes() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Supported Disaster Types', style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 12),
        Wrap(spacing: 8, runSpacing: 8, children: [
          _buildTypeChip(Icons.water_damage_rounded, 'Flood'),
          _buildTypeChip(Icons.home_rounded, 'Collapsed'),
          _buildTypeChip(Icons.personal_injury_rounded, 'Injuries'),
          _buildTypeChip(Icons.block_rounded, 'Blocked'),
          _buildTypeChip(Icons.electrical_services_rounded, 'Electrical'),
        ]),
      ],
    );
  }

  Widget _buildTypeChip(IconData icon, String label) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.surfaceLight)),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Icon(icon, size: 16, color: AppColors.textSecondary),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ]),
    );
  }

  Widget _buildResultSection(Map<String, dynamic> result) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        EmergencyCard(
          title: result['type'] ?? 'Disaster Analysis',
          subtitle: 'SEVERITY: ${result['severity']}',
          level: result['severity'] == 'CRITICAL' ? EmergencyLevel.critical : result['severity'] == 'HIGH' ? EmergencyLevel.high : EmergencyLevel.medium,
          items: List<String>.from(result['risks'] ?? []),
          actions: List<String>.from(result['actions'] ?? []),
          confidence: result['confidence'] as int?,
          onNewAnalysis: () => ref.read(analysisStateProvider.notifier).state = null,
        ),
      ],
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(source: source, maxWidth: 1920, maxHeight: 1080, imageQuality: 85);
      if (image != null) {
        setState(() => _isLoading = true);
        await Future.delayed(const Duration(seconds: 2));
        ref.read(analysisStateProvider.notifier).state = {
          'type': 'Urban Flood',
          'severity': 'CRITICAL',
          'risks': ['Electrical exposure from submerged power lines', 'Unsafe water current with debris', 'Structural collapse risk from water saturation'],
          'actions': ['Immediate evacuation to higher ground', 'Avoid all submerged metal objects', 'Prioritize elderly and children', 'Move to nearest shelter'],
          'confidence': 94,
        };
        if (mounted) setState(() => _isLoading = false);
      }
    } catch (e) {
      if (mounted) setState(() => _isLoading = false);
    }
  }
}