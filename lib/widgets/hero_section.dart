import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';
import 'brand_icons.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback? onScrollDown;

  const HeroSection({super.key, this.onScrollDown});

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _bgController;
  late final AnimationController _pulseController;
  late final AnimationController _typingController;

  String _displayedTitle = '';
  int _charIndex = 0;

  @override
  void initState() {
    super.initState();

    // Background gradient animation
    _bgController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 8),
    )..repeat(reverse: true);

    // Pulse animation for avatar glow
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat(reverse: true);

    // Typewriter effect for subtitle
    _typingController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
    );
    Future.delayed(const Duration(milliseconds: 1200), _typeNextChar);
  }

  void _typeNextChar() {
    if (!mounted) return;
    if (_charIndex < PortfolioData.subtitle.length) {
      setState(() {
        _charIndex++;
        _displayedTitle = PortfolioData.subtitle.substring(0, _charIndex);
      });
      Future.delayed(const Duration(milliseconds: 60), _typeNextChar);
    }
  }

  @override
  void dispose() {
    _bgController.dispose();
    _pulseController.dispose();
    _typingController.dispose();
    super.dispose();
  }

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return SizedBox(
      height: size.height,
      width: double.infinity,
      child: Stack(
        children: [
          // ── Animated Background ──
          AnimatedBuilder(
            animation: _bgController,
            builder: (context, _) {
              return Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Color.lerp(const Color(0xFF0A0E21), const Color(0xFF1A1040),
                          _bgController.value)!,
                      Color.lerp(const Color(0xFF1A1040), const Color(0xFF0D2137),
                          _bgController.value)!,
                      Color.lerp(const Color(0xFF0D1B2A), const Color(0xFF0A0E21),
                          _bgController.value)!,
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
              );
            },
          ),

          // ── Floating Gradient Orbs ──
          GradientOrb(
            color: AppColors.primaryPurple,
            size: 300,
            position: Offset(size.width * 0.1, size.height * 0.1),
            duration: const Duration(seconds: 7),
          ),
          GradientOrb(
            color: AppColors.electricBlue,
            size: 250,
            position: Offset(size.width * 0.6, size.height * 0.2),
            duration: const Duration(seconds: 9),
          ),
          GradientOrb(
            color: AppColors.cyan,
            size: 200,
            position: Offset(size.width * 0.3, size.height * 0.65),
            duration: const Duration(seconds: 5),
          ),
          GradientOrb(
            color: AppColors.hotPink,
            size: 180,
            position: Offset(size.width * 0.75, size.height * 0.6),
            duration: const Duration(seconds: 8),
          ),

          // ── Content ──
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Avatar
                  FadeSlideTransition(
                    delay: const Duration(milliseconds: 300),
                    child: AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, child) {
                        final pulse = 1 + (_pulseController.value * 0.08);
                        return Transform.scale(
                          scale: pulse,
                          child: Container(
                            padding: const EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: AppColors.primaryGradient,
                              boxShadow: [
                                BoxShadow(
                                  color: AppColors.primaryPurple
                                      .withValues(alpha: 0.4 + _pulseController.value * 0.2),
                                  blurRadius: 25 + _pulseController.value * 15,
                                  spreadRadius: 3,
                                ),
                              ],
                            ),
                            child: const CircleAvatar(
                              radius: 60,
                              backgroundColor: AppColors.surface,
                              child: Text(
                                'MF',
                                style: TextStyle(
                                  fontSize: 36,
                                  fontWeight: FontWeight.w800,
                                  color: AppColors.textPrimary,
                                  letterSpacing: 2,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 32),

                  // Name
                  FadeSlideTransition(
                    delay: const Duration(milliseconds: 600),
                    child: GradientText(
                      text: PortfolioData.name,
                      style: GoogleFonts.poppins(
                        fontSize: 42,
                        fontWeight: FontWeight.w800,
                        letterSpacing: -1,
                      ),
                    ),
                  ),
                  const SizedBox(height: 8),

                  // Title
                  FadeSlideTransition(
                    delay: const Duration(milliseconds: 800),
                    child: Text(
                      PortfolioData.title,
                      style: GoogleFonts.poppins(
                        fontSize: 20,
                        fontWeight: FontWeight.w500,
                        color: AppColors.textSecondary,
                        letterSpacing: 1.5,
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),

                  // Typing subtitle
                  SizedBox(
                    height: 28,
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          _displayedTitle,
                          style: GoogleFonts.firaCode(
                            fontSize: 15,
                            color: AppColors.cyan,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        AnimatedBuilder(
                          animation: _pulseController,
                          builder: (context, _) => Opacity(
                            opacity: _pulseController.value > 0.5 ? 1 : 0,
                            child: Text(
                              '|',
                              style: TextStyle(
                                fontSize: 15,
                                color: AppColors.cyan,
                                fontWeight: FontWeight.w300,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 36),

                  // Social Links
                  FadeSlideTransition(
                    delay: const Duration(milliseconds: 1100),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        _SocialButton(
                          brand: BrandType.github,
                          url: PortfolioData.github,
                          onTap: () => _launchUrl(PortfolioData.github),
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          brand: BrandType.linkedin,
                          url: PortfolioData.linkedin,
                          onTap: () => _launchUrl(PortfolioData.linkedin),
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          brand: BrandType.twitter,
                          url: PortfolioData.twitter,
                          onTap: () => _launchUrl(PortfolioData.twitter),
                        ),
                        const SizedBox(width: 16),
                        _SocialButton(
                          brand: BrandType.email,
                          url: 'mailto:${PortfolioData.email}',
                          onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Scroll Down Indicator ──
          Positioned(
            bottom: 40,
            left: 0,
            right: 0,
            child: FadeSlideTransition(
              delay: const Duration(milliseconds: 1500),
              beginOffset: const Offset(0, -20),
              child: GestureDetector(
                onTap: widget.onScrollDown,
                child: Column(
                  children: [
                    Text(
                      'Scroll Down',
                      style: GoogleFonts.poppins(
                        fontSize: 12,
                        color: AppColors.textMuted,
                        letterSpacing: 2,
                      ),
                    ),
                    const SizedBox(height: 8),
                    AnimatedBuilder(
                      animation: _pulseController,
                      builder: (context, _) => Transform.translate(
                        offset: Offset(0, _pulseController.value * 8),
                        child: Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: AppColors.textMuted.withValues(alpha: 0.6),
                          size: 28,
                        ),
                      ),
                    ),
                  ],
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
// Social Icon Button
// ─────────────────────────────────────────────
class _SocialButton extends StatefulWidget {
  final BrandType brand;
  final String url;
  final VoidCallback onTap;

  const _SocialButton({
    required this.brand,
    required this.url,
    required this.onTap,
  });

  @override
  State<_SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<_SocialButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            color: _hovering
                ? AppColors.primaryPurple.withValues(alpha: 0.25)
                : Colors.white.withValues(alpha: 0.08),
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _hovering
                  ? AppColors.primaryPurple.withValues(alpha: 0.6)
                  : Colors.white.withValues(alpha: 0.12),
            ),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.primaryPurple.withValues(alpha: 0.3),
                      blurRadius: 15,
                    ),
                  ]
                : [],
          ),
          child: BrandIcon(
            brand: widget.brand,
            size: 20,
            color: _hovering ? AppColors.primaryPurple : AppColors.textSecondary,
          ),
        ),
      ),
    );
  }
}
