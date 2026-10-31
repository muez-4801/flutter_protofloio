import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

enum BrandType { github, linkedin, twitter, email }

class BrandIcon extends StatelessWidget {
  final BrandType brand;
  final double size;
  final Color color;

  const BrandIcon({
    super.key,
    required this.brand,
    this.size = 20,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    switch (brand) {
      case BrandType.github:
        return SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _GithubPainter(color: color),
          ),
        );
      case BrandType.linkedin:
        return Container(
          width: size,
          height: size,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(size * 0.2),
          ),
          child: Text(
            'in',
            style: GoogleFonts.poppins(
              color: Colors.black,
              fontWeight: FontWeight.w900,
              fontSize: size * 0.65,
              height: 1.0,
            ),
          ),
        );
      case BrandType.twitter:
        return SizedBox(
          width: size,
          height: size,
          child: Center(
            child: Text(
              '𝕏',
              style: TextStyle(
                color: color,
                fontWeight: FontWeight.w800,
                fontSize: size * 1.1,
                height: 1.0,
              ),
            ),
          ),
        );
      case BrandType.email:
        return Icon(
          Icons.mail_rounded,
          size: size,
          color: color,
        );
    }
  }
}

class _GithubPainter extends CustomPainter {
  final Color color;

  const _GithubPainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final scaleX = size.width / 24.0;
    final scaleY = size.height / 24.0;

    canvas.save();
    canvas.scale(scaleX, scaleY);

    // Standard GitHub Octocat SVG Path
    final path = Path();
    path.moveTo(12.0, 2.0);
    path.cubicTo(6.477, 2.0, 2.0, 6.477, 2.0, 12.0);
    path.cubicTo(2.0, 16.418, 4.865, 20.166, 8.839, 21.489);
    path.cubicTo(9.339, 21.581, 9.521, 21.272, 9.521, 21.008);
    path.cubicTo(9.521, 20.771, 9.512, 19.988, 9.508, 19.155);
    path.cubicTo(6.726, 19.759, 6.139, 17.815, 6.139, 17.815);
    path.cubicTo(5.685, 16.661, 5.03, 16.354, 5.03, 16.354);
    path.cubicTo(4.122, 15.734, 5.099, 15.746, 5.099, 15.746);
    path.cubicTo(6.103, 15.817, 6.632, 16.777, 6.632, 16.777);
    path.cubicTo(7.524, 18.306, 8.971, 17.864, 9.541, 17.608);
    path.cubicTo(9.632, 16.962, 9.891, 16.522, 10.177, 16.272);
    path.cubicTo(7.956, 16.02, 5.621, 15.161, 5.621, 11.332);
    path.cubicTo(5.621, 10.241, 6.011, 9.349, 6.651, 8.651);
    path.cubicTo(6.548, 8.399, 6.205, 7.382, 6.749, 6.012);
    path.cubicTo(6.749, 6.012, 7.588, 5.743, 9.497, 7.036);
    path.cubicTo(10.294, 6.814, 11.149, 6.703, 12.0, 6.699);
    path.cubicTo(12.851, 6.703, 13.706, 6.814, 14.504, 7.036);
    path.cubicTo(16.411, 5.743, 17.249, 6.012, 17.249, 6.012);
    path.cubicTo(17.795, 7.382, 17.452, 8.399, 17.349, 8.651);
    path.cubicTo(17.989, 9.349, 18.377, 10.241, 18.377, 11.332);
    path.cubicTo(18.377, 15.172, 16.038, 16.017, 13.81, 16.264);
    path.cubicTo(14.168, 16.572, 14.488, 17.181, 14.488, 18.113);
    path.cubicTo(14.488, 19.449, 14.476, 20.525, 14.476, 20.854);
    path.cubicTo(14.476, 21.121, 14.656, 21.434, 15.163, 21.335);
    path.cubicTo(19.133, 20.007, 22.0, 16.416, 22.0, 12.0);
    path.cubicTo(22.0, 6.477, 17.523, 2.0, 12.0, 2.0);
    path.close();

    canvas.drawPath(path, paint);
    canvas.restore();
  }

  @override
  bool shouldRepaint(covariant _GithubPainter oldDelegate) =>
      oldDelegate.color != color;
}
