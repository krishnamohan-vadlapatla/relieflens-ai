import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';
import 'package:relief_lens_ai/features/home/presentation/home_screen.dart';
import 'package:relief_lens_ai/features/image_analyzer/presentation/image_analyzer_screen.dart';
import 'package:relief_lens_ai/features/voice_assistant/presentation/voice_assistant_screen.dart';
import 'package:relief_lens_ai/features/coordination/presentation/coordination_dashboard_screen.dart';
import 'package:relief_lens_ai/features/knowledge/presentation/knowledge_base_screen.dart';

final currentIndexProvider = StateProvider<int>((ref) => 0);

class ReliefLensApp extends ConsumerWidget {
  const ReliefLensApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'ReliefLens AI',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: const ColorScheme.dark(
          primary: AppColors.primary,
          secondary: AppColors.secondary,
          surface: AppColors.surface,
        ),
      ),
      home: const MainScreen(),
    );
  }
}

class MainScreen extends ConsumerWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentIndex = ref.watch(currentIndexProvider);
    final screens = [
      const HomeScreen(),
      const ImageAnalyzerScreen(),
      const VoiceAssistantScreen(),
      const CoordinationDashboardScreen(),
      const KnowledgeBaseScreen(),
    ];

    return Scaffold(
      body: IndexedStack(index: currentIndex, children: screens),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: AppColors.surface,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.3), blurRadius: 10)],
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _buildNavItem(ref, 0, Icons.home_rounded, 'Home'),
                _buildNavItem(ref, 1, Icons.camera_alt_rounded, 'Analyze'),
                _buildNavItem(ref, 2, Icons.mic_rounded, 'Voice'),
                _buildNavItem(ref, 3, Icons.dashboard_rounded, 'Dashboard'),
                _buildNavItem(ref, 4, Icons.menu_book_rounded, 'Knowledge'),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem(WidgetRef ref, int index, IconData icon, String label) {
    final isSelected = ref.watch(currentIndexProvider) == index;
    return InkWell(
      onTap: () => ref.read(currentIndexProvider.notifier).state = index,
      borderRadius: BorderRadius.circular(12),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.15) : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: isSelected ? AppColors.primary : AppColors.textSecondary, size: 24),
            const SizedBox(height: 4),
            Text(label, style: TextStyle(fontSize: 11, fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400, color: isSelected ? AppColors.primary : AppColors.textSecondary)),
          ],
        ),
      ),
    );
  }
}