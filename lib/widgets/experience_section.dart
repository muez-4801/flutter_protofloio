import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';

class ExperienceSection extends StatelessWidget {
  const ExperienceSection({super.key});

  @override
  Widget build(BuildContext context) {
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
              title: 'Experience',
              subtitle: 'My journey so far',
            ),
          ),
          const SizedBox(height: 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: PortfolioData.experience.asMap().entries.map((entry) {
                final index = entry.key;
                final exp = entry.value;
                final isLast = index == PortfolioData.experience.length - 1;
                return FadeSlideTransition(
                  delay: Duration(milliseconds: 200 + index * 200),
                  child: _TimelineItem(
                    experience: exp,
                    index: index,
                    isLast: isLast,
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
// Timeline Item
// ─────────────────────────────────────────────
class _TimelineItem extends StatefulWidget {
  final Map<String, dynamic> experience;
  final int index;
  final bool isLast;

  const _TimelineItem({
    required this.experience,
    required this.index,
    required this.isLast,
  });

  @override
  State<_TimelineItem> createState() => _TimelineItemState();
}

class _TimelineItemState extends State<_TimelineItem> {
  bool _hovering = false;

  static const List<List<Color>> _dotColors = [
    [AppColors.primaryPurple, AppColors.electricBlue],
    [AppColors.electricBlue, AppColors.cyan],
    [AppColors.hotPink, AppColors.primaryPurple],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _dotColors[widget.index % _dotColors.length];
    final isEducation = widget.experience['type'] == 'education';

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: IntrinsicHeight(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Timeline Line + Dot ──
            SizedBox(
              width: 40,
              child: Column(
                children: [
                  // Dot
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 300),
                    width: _hovering ? 20 : 16,
                    height: _hovering ? 20 : 16,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(colors: colors),
                      boxShadow: [
                        BoxShadow(
                          color: colors[0].withValues(alpha: _hovering ? 0.6 : 0.3),
                          blurRadius: _hovering ? 15 : 8,
                          spreadRadius: _hovering ? 2 : 0,
                        ),
                      ],
                    ),
                  ),
                  // Line
                  if (!widget.isLast)
                    Expanded(
                      child: Container(
                        width: 2,
                        margin: const EdgeInsets.symmetric(vertical: 4),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              colors[0].withValues(alpha: 0.5),
                              colors[1].withValues(alpha: 0.1),
                            ],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter,
                          ),
                        ),
                      ),
                    ),
                ],
              ),
            ),
            const SizedBox(width: 16),

            // ── Content Card ──
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 32),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 300),
                  transform: Matrix4.diagonal3Values(
                    _hovering ? 1.02 : 1.0,
                    _hovering ? 1.02 : 1.0,
                    1.0,
                  ),
                  transformAlignment: Alignment.centerLeft,
                  child: GlassContainer(
                    borderColor: _hovering
                        ? colors[0].withValues(alpha: 0.4)
                        : Colors.white.withValues(alpha: 0.08),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Period badge
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 12,
                            vertical: 5,
                          ),
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                colors[0].withValues(alpha: 0.2),
                                colors[1].withValues(alpha: 0.1),
                              ],
                            ),
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(
                              color: colors[0].withValues(alpha: 0.3),
                            ),
                          ),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Icon(
                                isEducation
                                    ? Icons.school_rounded
                                    : Icons.work_rounded,
                                size: 14,
                                color: colors[0],
                              ),
                              const SizedBox(width: 6),
                              Text(
                                widget.experience['period'] as String,
                                style: GoogleFonts.firaCode(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: colors[0],
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 14),

                        // Title
                        Text(
                          widget.experience['title'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 4),

                        // Organization
                        Text(
                          widget.experience['organization'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: colors[0],
                          ),
                        ),
                        const SizedBox(height: 12),

                        // Description
                        Text(
                          widget.experience['description'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            height: 1.7,
                            color: AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
