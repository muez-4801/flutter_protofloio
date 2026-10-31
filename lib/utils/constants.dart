import 'package:flutter/material.dart';

// ─────────────────────────────────────────────
// Color Palette
// ─────────────────────────────────────────────
class AppColors {
  // Primary Colors
  static const Color primaryPurple = Color(0xFF7C4DFF);
  static const Color electricBlue = Color(0xFF00B4D8);
  static const Color cyan = Color(0xFF00F5D4);
  static const Color hotPink = Color(0xFFFF6B9D);
  static const Color amber = Color(0xFFFFB703);
  static const Color coral = Color(0xFFFF6F61);

  // Background & Surface
  static const Color background = Color(0xFF0A0E21);
  static const Color surface = Color(0xFF141A32);
  static const Color surfaceLight = Color(0xFF1E2548);

  // Text
  static const Color textPrimary = Color(0xFFFFFFFF);
  static const Color textSecondary = Color(0xFFB0BEC5);
  static const Color textMuted = Color(0xFF607D8B);

  // Gradients
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [primaryPurple, electricBlue, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient heroGradient = LinearGradient(
    colors: [Color(0xFF0A0E21), Color(0xFF1A1040), Color(0xFF0D1B2A)],
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
  );

  static const LinearGradient pinkPurpleGradient = LinearGradient(
    colors: [hotPink, primaryPurple],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient blueCyanGradient = LinearGradient(
    colors: [electricBlue, cyan],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  static const LinearGradient glassGradient = LinearGradient(
    colors: [Color(0x1AFFFFFF), Color(0x08FFFFFF)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );
}

// ─────────────────────────────────────────────
// Section Identifiers
// ─────────────────────────────────────────────
enum PortfolioSection { hero, about, skills, projects, experience, contact }

// ─────────────────────────────────────────────
// Portfolio Content Data
// ─────────────────────────────────────────────
class PortfolioData {
  static const String name = 'Muez Fathi';
  static const String title = 'Computer Science Student';
  static const String subtitle = 'Mobile App Developer & UI/UX Enthusiast';

  static const String bio =
      'Passionate Computer Science student with a deep love for building elegant '
      'mobile applications. I specialize in Flutter development and enjoy crafting '
      'beautiful, performant user interfaces that deliver exceptional user experiences. '
      'Always eager to learn new technologies and push the boundaries of what\'s possible.';

  static const String email = 'muez.fathi@email.com';
  static const String phone = '+249 XX XXX XXXX';
  static const String location = 'Sudan';
  static const String github = 'https://github.com/muezfathi';
  static const String linkedin = 'https://linkedin.com/in/muezfathi';
  static const String twitter = 'https://twitter.com/muezfathi';

  // ── Stats ──
  static const List<Map<String, String>> stats = [
    {'value': '10+', 'label': 'Projects'},
    {'value': '6+', 'label': 'Technologies'},
    {'value': '2+', 'label': 'Years Exp'},
    {'value': '5+', 'label': 'Clients'},
  ];

  // ── Skills ──
  static const List<Map<String, dynamic>> skills = [
    // Programming Languages
    {'name': 'Dart', 'level': 0.90, 'category': 'Languages', 'icon': 0xe1a7},
    {'name': 'Python', 'level': 0.85, 'category': 'Languages', 'icon': 0xe86f},
    {'name': 'Java', 'level': 0.80, 'category': 'Languages', 'icon': 0xe1a5},
    {'name': 'C++', 'level': 0.75, 'category': 'Languages', 'icon': 0xe86f},
    {'name': 'JavaScript', 'level': 0.70, 'category': 'Languages', 'icon': 0xe86f},
    // Frameworks & Platforms
    {'name': 'Flutter', 'level': 0.92, 'category': 'Frameworks', 'icon': 0xe1e1},
    {'name': 'Firebase', 'level': 0.82, 'category': 'Frameworks', 'icon': 0xe1e1},
    {'name': 'REST APIs', 'level': 0.78, 'category': 'Frameworks', 'icon': 0xe1e1},
    {'name': 'Provider / Bloc', 'level': 0.80, 'category': 'Frameworks', 'icon': 0xe1e1},
    // Tools & Design
    {'name': 'Git & GitHub', 'level': 0.88, 'category': 'Tools', 'icon': 0xe1e1},
    {'name': 'VS Code', 'level': 0.90, 'category': 'Tools', 'icon': 0xe1e1},
    {'name': 'Figma', 'level': 0.72, 'category': 'Tools', 'icon': 0xe1e1},
    {'name': 'Android Studio', 'level': 0.82, 'category': 'Tools', 'icon': 0xe1e1},
  ];

  // ── Projects ──
  static const List<Map<String, dynamic>> projects = [
    {
      'title': 'ShopZone',
      'subtitle': 'E-Commerce App',
      'description':
          'A full-featured e-commerce mobile application with product browsing, cart management, wishlist, and secure checkout integration.',
      'tech': ['Flutter', 'Firebase', 'Stripe'],
      'gradient': [0xFF6C63FF, 0xFF00B4D8],
      'icon': 0xe59C,
    },
    {
      'title': 'SkyView',
      'subtitle': 'Weather App',
      'description':
          'Beautiful weather application with real-time data, 7-day forecasts, location-based alerts, and stunning weather animations.',
      'tech': ['Flutter', 'REST API', 'Lottie'],
      'gradient': [0xFF00B4D8, 0xFF00F5D4],
      'icon': 0xf070D,
    },
    {
      'title': 'TaskFlow',
      'subtitle': 'Productivity App',
      'description':
          'Smart productivity app with task organization, Pomodoro timer, reminders, and beautiful progress tracking dashboards.',
      'tech': ['Flutter', 'SQLite', 'Provider'],
      'gradient': [0xFF00F5D4, 0xFFFFB703],
      'icon': 0xe65E,
    },
    {
      'title': 'ConnectUp',
      'subtitle': 'Chat Application',
      'description':
          'Real-time messaging app with authentication, media sharing, voice messages, and push notifications.',
      'tech': ['Flutter', 'Firebase', 'FCM'],
      'gradient': [0xFFFF6B9D, 0xFF7C4DFF],
      'icon': 0xe0CA,
    },
  ];

  // ── Experience / Education ──
  static const List<Map<String, dynamic>> experience = [
    {
      'title': 'B.Sc. Computer Science',
      'organization': 'University',
      'period': '2022 — Present',
      'description':
          'Pursuing a Bachelor\'s degree in Computer Science with focus on software engineering, '
          'data structures, algorithms, and mobile application development.',
      'type': 'education',
    },
    {
      'title': 'Flutter Developer Intern',
      'organization': 'Tech Startup',
      'period': '2024 — 2025',
      'description':
          'Developed and maintained mobile applications using Flutter. Collaborated closely with '
          'design and backend teams to ship production-quality features.',
      'type': 'work',
    },
    {
      'title': 'Freelance Mobile Developer',
      'organization': 'Self-Employed',
      'period': '2023 — Present',
      'description':
          'Building custom mobile applications for clients worldwide, focusing on premium UI/UX '
          'design, clean architecture, and high performance.',
      'type': 'work',
    },
  ];

  // Skill category icons (Material Icons code points)
  static const Map<String, IconData> categoryIcons = {
    'Languages': Icons.code,
    'Frameworks': Icons.layers,
    'Tools': Icons.build_circle,
  };

  // Skill category gradient colors
  static const Map<String, List<Color>> categoryColors = {
    'Languages': [AppColors.primaryPurple, AppColors.electricBlue],
    'Frameworks': [AppColors.electricBlue, AppColors.cyan],
    'Tools': [AppColors.hotPink, AppColors.primaryPurple],
  };
}
