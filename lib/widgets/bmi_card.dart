import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class BMICard extends StatelessWidget {
  final double bmi;
  final String category;
  final String description;
  final Color color;
  final String healthTip;
  final String? idealWeightRange;

  const BMICard({
    super.key,
    required this.bmi,
    required this.category,
    required this.description,
    required this.color,
    required this.healthTip,
    this.idealWeightRange,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            color.withOpacity(0.1),
            color.withOpacity(0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withOpacity(0.3), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'BMI',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    bmi.toStringAsFixed(1),
                    style: const TextStyle(
                      fontSize: 36,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: color.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            description,
            style: const TextStyle(
              fontSize: 16,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          if (idealWeightRange != null) ...[
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.scale, size: 16, color: AppColors.textSecondary),
                const SizedBox(width: 8),
                Text(
                  'Berat ideal: $idealWeightRange',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ],
          const SizedBox(height: 16),
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: color.withOpacity(0.2)),
            ),
            child: Row(
              children: [
                Icon(Icons.health_and_safety, color: color),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    healthTip,
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          _buildBMIScale(),
        ],
      ),
    );
  }

  Widget _buildBMIScale() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Skala BMI:',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            _buildScaleItem('Kurang', AppColors.underweight, 18.5),
            _buildScaleItem('Normal', AppColors.normal, 25),
            _buildScaleItem('Kelebihan', AppColors.overweight, 30),
            _buildScaleItem('Obesitas', AppColors.obese, null),
          ],
        ),
      ],
    );
  }

  Widget _buildScaleItem(String label, Color color, double? maxValue) {
    return Expanded(
      child: Container(
        height: 8,
        margin: const EdgeInsets.symmetric(horizontal: 2),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Tooltip(
          message: maxValue != null 
            ? 'BMI < $maxValue' 
            : 'BMI ≥ 30',
          child: const SizedBox.expand(),
        ),
      ),
    );
  }
}