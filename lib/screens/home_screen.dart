// lib/screens/home_screen.dart
import 'package:flutter/material.dart';
import '../models/bmi_result.dart';
import '../utils/bmi_calculator.dart';
import '../widgets/age_selector.dart';
import '../widgets/bmi_card.dart';
import '../widgets/gender_selector.dart';
import '../widgets/height_selector.dart';
import '../widgets/weight_selector.dart';
import '../theme/app_colors.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String _gender = 'male';
  int _age = 25;
  double _height = 170;
  double _weight = 65;
  BMIResult? _bmiResult;

  void _calculateBMI() {
    final bmi = BMICalculator.calculateBMI(_height, _weight);
    final result = BMIResult.calculate(bmi, _age, _gender);
    
    setState(() {
      _bmiResult = result;
    });

    // Show detailed analysis
    _showDetailedAnalysis(bmi);
  }

  void _showDetailedAnalysis(double bmi) {
    final analysis = BMICalculator.getBMIAnalysis(
      bmi, _age, _gender, _height, _weight
    );

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
      ),
      builder: (context) {
        return Container(
          padding: const EdgeInsets.all(24),
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(25)),
          ),
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: BorderRadius.circular(2),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Text(
                  'Analisis Detail', // Perbaiki typo 'Analysis' -> 'Analisis'
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 16),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.assignment, color: AppColors.primary),
                  ),
                  title: const Text('Status', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(analysis['status'] as String),
                ),
                ListTile(
                  leading: Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.health_and_safety, color: AppColors.success),
                  ),
                  title: const Text('Saran', style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(analysis['advice'] as String),
                ),
                if ((analysis['recommendations'] as List<String>).isNotEmpty) ...[
                  const SizedBox(height: 16),
                  const Text(
                    'Rekomendasi:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ...(analysis['recommendations'] as List<String>).map((rec) => Padding(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    child: Row(
                      children: [
                        const Icon(Icons.check_circle, color: AppColors.success, size: 16),
                        const SizedBox(width: 8),
                        Expanded(child: Text(rec)),
                      ],
                    ),
                  )),
                ],
                const SizedBox(height: 24),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'Mengerti',
                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('BMI Health Calculator'),
        actions: [
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Tentang BMI'),
                  content: SingleChildScrollView(
                    child: const Text(
                      'BMI (Body Mass Index) adalah pengukuran yang menggunakan tinggi dan berat badan untuk memperkirakan lemak tubuh.\n\n'
                      'Keterangan:\n'
                      '• < 18.5: Berat badan kurang\n'
                      '• 18.5-24.9: Normal\n'
                      '• 25-29.9: Kelebihan berat badan\n'
                      '• ≥ 30: Obesitas',
                    ),
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context),
                      child: const Text('Tutup'),
                    ),
                  ],
                ),
              );
            },
            icon: const Icon(Icons.info_outline),
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            GenderSelector(
              onGenderChanged: (gender) => setState(() => _gender = gender),
              initialGender: _gender,
            ),
            const SizedBox(height: 16),
            HeightSelector(
              onHeightChanged: (height) => setState(() => _height = height),
              initialHeight: _height,
            ),
            const SizedBox(height: 16),
            WeightSelector(
              onWeightChanged: (weight) => setState(() => _weight = weight),
              initialWeight: _weight,
            ),
            const SizedBox(height: 16),
            AgeSelector(
              onAgeChanged: (age) => setState(() => _age = age),
              initialAge: _age,
            ),
            const SizedBox(height: 24),
            if (_bmiResult != null) ...[
              BMICard(
                bmi: _bmiResult!.bmi,
                category: _bmiResult!.category,
                description: _bmiResult!.description,
                color: _bmiResult!.color,
                healthTip: _bmiResult!.healthTip,
                idealWeightRange: _bmiResult!.idealWeightRange,
              ),
              const SizedBox(height: 16),
            ],
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: _calculateBMI,
                icon: const Icon(Icons.calculate, size: 24),
                label: const Text(
                  'HITUNG BMI',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 18),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  elevation: 5,
                  shadowColor: AppColors.primary.withOpacity(0.3),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Data Anda aman dan tidak disimpan',
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}