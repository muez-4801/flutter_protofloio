import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import '../utils/constants.dart';
import '../utils/animations.dart';
import 'brand_icons.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

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
              title: 'Get In Touch',
              subtitle: 'Let\'s work together',
            ),
          ),
          const SizedBox(height: 48),

          // ── Contact Info Cards ──
          ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 700),
            child: Column(
              children: [
                // Contact cards row
                FadeSlideTransition(
                  delay: const Duration(milliseconds: 300),
                  child: Wrap(
                    spacing: 16,
                    runSpacing: 16,
                    alignment: WrapAlignment.center,
                    children: [
                      _ContactInfoCard(
                        icon: Icons.email_rounded,
                        label: 'Email',
                        value: PortfolioData.email,
                        colors: const [AppColors.primaryPurple, AppColors.electricBlue],
                        onTap: () => _launchUrl('mailto:${PortfolioData.email}'),
                      ),
                      _ContactInfoCard(
                        icon: Icons.phone_rounded,
                        label: 'Phone',
                        value: PortfolioData.phone,
                        colors: const [AppColors.electricBlue, AppColors.cyan],
                        onTap: () => _launchUrl('tel:${PortfolioData.phone}'),
                      ),
                      _ContactInfoCard(
                        icon: Icons.location_on_rounded,
                        label: 'Location',
                        value: PortfolioData.location,
                        colors: const [AppColors.hotPink, AppColors.primaryPurple],
                        onTap: () {},
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 48),

                // Social media row
                FadeSlideTransition(
                  delay: const Duration(milliseconds: 500),
                  child: GlassContainer(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 28,
                    ),
                    child: Column(
                      children: [
                        Text(
                          'Follow Me',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            _SocialLinkChip(
                              brand: BrandType.github,
                              label: 'GitHub',
                              colors: const [Color(0xFF6E5494), Color(0xFF9B59B6)],
                              onTap: () => _launchUrl(PortfolioData.github),
                            ),
                            const SizedBox(width: 12),
                            _SocialLinkChip(
                              brand: BrandType.linkedin,
                              label: 'LinkedIn',
                              colors: const [Color(0xFF0077B5), Color(0xFF00A0DC)],
                              onTap: () => _launchUrl(PortfolioData.linkedin),
                            ),
                            const SizedBox(width: 12),
                            _SocialLinkChip(
                              brand: BrandType.twitter,
                              label: 'Twitter',
                              colors: const [Color(0xFF1DA1F2), Color(0xFF14171A)],
                              onTap: () => _launchUrl(PortfolioData.twitter),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 64),

                // ── Footer ──
                FadeSlideTransition(
                  delay: const Duration(milliseconds: 700),
                  child: Column(
                    children: [
                      Container(
                        width: 120,
                        height: 1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              Colors.transparent,
                              AppColors.primaryPurple.withValues(alpha: 0.5),
                              Colors.transparent,
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Built with ',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                          ShaderMask(
                            shaderCallback: (bounds) =>
                                AppColors.primaryGradient.createShader(bounds),
                            blendMode: BlendMode.srcIn,
                            child: const Icon(Icons.favorite, size: 16),
                          ),
                          Text(
                            ' using Flutter',
                            style: GoogleFonts.poppins(
                              fontSize: 13,
                              color: AppColors.textMuted,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 6),
                      Text(
                        '© ${DateTime.now().year} ${PortfolioData.name}',
                        style: GoogleFonts.poppins(
                          fontSize: 12,
                          color: AppColors.textMuted.withValues(alpha: 0.6),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Contact Info Card
// ─────────────────────────────────────────────
class _ContactInfoCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String value;
  final List<Color> colors;
  final VoidCallback onTap;

  const _ContactInfoCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_ContactInfoCard> createState() => _ContactInfoCardState();
}

class _ContactInfoCardState extends State<_ContactInfoCard> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOutCubic,
          transform: Matrix4.diagonal3Values(
            _hovering ? 1.05 : 1.0,
            _hovering ? 1.05 : 1.0,
            1.0,
          ),
          transformAlignment: Alignment.center,
          child: GlassContainer(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
            borderColor: _hovering
                ? widget.colors[0].withValues(alpha: 0.5)
                : Colors.white.withValues(alpha: 0.1),
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(colors: widget.colors),
                    borderRadius: BorderRadius.circular(14),
                    boxShadow: _hovering
                        ? [
                            BoxShadow(
                              color: widget.colors[0].withValues(alpha: 0.4),
                              blurRadius: 15,
                            ),
                          ]
                        : [],
                  ),
                  child: Icon(widget.icon, size: 22, color: Colors.white),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.label,
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.value,
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Social Link Chip
// ─────────────────────────────────────────────
class _SocialLinkChip extends StatefulWidget {
  final BrandType brand;
  final String label;
  final List<Color> colors;
  final VoidCallback onTap;

  const _SocialLinkChip({
    required this.brand,
    required this.label,
    required this.colors,
    required this.onTap,
  });

  @override
  State<_SocialLinkChip> createState() => _SocialLinkChipState();
}

class _SocialLinkChipState extends State<_SocialLinkChip> {
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
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            gradient: _hovering
                ? LinearGradient(
                    colors: widget.colors
                        .map((c) => c.withValues(alpha: 0.25))
                        .toList(),
                  )
                : null,
            color: _hovering ? null : Colors.white.withValues(alpha: 0.06),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
              color: _hovering
                  ? widget.colors[0].withValues(alpha: 0.5)
                  : Colors.white.withValues(alpha: 0.1),
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              BrandIcon(
                brand: widget.brand,
                size: 16,
                color: _hovering ? widget.colors[0] : AppColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.label,
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                  color: _hovering ? widget.colors[0] : AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
