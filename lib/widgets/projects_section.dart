import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';

class ProjectsSection extends StatelessWidget {
  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 80),
      color: AppColors.background,
      child: Column(
        children: [
          const FadeSlideTransition(
            delay: Duration(milliseconds: 100),
            child: SectionHeader(
              title: 'Projects',
              subtitle: 'Some things I\'ve built',
            ),
          ),
          const SizedBox(height: 48),

          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 900),
            child: LayoutBuilder(
              builder: (context, constraints) {
                final crossAxisCount = constraints.maxWidth > 600 ? 2 : 1;
                return GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: crossAxisCount,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20,
                    childAspectRatio: crossAxisCount == 2 ? 1.05 : 1.6,
                  ),
                  itemCount: PortfolioData.projects.length,
                  itemBuilder: (context, index) {
                    return FadeSlideTransition(
                      delay: Duration(milliseconds: 200 + index * 150),
                      child: _ProjectCard(
                        project: PortfolioData.projects[index],
                        index: index,
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Project Card
// ─────────────────────────────────────────────
class _ProjectCard extends StatefulWidget {
  final Map<String, dynamic> project;
  final int index;

  const _ProjectCard({required this.project, required this.index});

  @override
  State<_ProjectCard> createState() => _ProjectCardState();
}

class _ProjectCardState extends State<_ProjectCard> {
  bool _hovering = false;

  IconData _getProjectIcon(String title) {
    switch (title) {
      case 'ShopZone':
        return Icons.shopping_bag_rounded;
      case 'SkyView':
        return Icons.cloud_rounded;
      case 'TaskFlow':
        return Icons.task_alt_rounded;
      case 'ConnectUp':
        return Icons.forum_rounded;
      default:
        return Icons.code_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final gradientColors = (widget.project['gradient'] as List<dynamic>)
        .map((c) => Color(c as int))
        .toList();
    final techList = (widget.project['tech'] as List<dynamic>).cast<String>();

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        transform: Matrix4.diagonal3Values(
          _hovering ? 1.03 : 1.0,
          _hovering ? 1.03 : 1.0,
          1.0,
        ),
        transformAlignment: Alignment.center,
        child: GlassContainer(
          padding: EdgeInsets.zero,
          borderColor: _hovering
              ? gradientColors[0].withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Gradient Header ──
              Container(
                height: 100,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      gradientColors[0].withValues(alpha: 0.25),
                      gradientColors[1].withValues(alpha: 0.15),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(20),
                    topRight: Radius.circular(20),
                  ),
                ),
                child: Stack(
                  children: [
                    // Decorative circles
                    Positioned(
                      right: -20,
                      top: -20,
                      child: Container(
                        width: 80,
                        height: 80,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: gradientColors[0].withValues(alpha: 0.15),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 30,
                      bottom: -15,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: gradientColors[1].withValues(alpha: 0.12),
                        ),
                      ),
                    ),
                    // Icon
                    Center(
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(colors: gradientColors),
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: _hovering
                              ? [
                                  BoxShadow(
                                    color: gradientColors[0].withValues(alpha: 0.4),
                                    blurRadius: 20,
                                  ),
                                ]
                              : [],
                        ),
                        child: Icon(
                          _getProjectIcon(widget.project['title'] as String),
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Content ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Title
                      Text(
                        widget.project['title'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 18,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        widget.project['subtitle'] as String,
                        style: GoogleFonts.poppins(
                          fontSize: 13,
                          fontWeight: FontWeight.w500,
                          color: gradientColors[0],
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Description
                      Expanded(
                        child: Text(
                          widget.project['description'] as String,
                          style: GoogleFonts.poppins(
                            fontSize: 13,
                            height: 1.6,
                            color: AppColors.textSecondary,
                          ),
                          maxLines: 3,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(height: 12),

                      // Tech tags
                      Wrap(
                        spacing: 8,
                        runSpacing: 6,
                        children: techList.map((tech) {
                          return Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 10,
                              vertical: 5,
                            ),
                            decoration: BoxDecoration(
                              color: gradientColors[0].withValues(alpha: 0.12),
                              borderRadius: BorderRadius.circular(8),
                              border: Border.all(
                                color: gradientColors[0].withValues(alpha: 0.25),
                              ),
                            ),
                            child: Text(
                              tech,
                              style: GoogleFonts.firaCode(
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                                color: gradientColors[0],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
