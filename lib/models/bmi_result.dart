import 'package:flutter/material.dart';
import '../theme/app_colors.dart';  // Tambahkan import ini

class BMIResult {
  final double bmi;
  final String category;
  final String description;
  final Color color;  // Sekarang Color dikenali
  final String healthTip;
  final String? idealWeightRange;

  BMIResult({
    required this.bmi,
    required this.category,
    required this.description,
    required this.color,
    required this.healthTip,
    this.idealWeightRange,
  });

  factory BMIResult.calculate(double bmi, int age, String gender) {
    String category;
    String description;
    Color color;  // Sekarna Color dikenali
    String healthTip;
    String? idealWeightRange;

    if (age < 18) {
      // For children and teens (simplified version)
      if (bmi < 18.5) {
        category = 'Underweight';
        description = 'Berat badan kurang untuk usia Anda';
        color = AppColors.underweight;  // Sekarang AppColors dikenali
        healthTip = 'Konsultasi dengan dokter untuk pola makan yang sesuai usia';
      } else if (bmi < 25) {
        category = 'Normal';
        description = 'Berat badan sehat untuk usia Anda';
        color = AppColors.normal;  // Sekarang AppColors dikenali
        healthTip = 'Pertahankan pola makan dan aktivitas fisik yang sehat';
      } else {
        category = 'Overweight';
        description = 'Perlu perhatian khusus untuk pola makan';
        color = AppColors.overweight;  // Sekarang AppColors dikenali
        healthTip = 'Konsultasi dengan ahli gizi anak';
      }
    } else {
      // For adults
      if (bmi < 18.5) {
        category = 'Underweight';
        description = 'Berat badan kurang';
        color = AppColors.underweight;  // Sekarang AppColors dikenali
        healthTip = 'Tingkatkan asupan kalori dengan makanan bergizi';
        idealWeightRange = _calculateIdealWeight(18.5, 24.9);
      } else if (bmi < 25) {
        category = 'Normal';
        description = 'Berat badan ideal';
        color = AppColors.normal;  // Sekarang AppColors dikenali
        healthTip = 'Pertahankan pola hidup sehat Anda!';
        idealWeightRange = _calculateIdealWeight(18.5, 24.9);
      } else if (bmi < 30) {
        category = 'Overweight';
        description = 'Kelebihan berat badan';
        color = AppColors.overweight;  // Sekarang AppColors dikenali
        healthTip = 'Perbanyak aktivitas fisik dan kurangi kalori';
        idealWeightRange = _calculateIdealWeight(18.5, 24.9);
      } else {
        category = 'Obese';
        description = 'Obesitas';
        color = AppColors.obese;  // Sekarang AppColors dikenali
        healthTip = 'Konsultasi dengan dokter dan ahli gizi';
        idealWeightRange = _calculateIdealWeight(18.5, 24.9);
      }
    }

    return BMIResult(
      bmi: bmi,
      category: category,
      description: description,
      color: color,
      healthTip: healthTip,
      idealWeightRange: idealWeightRange,
    );
  }

  static String _calculateIdealWeight(double minBMI, double maxBMI, [double height = 1.7]) {
    double minWeight = minBMI * height * height;
    double maxWeight = maxBMI * height * height;
    return '${minWeight.toStringAsFixed(1)} - ${maxWeight.toStringAsFixed(1)} kg';
  }
}