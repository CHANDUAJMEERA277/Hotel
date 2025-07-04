import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/hotel.dart';
import '../data/sample_data.dart';
import '../widgets/facilities_section.dart';
import '../widgets/nearby_destinations_section.dart';
import '../widgets/accommodation_rules_section.dart';
import '../widgets/add_to_favorite_sheet.dart';
import '../widgets/review_modal.dart';
import 'all_facilities_screen.dart';
import 'room_selection_screen.dart';

class HotelDetailsScreen extends StatefulWidget {
  const HotelDetailsScreen({super.key});

  @override
  State<HotelDetailsScreen> createState() => _HotelDetailsScreenState();
}

class _HotelDetailsScreenState extends State<HotelDetailsScreen> {
  late Hotel hotel;
  bool isFavorite = false;

  @override
  void initState() {
    super.initState();
    hotel = SampleData.getSampleHotel();
    isFavorite = hotel.isFavorite;
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });
  }

  void _showAddToFavoriteSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => AddToFavoriteSheet(hotel: hotel),
    );
  }

  void _showReviewModal(Review review) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewModal(review: review),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          // Hotel Image Header
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            backgroundColor: Colors.white,
            leading: Container(
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.9),
                borderRadius: BorderRadius.circular(12),
              ),
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.black),
                onPressed: () => Navigator.pop(context),
              ),
            ),
            actions: [
              Container(
                margin: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.9),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: IconButton(
                  icon: Icon(
                    isFavorite ? Icons.favorite : Icons.favorite_border,
                    color: isFavorite ? const Color(0xFFEB5757) : Colors.black,
                  ),
                  onPressed: _toggleFavorite,
                ),
              ),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: ClipRRect(
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(0),
                  topRight: Radius.circular(0),
                ),
                child: CachedNetworkImage(
                  imageUrl: hotel.images.first,
                  fit: BoxFit.cover,
                  placeholder: (context, url) => Container(
                    color: Colors.grey[300],
                    child: const Center(child: CircularProgressIndicator()),
                  ),
                  errorWidget: (context, url, error) => Container(
                    color: Colors.grey[300],
                    child: const Icon(Icons.error),
                  ),
                ),
              ),
            ),
          ),
          
          // Hotel Details Content
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Hotel Name and Rating
                  Text(
                    hotel.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    hotel.address,
                    style: const TextStyle(
                      fontSize: 14,
                      color: Color(0xFF6E6E6E),
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  // Rating Row
                  Row(
                    children: [
                      const Icon(Icons.star, color: Color(0xFFFFC107), size: 20),
                      const SizedBox(width: 4),
                      Text(
                        hotel.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '(${hotel.reviewCount} reviews)',
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6E6E6E),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  
                  // Sample Review
                  if (hotel.reviews.isNotEmpty) ...[
                    GestureDetector(
                      onTap: () => _showReviewModal(hotel.reviews.first),
                      child: Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.grey[50],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Row(
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: CachedNetworkImageProvider(
                                hotel.reviews.first.userAvatar,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    hotel.reviews.first.userName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    hotel.reviews.first.comment,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color(0xFF6E6E6E),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  index < hotel.reviews.first.rating
                                      ? Icons.star
                                      : Icons.star_border,
                                  color: const Color(0xFFFFC107),
                                  size: 16,
                                );
                              }),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                  
                  // Popular Facilities
                  FacilitiesSection(facilities: hotel.facilities),
                  const SizedBox(height: 20),
                  
                  // Price and CTA Button
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'Price per night',
                              style: TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6E6E6E),
                              ),
                            ),
                            Text(
                              '\$${hotel.pricePerNight.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 24,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00C569),
                              ),
                            ),
                          ],
                        ),
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RoomSelectionScreen(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF00C569),
                            foregroundColor: Colors.white,
                            padding: const EdgeInsets.symmetric(
                              horizontal: 32,
                              vertical: 16,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                          ),
                          child: const Text(
                            'See Room',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  
                  // Nearby Destinations
                  NearbyDestinationsSection(
                    destinations: hotel.nearbyDestinations,
                    location: hotel.location,
                  ),
                  const SizedBox(height: 20),
                  
                  // Accommodation Rules
                  AccommodationRulesSection(rules: hotel.rules),
                  const SizedBox(height: 100), // Bottom padding for floating button
                ],
              ),
            ),
          ),
        ],
      ),
      
      // Floating Action Button for Add to Favorites
      floatingActionButton: FloatingActionButton.extended(
        onPressed: _showAddToFavoriteSheet,
        backgroundColor: const Color(0xFF00C569),
        foregroundColor: Colors.white,
        icon: const Icon(Icons.favorite_border),
        label: const Text('Add to Favorites'),
      ),
    );
  }
}
