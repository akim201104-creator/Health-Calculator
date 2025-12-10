import 'package:flutter/material.dart';
import '../theme/app_colors.dart';

class GenderSelector extends StatefulWidget {
  final Function(String) onGenderChanged;
  final String initialGender;

  const GenderSelector({
    super.key,
    required this.onGenderChanged,
    this.initialGender = 'male',
  });

  @override
  State<GenderSelector> createState() => _GenderSelectorState();
}

class _GenderSelectorState extends State<GenderSelector> {
  late String _selectedGender;

  @override
  void initState() {
    super.initState();
    _selectedGender = widget.initialGender;
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
            'Jenis Kelamin',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildGenderOption('male', 'Pria', Icons.male),
              _buildGenderOption('female', 'Wanita', Icons.female),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGenderOption(String gender, String label, IconData icon) {
    bool isSelected = _selectedGender == gender;
    
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedGender = gender;
        });
        widget.onGenderChanged(gender);
      },
      child: Container(
        width: 120,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withOpacity(0.1) : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: Border.all(
            color: isSelected ? AppColors.primary : Colors.grey.shade300,
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              size: 40,
              color: isSelected ? AppColors.primary : AppColors.textSecondary,
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
              ),
            ),
          ],
        ),
      ),
    );
  }
}