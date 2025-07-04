import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../screens/all_facilities_screen.dart';

class FacilitiesSection extends StatelessWidget {
  final List<Facility> facilities;

  const FacilitiesSection({
    super.key,
    required this.facilities,
  });

  IconData _getIconData(String iconName) {
    switch (iconName) {
      case 'wifi':
        return Icons.wifi;
      case 'beach_access':
        return Icons.beach_access;
      case 'pool':
        return Icons.pool;
      case 'spa':
        return Icons.spa;
      case 'restaurant':
        return Icons.restaurant;
      case 'fitness_center':
        return Icons.fitness_center;
      case 'local_bar':
        return Icons.local_bar;
      case 'room_service':
        return Icons.room_service;
      default:
        return Icons.star;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text(
              'Popular Facilities',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const AllFacilitiesScreen(),
                  ),
                );
              },
              child: const Text(
                'View All',
                style: TextStyle(
                  color: Color(0xFF00C569),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 110,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: facilities.length,
            itemBuilder: (context, index) {
              final facility = facilities[index];
              return Container(
                width: 80,
                margin: const EdgeInsets.only(right: 16),
                child: Column(
                  children: [
                    Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Icon(
                        _getIconData(facility.icon),
                        color: const Color(0xFF00C569),
                        size: 28,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      facility.name,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 12,
                        color: Color(0xFF6E6E6E),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}
