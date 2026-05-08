import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';
import 'package:relief_lens_ai/shared/widgets/emergency_card.dart';

final voiceStateProvider = StateProvider<Map<String, dynamic>?>((ref) => null);

class VoiceAssistantScreen extends ConsumerStatefulWidget {
  const VoiceAssistantScreen({super.key});
  @override
  ConsumerState<VoiceAssistantScreen> createState() => _VoiceAssistantScreenState();
}

class _VoiceAssistantScreenState extends ConsumerState<VoiceAssistantScreen> with SingleTickerProviderStateMixin {
  late AnimationController _waveController;
  bool _isListening = false;

  @override
  void initState() {
    super.initState();
    _waveController = AnimationController(vsync: this, duration: const Duration(milliseconds: 1000))..repeat();
  }

  @override
  void dispose() {
    _waveController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final response = ref.watch(voiceStateProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('Voice Emergency Assistant')),
      body: Column(children: [
        Expanded(child: response == null ? _buildEmptyState() : _buildResponseView(response)),
        _buildInputArea(),
      ]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 100, height: 100, decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(25), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))]), child: const Icon(Icons.mic_rounded, color: Colors.white, size: 48)),
            const SizedBox(height: 24),
            const Text('Voice Emergency Assistant', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
            const SizedBox(height: 12),
            const Text('Speak in Telugu, Hindi, or English.\nGet instant emergency guidance offline.', textAlign: TextAlign.center, style: TextStyle(fontSize: 14, color: AppColors.textSecondary, height: 1.5)),
            const SizedBox(height: 32),
            Row(mainAxisAlignment: MainAxisAlignment.center, children: [
              _buildLanguageChip('తెలుగు', 'Telugu'),
              const SizedBox(width: 12),
              _buildLanguageChip('हिंदी', 'Hindi'),
              const SizedBox(width: 12),
              _buildLanguageChip('English', 'English'),
            ]),
          ],
        ),
      ),
    );
  }

  Widget _buildLanguageChip(String native, String english) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20), border: Border.all(color: AppColors.surfaceLight)),
      child: Column(children: [
        Text(native, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        Text(english, style: const TextStyle(fontSize: 10, color: AppColors.textSecondary)),
      ]),
    );
  }

  Widget _buildResponseView(Map<String, dynamic> response) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: EmergencyCard(
        title: 'EMERGENCY PRIORITY: ${response['priority']}',
        level: response['priority'] == 'HIGH' || response['priority'] == 'CRITICAL' ? EmergencyLevel.critical : EmergencyLevel.medium,
        items: List<String>.from(response['detected_situation'] ?? []),
        actions: List<String>.from(response['recommended_actions'] ?? []),
        confidence: response['confidence'] as int?,
        onNewAnalysis: () => ref.read(voiceStateProvider.notifier).state = null,
      ),
    );
  }

  Widget _buildInputArea() {
    return Container(
      padding: EdgeInsets.only(left: 20, right: 20, top: 16, bottom: MediaQuery.of(context).padding.bottom + 16),
      decoration: BoxDecoration(color: AppColors.surface, boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10, offset: const Offset(0, -2))]),
      child: Row(children: [
        Expanded(child: Container(padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14), decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(12)), child: Row(children: [
          const Icon(Icons.mic_rounded, color: AppColors.textSecondary, size: 20),
          const SizedBox(width: 12),
          Text(_isListening ? 'Listening...' : 'Hold to speak', style: const TextStyle(fontSize: 14, color: AppColors.textSecondary)),
        ]))),
        const SizedBox(width: 16),
        GestureDetector(
          onTapDown: (_) => setState(() => _isListening = true),
          onTapUp: (_) => _processVoice(),
          onTapCancel: () => setState(() => _isListening = false),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 64, height: 64,
            decoration: BoxDecoration(gradient: _isListening ? AppColors.alertGradient : AppColors.primaryGradient, borderRadius: BorderRadius.circular(32), boxShadow: [BoxShadow(color: (_isListening ? AppColors.alert : AppColors.primary).withOpacity(0.4), blurRadius: _isListening ? 20 : 10, offset: const Offset(0, 4))]),
            child: Icon(_isListening ? Icons.stop_rounded : Icons.mic_rounded, color: Colors.white, size: 32),
          ),
        ),
      ]),
    );
  }

  Future<void> _processVoice() async {
    setState(() => _isListening = false);
    await Future.delayed(const Duration(seconds: 2));
    ref.read(voiceStateProvider.notifier).state = {
      'priority': 'HIGH',
      'detected_situation': ['Flood intrusion detected', 'Possible injury to family member', 'Immediate relocation required'],
      'recommended_actions': ['Move victim to elevated dry area', 'Avoid contaminated floodwater', 'Apply basic first aid if trained', 'Seek nearest relief shelter'],
      'confidence': 97,
    };
  }
}