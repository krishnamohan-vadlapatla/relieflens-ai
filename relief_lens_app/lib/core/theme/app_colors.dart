import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Color(0xFF1E40AF);
  static const Color secondary = Color(0xFF3B82F6);
  static const Color alert = Color(0xFFF97316);
  static const Color danger = Color(0xFFDC2626);
  static const Color success = Color(0xFF10B981);
  static const Color warning = Color(0xFFFBBF24);
  static const Color background = Color(0xFF0F172A);
  static const Color surface = Color(0xFF1E293B);
  static const Color surfaceLight = Color(0xFF334155);
  static const Color textPrimary = Color(0xFFF8FAFC);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const LinearGradient primaryGradient = LinearGradient(colors: [primary, Color(0xFF7C3AED)], begin: Alignment.topLeft, end: Alignment.bottomRight);
  static const LinearGradient alertGradient = LinearGradient(colors: [alert, danger], begin: Alignment.topLeft, end: Alignment.bottomRight);
}