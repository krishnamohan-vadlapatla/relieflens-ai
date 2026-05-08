import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';

enum EmergencyLevel { low, medium, high, critical }

class EmergencyCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final EmergencyLevel level;
  final List<String>? items;
  final List<String>? actions;
  final int? confidence;
  final VoidCallback? onNewAnalysis;

  const EmergencyCard({super.key, required this.title, this.subtitle, required this.level, this.items, this.actions, this.confidence, this.onNewAnalysis});

  Color get _borderColor { switch (level) { case EmergencyLevel.low: return AppColors.success; case EmergencyLevel.medium: return AppColors.warning; case EmergencyLevel.high: return AppColors.alert; case EmergencyLevel.critical: return AppColors.danger; } }
  String get _levelLabel { switch (level) { case EmergencyLevel.low: return 'LOW PRIORITY'; case EmergencyLevel.medium: return 'MODERATE'; case EmergencyLevel.high: return 'HIGH PRIORITY'; case EmergencyLevel.critical: return 'CRITICAL'; } }
  IconData get _icon { switch (level) { case EmergencyLevel.low: return Icons.check_circle_rounded; case EmergencyLevel.medium: return Icons.warning_rounded; case EmergencyLevel.high: return Icons.error_rounded; case EmergencyLevel.critical: return Icons.dangerous_rounded; } }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: _borderColor, width: 2), boxShadow: [BoxShadow(color: _borderColor.withOpacity(0.3), blurRadius: 20, offset: const Offset(0, 4))]),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: _borderColor.withOpacity(0.1), borderRadius: const BorderRadius.only(topLeft: Radius.circular(14), topRight: Radius.circular(14))),
          child: Row(children: [
            Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: _borderColor.withOpacity(0.2), borderRadius: BorderRadius.circular(8)), child: Icon(_icon, color: _borderColor, size: 20)),
            const SizedBox(width: 12),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(title, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
              const SizedBox(height: 2),
              Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2), decoration: BoxDecoration(color: _borderColor.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Text(_levelLabel, style: TextStyle(fontSize: 10, fontWeight: FontWeight.w700, color: _borderColor, letterSpacing: 0.5))),
            ])),
          ]),
        ),
        Padding(
          padding: const EdgeInsets.all(16),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            if (subtitle != null) ...[Text(subtitle!, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary)), const SizedBox(height: 12)],
            if (items != null && items!.isNotEmpty) ...[
              const Text('DETECTED RISKS:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
              const SizedBox(height: 8),
              ...items!.map((item) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(margin: const EdgeInsets.only(top: 6), width: 6, height: 6, decoration: BoxDecoration(color: _borderColor, shape: BoxShape.circle)),
                const SizedBox(width: 10),
                Expanded(child: Text(item, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4))),
              ]))),
              const SizedBox(height: 12),
            ],
            if (actions != null && actions!.isNotEmpty) ...[
              const Text('RECOMMENDED ACTIONS:', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.textSecondary, letterSpacing: 0.5)),
              const SizedBox(height: 8),
              ...actions!.asMap().entries.map((entry) => Padding(padding: const EdgeInsets.only(bottom: 6), child: Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Container(width: 20, height: 20, decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.2), borderRadius: BorderRadius.circular(4)), child: Center(child: Text('${entry.key + 1}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.primary)))),
                const SizedBox(width: 10),
                Expanded(child: Text(entry.value, style: const TextStyle(fontSize: 13, color: AppColors.textPrimary, height: 1.4))),
              ]))),
              const SizedBox(height: 8),
            ],
            if (confidence != null) ...[
              const Divider(color: AppColors.surfaceLight, height: 24),
              Row(children: [
                const Icon(Icons.psychology_rounded, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                const Text('AI CONFIDENCE: ', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
                Text('$confidence%', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: _getConfidenceColor(confidence!))),
              ]),
              const SizedBox(height: 8),
              ClipRRect(borderRadius: BorderRadius.circular(4), child: LinearProgressIndicator(value: confidence! / 100, backgroundColor: AppColors.surfaceLight, valueColor: AlwaysStoppedAnimation(_getConfidenceColor(confidence!)), minHeight: 6)),
            ],
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(color: AppColors.warning.withOpacity(0.1), borderRadius: BorderRadius.circular(8), border: Border.all(color: AppColors.warning.withOpacity(0.3))),
              child: const Row(children: [
                Icon(Icons.info_outline_rounded, size: 18, color: AppColors.warning),
                SizedBox(width: 10),
                Expanded(child: Text('This analysis is AI-generated. Always verify with emergency personnel when possible.', style: TextStyle(fontSize: 11, color: AppColors.warning, height: 1.4))),
              ]),
            ),
            if (onNewAnalysis != null) ...[const SizedBox(height: 16), SizedBox(width: double.infinity, child: ElevatedButton.icon(onPressed: onNewAnalysis, icon: const Icon(Icons.refresh_rounded), label: const Text('New Analysis'), style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary)))],
          ]),
        ),
      ]),
    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.1, end: 0);
  }

  Color _getConfidenceColor(int value) { if (value >= 90) return AppColors.success; if (value >= 75) return AppColors.warning; if (value >= 50) return AppColors.alert; return AppColors.danger; }
}