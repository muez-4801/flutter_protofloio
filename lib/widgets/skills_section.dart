import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';

class SkillsSection extends StatelessWidget {
  const SkillsSection({super.key});

  @override
  Widget build(BuildContext context) {
    // Group skills by category
    final grouped = <String, List<Map<String, dynamic>>>{};
    for (final skill in PortfolioData.skills) {
      final cat = skill['category'] as String;
      grouped.putIfAbsent(cat, () => []).add(skill);
    }

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.background, AppColors.surface, AppColors.background],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
      child: Column(
        children: [
          const FadeSlideTransition(
            delay: Duration(milliseconds: 100),
            child: SectionHeader(
              title: 'Skills',
              subtitle: 'Technologies I work with',
            ),
          ),
          const SizedBox(height: 48),

          // Skill category cards
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 800),
            child: Column(
              children: grouped.entries.map((entry) {
                final catIndex =
                    grouped.keys.toList().indexOf(entry.key);
                return Padding(
                  padding: const EdgeInsets.only(bottom: 32),
                  child: FadeSlideTransition(
                    delay: Duration(milliseconds: 200 + catIndex * 200),
                    child: _SkillCategory(
                      category: entry.key,
                      skills: entry.value,
                      categoryIndex: catIndex,
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Skill Category Card
// ─────────────────────────────────────────────
class _SkillCategory extends StatelessWidget {
  final String category;
  final List<Map<String, dynamic>> skills;
  final int categoryIndex;

  const _SkillCategory({
    required this.category,
    required this.skills,
    required this.categoryIndex,
  });

  @override
  Widget build(BuildContext context) {
    final colors = PortfolioData.categoryColors[category] ??
        [AppColors.primaryPurple, AppColors.electricBlue];
    final icon = PortfolioData.categoryIcons[category] ?? Icons.code;

    return GlassContainer(
      padding: const EdgeInsets.all(28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Category header
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: colors),
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: colors[0].withValues(alpha: 0.3),
                      blurRadius: 12,
                    ),
                  ],
                ),
                child: Icon(icon, size: 22, color: Colors.white),
              ),
              const SizedBox(width: 16),
              Text(
                category,
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),

          // Skill items
          ...skills.asMap().entries.map((entry) {
            final i = entry.key;
            final skill = entry.value;
            final level = (skill['level'] as num).toDouble();
            return Padding(
              padding: const EdgeInsets.only(bottom: 18),
              child: StaggeredItem(
                index: i,
                baseDelayMs: 120,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          skill['name'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        Text(
                          '${(level * 100).round()}%',
                          style: GoogleFonts.firaCode(
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                            color: colors[0],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    AnimatedSkillBar(
                      level: level,
                      gradient: LinearGradient(colors: colors),
                      delay: Duration(milliseconds: 400 + i * 100),
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
}
