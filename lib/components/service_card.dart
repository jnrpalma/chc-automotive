import 'package:flutter/material.dart';
import 'package:chc_aesthetics/utils/app_colors.dart'; // Importando as cores

class ServiceCard extends StatelessWidget {
  final String service;
  final String car;
  final String price;
  final String date;

  const ServiceCard({
    super.key,
    required this.service,
    required this.car,
    required this.price,
    required this.date,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.secondary, // Usando cor centralizada
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  service,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight, // Usando cor centralizada
                  ),
                ),
                Text(
                  car,
                  style: const TextStyle(
                      color: AppColors.accent), // Cor Periwinkle
                ),
              ],
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  price,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textLight,
                  ),
                ),
                Text(
                  date,
                  style: const TextStyle(color: AppColors.accent),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
