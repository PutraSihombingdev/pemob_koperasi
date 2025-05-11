import 'package:flutter/material.dart';

// Warna utama aplikasi
class AppColors {
  static const primary = Color(0xFF1E3A8A);      // Biru utama
  static const secondary = Color(0xFF3B82F6);    // Biru terang
  static const accent = Color(0xFF93C5FD);       // Biru lembut
  static const background = Color(0xFFF1F5F9);   // Abu-abu sangat terang
  static const card = Colors.white;
  static const textPrimary = Color(0xFF1E293B);  // Abu gelap
  static const textSecondary = Color(0xFF64748B);// Abu sedang
}

// Gaya teks
class AppTextStyles {
  static const title = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );

  static const subtitle = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const body = TextStyle(
    fontSize: 14,
    color: AppColors.textPrimary,
  );

  static const small = TextStyle(
    fontSize: 12,
    color: AppColors.textSecondary,
  );
}

// Radius dan bayangan umum
class AppDecorations {
  static BoxDecoration cardDecoration = BoxDecoration(
    color: AppColors.card,
    borderRadius: BorderRadius.circular(15),
    boxShadow: [
      BoxShadow(
        color: Colors.black12,
        blurRadius: 6,
        offset: Offset(0, 4),
      ),
    ],
  );
}
