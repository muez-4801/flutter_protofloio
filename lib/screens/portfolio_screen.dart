import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';
import '../widgets/hero_section.dart';
import '../widgets/about_section.dart';
import '../widgets/skills_section.dart';
import '../widgets/projects_section.dart';
import '../widgets/experience_section.dart';
import '../widgets/contact_section.dart';

class PortfolioScreen extends StatefulWidget {
  const PortfolioScreen({super.key});

  @override
  State<PortfolioScreen> createState() => _PortfolioScreenState();
}

class _PortfolioScreenState extends State<PortfolioScreen> {
  final ScrollController _scrollController = ScrollController();
  final List<GlobalKey> _sectionKeys = List.generate(6, (_) => GlobalKey());
  int _activeSection = 0;
  bool _showNavBar = false;

  static const List<String> _navLabels = [
    'Home',
    'About',
    'Skills',
    'Projects',
    'Experience',
    'Contact',
  ];

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scrollController.removeListener(_onScroll);
    _scrollController.dispose();
    super.dispose();
  }

  void _onScroll() {
    // Show/hide floating nav bar after hero section
    final showNav = _scrollController.offset > 200;
    if (showNav != _showNavBar) {
      setState(() => _showNavBar = showNav);
    }

    // Update active section based on scroll position
    for (int i = _sectionKeys.length - 1; i >= 0; i--) {
      final key = _sectionKeys[i];
      final context = key.currentContext;
      if (context != null) {
        final box = context.findRenderObject() as RenderBox;
        final position = box.localToGlobal(Offset.zero).dy;
        if (position <= 200) {
          if (_activeSection != i) {
            setState(() => _activeSection = i);
          }
          break;
        }
      }
    }
  }

  void _scrollToSection(int index) {
    final context = _sectionKeys[index].currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 800),
        curve: Curves.easeOutCubic,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      body: Stack(
        children: [
          // ── Main Content ──
          SingleChildScrollView(
            controller: _scrollController,
            physics: const BouncingScrollPhysics(),
            child: Column(
              children: [
                // Hero
                Container(
                  key: _sectionKeys[0],
                  child: HeroSection(
                    onScrollDown: () => _scrollToSection(1),
                  ),
                ),
                // About
                Container(
                  key: _sectionKeys[1],
                  child: const AboutSection(),
                ),
                // Skills
                Container(
                  key: _sectionKeys[2],
                  child: const SkillsSection(),
                ),
                // Projects
                Container(
                  key: _sectionKeys[3],
                  child: const ProjectsSection(),
                ),
                // Experience
                Container(
                  key: _sectionKeys[4],
                  child: const ExperienceSection(),
                ),
                // Contact
                Container(
                  key: _sectionKeys[5],
                  child: const ContactSection(),
                ),
              ],
            ),
          ),

          // ── Floating Navigation Bar ──
          AnimatedPositioned(
            duration: const Duration(milliseconds: 400),
            curve: Curves.easeOutCubic,
            top: _showNavBar ? 16 : -80,
            left: 0,
            right: 0,
            child: Center(
              child: _FloatingNavBar(
                labels: _navLabels,
                activeIndex: _activeSection,
                onTap: _scrollToSection,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Floating Navigation Bar
// ─────────────────────────────────────────────
class _FloatingNavBar extends StatelessWidget {
  final List<String> labels;
  final int activeIndex;
  final ValueChanged<int> onTap;

  const _FloatingNavBar({
    required this.labels,
    required this.activeIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GlassContainer(
      blur: 15,
      borderRadius: 30,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
      borderColor: Colors.white.withValues(alpha: 0.15),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: labels.asMap().entries.map((entry) {
          final index = entry.key;
          final label = entry.value;
          final isActive = index == activeIndex;

          return GestureDetector(
            onTap: () => onTap(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
              decoration: BoxDecoration(
                gradient: isActive ? AppColors.primaryGradient : null,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Text(
                label,
                style: GoogleFonts.poppins(
                  fontSize: 12,
                  fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                  color: isActive
                      ? Colors.white
                      : AppColors.textSecondary,
                  letterSpacing: 0.3,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
