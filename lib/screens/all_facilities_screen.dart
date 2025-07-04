import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../data/sample_data.dart';

class AllFacilitiesScreen extends StatefulWidget {
  const AllFacilitiesScreen({super.key});

  @override
  State<AllFacilitiesScreen> createState() => _AllFacilitiesScreenState();
}

class _AllFacilitiesScreenState extends State<AllFacilitiesScreen> {
  List<FacilityCategory> facilityCategories = [];

  @override
  void initState() {
    super.initState();
    facilityCategories = SampleData.getFacilityCategories();
  }

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
      case 'hotel':
        return Icons.hotel;
      case 'support_agent':
        return Icons.support_agent;
      case 'local_parking':
        return Icons.local_parking;
      case 'elevator':
        return Icons.elevator;
      case 'local_florist':
        return Icons.local_florist;
      case 'library_books':
        return Icons.library_books;
      case 'ac_unit':
        return Icons.ac_unit;
      case 'wine_bar':
        return Icons.wine_bar;
      case 'lock':
        return Icons.lock;
      case 'balcony':
        return Icons.balcony;
      case 'tv':
        return Icons.tv;
      case 'coffee_maker':
        return Icons.coffee_maker;
      case 'local_bar':
        return Icons.local_bar;
      case 'room_service':
        return Icons.room_service;
      case 'free_breakfast':
        return Icons.free_breakfast;
      case 'outdoor_grill':
        return Icons.outdoor_grill;
      case 'business_center':
        return Icons.business_center;
      case 'meeting_room':
        return Icons.meeting_room;
      case 'print':
        return Icons.print;
      case 'medical_services':
        return Icons.medical_services;
      case 'local_pharmacy':
        return Icons.local_pharmacy;
      case 'star':
        return Icons.star;
      case 'public':
        return Icons.public;
      case 'business':
        return Icons.business;
      default:
        return Icons.check_circle;
    }
  }

  IconData _getCategoryIcon(String iconName) {
    switch (iconName) {
      case 'star':
        return Icons.star;
      case 'public':
        return Icons.public;
      case 'hotel':
        return Icons.hotel;
      case 'restaurant':
        return Icons.restaurant;
      case 'business':
        return Icons.business;
      case 'medical_services':
        return Icons.medical_services;
      default:
        return Icons.category;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'All Facilities',
          style: TextStyle(
            color: Colors.black,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: facilityCategories.length,
        itemBuilder: (context, index) {
          final category = facilityCategories[index];
          
          return Container(
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
            ),
            child: Theme(
              data: Theme.of(context).copyWith(
                dividerColor: Colors.transparent,
              ),
              child: ExpansionTile(
                initiallyExpanded: index == 0, // Expand first category by default
                leading: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C569).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    _getCategoryIcon(category.icon),
                    color: const Color(0xFF00C569),
                    size: 20,
                  ),
                ),
                title: Text(
                  category.name,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                subtitle: Text(
                  '${category.facilities.length} facilities',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    child: GridView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 3.5,
                      ),
                      itemCount: category.facilities.length,
                      itemBuilder: (context, facilityIndex) {
                        final facility = category.facilities[facilityIndex];
                        
                        return Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.grey[50],
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: Colors.grey[200]!,
                              width: 1,
                            ),
                          ),
                          child: Row(
                            children: [
                              Icon(
                                _getIconData(facility.icon),
                                color: const Color(0xFF00C569),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  facility.name,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
