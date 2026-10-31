import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';

class AboutSection extends StatelessWidget {
  const AboutSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: AppColors.background,
      child: Column(
        children: [
          // ── Section Header ──
          const FadeSlideTransition(
            delay: Duration(milliseconds: 100),
            child: SectionHeader(
              title: 'About Me',
              subtitle: 'Get to know me better',
            ),
          ),
          const SizedBox(height: 48),

          // ── Bio Card ──
          FadeSlideTransition(
            delay: const Duration(milliseconds: 300),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 700),
              child: GlassContainer(
                padding: const EdgeInsets.all(32),
                child: Column(
                  children: [
                    // Quote icon
                    ShaderMask(
                      shaderCallback: (bounds) =>
                          AppColors.primaryGradient.createShader(bounds),
                      blendMode: BlendMode.srcIn,
                      child: const Icon(
                        Icons.format_quote_rounded,
                        size: 40,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      PortfolioData.bio,
                      textAlign: TextAlign.center,
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                        height: 1.8,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 48),

          // ── Stats Row ──
          FadeSlideTransition(
            delay: const Duration(milliseconds: 500),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 600),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  PortfolioData.stats.length,
                  (index) => StaggeredItem(
                    index: index,
                    baseDelayMs: 150,
                    child: _StatCard(
                      value: PortfolioData.stats[index]['value']!,
                      label: PortfolioData.stats[index]['label']!,
                      index: index,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Stat Card
// ─────────────────────────────────────────────
class _StatCard extends StatefulWidget {
  final String value;
  final String label;
  final int index;

  const _StatCard({
    required this.value,
    required this.label,
    required this.index,
  });

  @override
  State<_StatCard> createState() => _StatCardState();
}

class _StatCardState extends State<_StatCard> {
  bool _hovering = false;

  static const List<List<Color>> _gradients = [
    [AppColors.primaryPurple, AppColors.electricBlue],
    [AppColors.electricBlue, AppColors.cyan],
    [AppColors.cyan, AppColors.amber],
    [AppColors.hotPink, AppColors.primaryPurple],
  ];

  @override
  Widget build(BuildContext context) {
    final colors = _gradients[widget.index % _gradients.length];
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _hovering ? 1.08 : 1.0,
          _hovering ? 1.08 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: GlassContainer(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
          borderColor: _hovering
              ? colors[0].withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
          child: Column(
            children: [
              ShaderMask(
                shaderCallback: (bounds) => LinearGradient(colors: colors)
                    .createShader(bounds),
                blendMode: BlendMode.srcIn,
                child: Text(
                  widget.value,
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  color: AppColors.textMuted,
                  fontWeight: FontWeight.w500,
                  letterSpacing: 0.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
