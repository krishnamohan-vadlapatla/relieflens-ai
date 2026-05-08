import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';
import 'package:relief_lens_ai/app.dart';

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 24),
              _buildStatusCard(),
              const SizedBox(height: 24),
              _buildQuickActions(context, ref),
              const SizedBox(height: 24),
              _buildEmergencyContact(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
              width: 48, height: 48,
              decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(12)),
              child: const Icon(Icons.shield_rounded, color: Colors.white, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('ReliefLens AI', style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: AppColors.textPrimary)),
                  const SizedBox(height: 4),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
                        const SizedBox(width: 6),
                        const Text('OFFLINE MODE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: AppColors.success, letterSpacing: 0.5)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        const Text('Offline intelligence for\ndisaster survival', style: TextStyle(fontSize: 16, color: AppColors.textSecondary, height: 1.4)),
      ],
    );
  }

  Widget _buildStatusCard() {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(gradient: AppColors.primaryGradient, borderRadius: BorderRadius.circular(16), boxShadow: [BoxShadow(color: AppColors.primary.withOpacity(0.4), blurRadius: 20, offset: const Offset(0, 8))]),
      child: Row(
        children: [
          _buildStatusItem(Icons.cloud_off_rounded, 'Mode', 'Offline', AppColors.success),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
          _buildStatusItem(Icons.psychology_rounded, 'AI Status', 'Ready', AppColors.success),
          Container(width: 1, height: 40, color: Colors.white.withOpacity(0.2)),
          _buildStatusItem(Icons.storage_rounded, 'Knowledge', '12 Docs', AppColors.secondary),
        ],
      ),
    );
  }

  Widget _buildStatusItem(IconData icon, String label, String value, Color color) {
    return Expanded(
      child: Column(children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 8),
        Text(value, style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700, color: Colors.white)),
        const SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12, color: Colors.white.withOpacity(0.8))),
      ]),
    );
  }

  Widget _buildQuickActions(BuildContext context, WidgetRef ref) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Actions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.camera_alt_rounded, 'Analyze\nDisaster', 'AI-powered analysis', AppColors.alertGradient, () => ref.read(currentIndexProvider.notifier).state = 1)),
            const SizedBox(width: 12),
            Expanded(child: _buildFeatureCard(Icons.mic_rounded, 'Voice\nAssistant', 'Multilingual help', AppColors.primaryGradient, () => ref.read(currentIndexProvider.notifier).state = 2)),
          ],
        ),
        const SizedBox(height: 12),
        Row(
          children: [
            Expanded(child: _buildFeatureCard(Icons.dashboard_rounded, 'Coordination\nDashboard', 'Real-time status', [AppColors.success, const Color(0xFF059669)], () => ref.read(currentIndexProvider.notifier).state = 3)),
            const SizedBox(width: 12),
            Expanded(child: _buildFeatureCard(Icons.menu_book_rounded, 'Knowledge\nBase', 'Emergency guides', [const Color(0xFF8B5CF6), const Color(0xFF7C3AED)], () => ref.read(currentIndexProvider.notifier).state = 4)),
          ],
        ),
      ],
    );
  }

  Widget _buildFeatureCard(IconData icon, String title, String subtitle, List<Color> gradient, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(16), border: Border.all(color: AppColors.surfaceLight)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(width: 48, height: 48, decoration: BoxDecoration(gradient: LinearGradient(colors: gradient, begin: Alignment.topLeft, end: Alignment.bottomRight), borderRadius: BorderRadius.circular(12)), child: Icon(icon, color: Colors.white, size: 24)),
            const SizedBox(height: 14),
            Text(title, style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w700, color: AppColors.textPrimary, height: 1.2)),
            const SizedBox(height: 6),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }

  Widget _buildEmergencyContact() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Emergency Contacts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        _buildContactTile(Icons.local_fire_department_rounded, 'Fire Department', '101', AppColors.danger),
        const SizedBox(height: 12),
        _buildContactTile(Icons.local_hospital_rounded, 'Medical Emergency', '102', AppColors.alert),
        const SizedBox(height: 12),
        _buildContactTile(Icons.police_badge_rounded, 'Police', '100', AppColors.primary),
        const SizedBox(height: 12),
        _buildContactTile(Icons.volunteer_activism_rounded, 'Disaster Relief', '1078', AppColors.success),
      ],
    );
  }

  Widget _buildContactTile(IconData icon, String title, String subtitle, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceLight)),
      child: Row(
        children: [
          Container(width: 44, height: 44, decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 22)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
            Text(subtitle, style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          ])),
          Container(padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Text('CALL', style: TextStyle(fontSize: 12, fontWeight: FontWeight.w700, color: color))),
        ],
      ),
    );
  }
}