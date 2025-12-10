class BMICalculator {
  static double calculateBMI(double height, double weight) {
    // Convert height from cm to meters
    double heightInMeters = height / 100;
    return weight / (heightInMeters * heightInMeters);
  }

  static Map<String, dynamic> getBMIAnalysis(
    double bmi, 
    int age, 
    String gender,
    double height,
    double weight
  ) {
    String status;
    String advice;
    List<String> recommendations = [];
    
    if (age < 18) {
      // Simplified for children
      if (bmi < 18.5) {
        status = "Perlu Perhatian";
        advice = "Konsultasikan dengan dokter anak untuk evaluasi gizi";
      } else if (bmi < 25) {
        status = "Sehat";
        advice = "Pertahankan pola makan dan aktivitas fisik";
      } else {
        status = "Perlu Perhatian";
        advice = "Konsultasikan dengan ahli gizi anak";
      }
    } else {
      // For adults
      if (bmi < 18.5) {
        status = "Kekurangan Berat Badan";
        advice = "Tingkatkan asupan makanan bergizi";
        recommendations = [
          "Makan lebih sering (5-6 kali/hari)",
          "Konsumsi makanan tinggi protein",
          "Tambahkan camilan sehat di antara waktu makan"
        ];
      } else if (bmi < 25) {
        status = "Normal/Ideal";
        advice = "Pertahankan pola hidup sehat";
        recommendations = [
          "Tetap aktif berolahraga",
          "Jaga pola makan seimbang",
          "Cukup istirahat dan minum air"
        ];
      } else if (bmi < 30) {
        status = "Kelebihan Berat Badan";
        advice = "Perlu penurunan berat badan";
        recommendations = [
          "Kurangi makanan berlemak dan manis",
          "Tingkatkan aktivitas fisik",
          "Konsumsi lebih banyak serat"
        ];
      } else {
        status = "Obesitas";
        advice = "Segera konsultasi dengan dokter";
        recommendations = [
          "Konsultasi dokter dan ahli gizi",
          "Program penurunan berat badan terstruktur",
          "Olahraga teratur dengan pengawasan"
        ];
      }
    }

    return {
      'status': status,
      'advice': advice,
      'recommendations': recommendations,
      'bmi': bmi.toStringAsFixed(1),
      'idealWeight': _calculateIdealWeight(height),
    };
  }

  static String _calculateIdealWeight(double height) {
    double min = 18.5 * (height/100) * (height/100);
    double max = 24.9 * (height/100) * (height/100);
    return '${min.toStringAsFixed(1)} - ${max.toStringAsFixed(1)} kg';
  }
}