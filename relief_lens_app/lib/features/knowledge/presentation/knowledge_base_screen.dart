import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:relief_lens_ai/core/theme/app_colors.dart';

final knowledgeSearchProvider = StateProvider<String>((ref) => '');

class KnowledgeBaseScreen extends ConsumerStatefulWidget {
  const KnowledgeBaseScreen({super.key});
  @override
  ConsumerState<KnowledgeBaseScreen> createState() => _KnowledgeBaseScreenState();
}

class _KnowledgeBaseScreenState extends ConsumerState<KnowledgeBaseScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List<Map<String, dynamic>> _items = [
    {'id': '1', 'title': 'Flood Emergency Response', 'category': 'Flood', 'preview': 'Essential guidelines for flood emergency situations...', 'content': 'FLOOD EMERGENCY RESPONSE\n\n1. Move to higher ground immediately\n2. Avoid walking or driving through floodwater\n3. Do not touch electrical equipment if wet\n4. Follow evacuation orders from authorities', 'tags': ['Flood', 'Emergency', 'Evacuation']},
    {'id': '2', 'title': 'First Aid for Injuries', 'category': 'Medical', 'preview': 'Basic first aid procedures for common injuries...', 'content': 'BASIC FIRST AID\n\nBLEEDING:\n1. Apply direct pressure with clean cloth\n2. Elevate injured area above heart\n3. Seek medical help for severe bleeding\n\nBURNS:\n1. Cool burn under running water 10-20 minutes\n2. Cover with sterile bandage', 'tags': ['First Aid', 'Medical', 'Injuries']},
    {'id': '3', 'title': 'Earthquake Safety', 'category': 'Earthquake', 'preview': 'What to do during an earthquake...', 'content': 'EARTHQUAKE SAFETY\n\nDURING:\n- DROP to hands and knees\n- Take COVER under sturdy furniture\n- HOLD ON until shaking stops\n\nAFTER:\n1. Expect aftershocks\n2. Check for injuries\n3. Be cautious of debris', 'tags': ['Earthquake', 'Safety', 'Drop Cover Hold']},
    {'id': '4', 'title': 'Cyclone Preparedness', 'category': 'Cyclone', 'preview': 'Preparation and response for cyclones...', 'content': 'CYCLONE PREPAREDNESS\n\nBEFORE:\n- Secure loose items\n- Stock up on essentials\n- Know evacuation routes\n\nDURING:\n- Stay indoors\n- Go to interior room\n- Listen to broadcasts', 'tags': ['Cyclone', 'Emergency', 'Preparation']},
  ];

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final searchQuery = ref.watch(knowledgeSearchProvider);
    final filteredItems = _items.where((item) => searchQuery.isEmpty || item['title'].toString().toLowerCase().contains(searchQuery.toLowerCase())).toList();

    return Scaffold(
      appBar: AppBar(title: const Text('Knowledge Base')),
      body: Column(children: [
        Padding(
          padding: const EdgeInsets.all(20),
          child: TextField(
            controller: _searchController,
            onChanged: (value) => ref.read(knowledgeSearchProvider.notifier).state = value,
            decoration: const InputDecoration(hintText: 'Search emergency guides...', prefixIcon: Icon(Icons.search_rounded, color: AppColors.textSecondary)),
          ),
        ),
        Expanded(child: filteredItems.isEmpty ? _buildEmptyState() : _buildKnowledgeList(filteredItems)),
      ]),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Container(width: 80, height: 80, decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(20)), child: const Icon(Icons.search_off_rounded, color: AppColors.textSecondary, size: 40)),
        const SizedBox(height: 20),
        const Text('No results found', style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
        const SizedBox(height: 8),
        const Text('Try different keywords', style: TextStyle(fontSize: 14, color: AppColors.textSecondary)),
      ]),
    );
  }

  Widget _buildKnowledgeList(List<Map<String, dynamic>> items) {
    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      itemCount: items.length,
      itemBuilder: (context, index) => _buildKnowledgeCard(items[index]),
    );
  }

  Widget _buildKnowledgeCard(Map<String, dynamic> item) {
    return GestureDetector(
      onTap: () => _showKnowledgeDetail(item),
      child: Container(
        margin: const EdgeInsets.only(bottom: 12),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(color: AppColors.surface, borderRadius: BorderRadius.circular(12), border: Border.all(color: AppColors.surfaceLight)),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(children: [
            Container(padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4), decoration: BoxDecoration(color: _getCategoryColor(item['category']).withOpacity(0.15), borderRadius: BorderRadius.circular(12)), child: Text(item['category'], style: TextStyle(fontSize: 11, fontWeight: FontWeight.w600, color: _getCategoryColor(item['category'])))),
            const Spacer(),
            const Icon(Icons.arrow_forward_ios_rounded, size: 16, color: AppColors.textSecondary),
          ]),
          const SizedBox(height: 12),
          Text(item['title'], style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: AppColors.textPrimary)),
          const SizedBox(height: 6),
          Text(item['preview'], style: const TextStyle(fontSize: 13, color: AppColors.textSecondary)),
        ]),
      ),
    );
  }

  Color _getCategoryColor(String category) {
    switch (category) { case 'Flood': return AppColors.secondary; case 'Medical': return AppColors.danger; case 'Earthquake': return AppColors.alert; default: return AppColors.primary; }
  }

  void _showKnowledgeDetail(Map<String, dynamic> item) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DraggableScrollableSheet(
        initialChildSize: 0.9,
        builder: (context, scrollController) => Container(
          decoration: const BoxDecoration(color: AppColors.background, borderRadius: BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20))),
          child: Column(children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: const BoxDecoration(border: Border(bottom: BorderSide(color: AppColors.surfaceLight))),
              child: Row(children: [
                Expanded(child: Text(item['title'], style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.textPrimary))),
                IconButton(icon: const Icon(Icons.close_rounded), onPressed: () => Navigator.pop(context)),
              ]),
            ),
            Expanded(child: SingleChildScrollView(controller: scrollController, padding: const EdgeInsets.all(20), child: Text(item['content'], style: const TextStyle(fontSize: 14, color: AppColors.textPrimary, height: 1.7)))),
          ]),
        ),
      ),
    );
  }
}