import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class AgeSelector extends StatefulWidget {
  final Function(int) onAgeChanged;
  final int initialAge;

  const AgeSelector({
    super.key,
    required this.onAgeChanged,
    this.initialAge = 25,
  });

  @override
  State<AgeSelector> createState() => _AgeSelectorState();
}

class _AgeSelectorState extends State<AgeSelector> {
  late int _age;

  @override
  void initState() {
    super.initState();
    _age = widget.initialAge;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Usia (Tahun)',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildButton(Icons.remove, () {
                if (_age > 1) {
                  setState(() {
                    _age--;
                  });
                  widget.onAgeChanged(_age);
                }
              }),
              const SizedBox(width: 20),
              Container(
                width: 80,
                padding: const EdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  '$_age',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: AppColors.primary,
                  ),
                ),
              ),
              const SizedBox(width: 20),
              _buildButton(Icons.add, () {
                if (_age < 100) {
                  setState(() {
                    _age++;
                  });
                  widget.onAgeChanged(_age);
                }
              }),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildButton(IconData icon, VoidCallback onPressed) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(50),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 8,
            spreadRadius: 1,
          ),
        ],
      ),
      child: IconButton(
        onPressed: onPressed,
        icon: Icon(icon, color: Colors.white),
        style: IconButton.styleFrom(
          backgroundColor: Colors.transparent,
        ),
      ),
    );
  }
}