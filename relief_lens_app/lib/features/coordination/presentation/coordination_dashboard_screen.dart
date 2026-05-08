import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';

class CoordinationDashboardScreen extends ConsumerWidget {
  const CoordinationDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: const Text('Coordination Dashboard'), actions: [IconButton(icon: const Icon(Icons.refresh_rounded), onPressed: () {})]),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            const SizedBox(height: 24),
            _buildAlertCards(),
            const SizedBox(height: 24),
            _buildShelterSection(),
            const SizedBox(height: 24),
            _buildRescueQueue(),
            const SizedBox(height: 24),
            _buildQuickStats(),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceLight)),
      child: Row(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: AppColors.primary.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: const Icon(Icons.volunteer_activism_rounded, color: AppColors.primary, size: 24)),
        const SizedBox(width: 14),
        const Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Text('NGO/Volunteer Dashboard', style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          SizedBox(height: 2),
          Text('Real-time coordination status', style: TextStyle(fontSize: 12, color: AppColors.textSecondary)),
        ])),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
          decoration: BoxDecoration(color: AppColors.success.withOpacity(0.15), borderRadius: BorderRadius.circular(20)),
          child: Row(mainAxisSize: MainAxisSize.min, children: [
            Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.success, shape: BoxShape.circle)),
            const SizedBox(width: 6),
            const Text('LIVE', style: TextStyle(fontSize: 11, fontWeight: FontWeight.w700, color: AppColors.success)),
          ]),
        ),
      ]),
    );
  }

  Widget _buildAlertCards() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Emergency Alerts', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _buildAlertCard(Icons.warning_rounded, 'Emergency', '12', 'Critical', AppColors.danger)),
          const SizedBox(width: 12),
          Expanded(child: _buildAlertCard(Icons.medical_services_rounded, 'Medical', '8', 'High', AppColors.alert)),
          const SizedBox(width: 12),
          Expanded(child: _buildAlertCard(Icons.restaurant_rounded, 'Food', '5', 'Moderate', AppColors.warning)),
        ]),
      ],
    );
  }

  Widget _buildAlertCard(IconData icon, String title, String count, String severity, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: color.withOpacity(0.3))),
      child: Column(children: [
        Container(padding: const EdgeInsets.all(10), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(10)), child: Icon(icon, color: color, size: 24)),
        const SizedBox(height: 12),
        Text(count, style: TextStyle(fontSize: 28, fontWeight: FontWeight.w800, color: color)),
        const SizedBox(height: 4),
        Text(title, style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.textSecondary)),
        const SizedBox(height: 8),
        Container(padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Text(severity, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: color))),
      ]),
    );
  }

  Widget _buildShelterSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Shelter Occupancy', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceLight)),
          child: Column(children: [
            _buildShelterBar('Zone A Shelter', 0.80, 400, 500, AppColors.warning),
            const SizedBox(height: 16),
            _buildShelterBar('Zone B Shelter', 0.50, 150, 300, AppColors.success),
            const SizedBox(height: 16),
            _buildShelterBar('Zone C Shelter', 0.95, 190, 200, AppColors.danger),
          ]),
        ),
      ],
    );
  }

  Widget _buildShelterBar(String name, double occupancy, int current, int capacity, Color color) {
    final isFull = occupancy >= 0.95;
    return Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
      Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Text(name, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.textPrimary)),
        Row(children: [
          Text('$current/$capacity', style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600, color: AppColors.textSecondary)),
          if (isFull) ...[
            const SizedBox(width: 8),
            Container(padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2), decoration: BoxDecoration(color: AppColors.danger.withOpacity(0.15), borderRadius: BorderRadius.circular(4)), child: const Text('FULL', style: TextStyle(fontSize: 9, fontWeight: FontWeight.w700, color: AppColors.danger))),
          ],
        ]),
      ]),
      const SizedBox(height: 10),
      Stack(children: [
        Container(height: 8, decoration: BoxDecoration(color: AppColors.surfaceLight, borderRadius: BorderRadius.circular(4))),
        FractionallySizedBox(widthFactor: occupancy, child: Container(height: 8, decoration: BoxDecoration(color: color, borderRadius: BorderRadius.circular(4)))),
      ]),
      const SizedBox(height: 6),
      Text('${(occupancy * 100).toInt()}% occupied', style: TextStyle(fontSize: 11, color: color, fontWeight: FontWeight.w500)),
    ]);
  }

  Widget _buildRescueQueue() {
    final queue = [
      {'priority': 1, 'type': 'House Collapse', 'details': '3 people trapped', 'location': 'Sector 7', 'status': 'Critical', 'color': AppColors.danger},
      {'priority': 2, 'type': 'Flood Rescue', 'details': 'Family of 4', 'location': 'Sector 12', 'status': 'High', 'color': AppColors.alert},
      {'priority': 3, 'type': 'Medical Emergency', 'details': 'Elderly injured', 'location': 'Sector 5', 'status': 'Moderate', 'color': AppColors.warning},
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Rescue Priority Queue', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        ...queue.map((item) => Container(
          margin: const EdgeInsets.only(bottom: 12),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: (item['color'] as Color).withOpacity(0.3))),
          child: Row(children: [
            Container(width: 36, height: 36, decoration: BoxDecoration(color: (item['color'] as Color).withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Center(child: Text('#${item['priority']}', style: TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: item['color'] as Color)))),
            const SizedBox(width: 14),
            Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Row(children: [Icon(Icons.warning_rounded, size: 16, color: item['color'] as Color), const SizedBox(width: 6), Text(item['type'] as String, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600, color: AppColors.textPrimary))]),
              const SizedBox(height: 4),
              Text('${item['details']} • ${item['location']}', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
            ])),
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6), decoration: BoxDecoration(color: (item['color'] as Color).withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Text(item['status'] as String, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w600, color: item['color'] as Color))),
          ]),
        )),
      ],
    );
  }

  Widget _buildQuickStats() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Quick Stats', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 16),
        Row(children: [
          Expanded(child: _buildStatCard(Icons.people_rounded, 'People Rescued', '147', '+12 today', AppColors.success)),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard(Icons.local_hospital_rounded, 'Medical Aid', '89', '+5 today', AppColors.alert)),
        ]),
        const SizedBox(height: 12),
        Row(children: [
          Expanded(child: _buildStatCard(Icons.restaurant_rounded, 'Meals Served', '2.4K', '+320 today', AppColors.primary)),
          const SizedBox(width: 12),
          Expanded(child: _buildStatCard(Icons.water_drop_rounded, 'Water Distributed', '5.2K L', '+800 L today', AppColors.secondary)),
        ]),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String label, String value, String change, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceLight)),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Row(children: [
          Container(padding: const EdgeInsets.all(8), decoration: BoxDecoration(color: color.withOpacity(0.15), borderRadius: BorderRadius.circular(8)), child: Icon(icon, color: color, size: 20)),
          const Spacer(),
          Text(change, style: const TextStyle(fontSize: 10, color: AppColors.success, fontWeight: FontWeight.w500)),
        ]),
        const SizedBox(height: 12),
        Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w700, color: AppColors.textPrimary)),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
      ]),
    );
  }
}