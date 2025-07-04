import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import '../models/hotel.dart';

class EnhancedMapView extends StatefulWidget {
  final HotelLocation location;
  final List<NearbyDestination> destinations;

  const EnhancedMapView({
    super.key,
    required this.location,
    required this.destinations,
  });

  @override
  State<EnhancedMapView> createState() => _EnhancedMapViewState();
}

class _EnhancedMapViewState extends State<EnhancedMapView> {
  NearbyDestination? selectedDestination;
  String searchQuery = '';
  String selectedFilter = 'All';
  bool isSearchVisible = false;
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  List<NearbyDestination> get filteredDestinations {
    List<NearbyDestination> filtered = widget.destinations;

    // Apply type filter
    if (selectedFilter != 'All') {
      filtered = filtered.where((dest) => dest.type == selectedFilter).toList();
    }

    // Apply search query
    if (searchQuery.isNotEmpty) {
      filtered = filtered.where((dest) =>
        dest.name.toLowerCase().contains(searchQuery.toLowerCase()) ||
        dest.type.toLowerCase().contains(searchQuery.toLowerCase())
      ).toList();
    }

    return filtered;
  }

  List<String> get availableFilters {
    final types = widget.destinations.map((dest) => dest.type).toSet().toList();
    return ['All', ...types];
  }

  IconData _getDestinationIcon(String type) {
    switch (type.toLowerCase()) {
      case 'attraction':
        return Icons.attractions;
      case 'restaurant':
        return Icons.restaurant;
      case 'shopping':
        return Icons.shopping_bag;
      case 'activity':
        return Icons.sports_handball;
      default:
        return Icons.place;
    }
  }

  Color _getDestinationColor(String type) {
    switch (type.toLowerCase()) {
      case 'attraction':
        return Colors.purple;
      case 'restaurant':
        return Colors.orange;
      case 'shopping':
        return Colors.blue;
      case 'activity':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  List<Marker> _buildMarkers() {
    List<Marker> markers = [];

    // Hotel marker
    markers.add(
      Marker(
        point: LatLng(widget.location.latitude, widget.location.longitude),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: const Color(0xFF00C569),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.white, width: 3),
          ),
          child: const Icon(
            Icons.hotel,
            color: Colors.white,
            size: 24,
          ),
        ),
      ),
    );

    // Destination markers (simulated positions around hotel) - using filtered destinations
    final destinations = filteredDestinations;
    for (int i = 0; i < destinations.length; i++) {
      final destination = destinations[i];
      // Simulate nearby positions (in real app, you'd have actual coordinates)
      final lat = widget.location.latitude + (i * 0.01) - 0.015;
      final lng = widget.location.longitude + ((i % 2) * 0.02) - 0.01;
      
      markers.add(
        Marker(
          point: LatLng(lat, lng),
          child: GestureDetector(
            onTap: () {
              setState(() {
                selectedDestination = destination;
              });
              _showDestinationBottomSheet(destination);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: _getDestinationColor(destination.type),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Icon(
                _getDestinationIcon(destination.type),
                color: Colors.white,
                size: 20,
              ),
            ),
          ),
        ),
      );
    }
    
    return markers;
  }

  void _showDestinationBottomSheet(NearbyDestination destination) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(20),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Handle bar
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
            const SizedBox(height: 16),
            
            // Destination info
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: _getDestinationColor(destination.type).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    _getDestinationIcon(destination.type),
                    color: _getDestinationColor(destination.type),
                    size: 24,
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        destination.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        destination.type,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Color(0xFF6E6E6E),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFF00C569).withOpacity(0.1),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    '${destination.distance} ${destination.unit}',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: Color(0xFF00C569),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 20),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: () {
                      // Add directions functionality
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.directions, size: 18),
                    label: const Text('Directions'),
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00C569)),
                      foregroundColor: const Color(0xFF00C569),
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () {
                      // Add more info functionality
                      Navigator.pop(context);
                    },
                    icon: const Icon(Icons.info, size: 18),
                    label: const Text('More Info'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C569),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 12),
                    ),
                  ),
                ),
              ],
            ),
            
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Map
          FlutterMap(
            options: MapOptions(
              initialCenter: LatLng(widget.location.latitude, widget.location.longitude),
              initialZoom: 14.0,
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.example.hotel',
                maxZoom: 19,
                subdomains: const ['a', 'b', 'c'],
                additionalOptions: const {
                  'attribution': '© OpenStreetMap contributors',
                },
              ),
              MarkerLayer(markers: _buildMarkers()),
            ],
          ),
          
          // Top bar with search
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).padding.top + 8,
                left: 16,
                right: 16,
                bottom: 16,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                children: [
                  // Header row
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Navigator.pop(context),
                        icon: const Icon(Icons.arrow_back, color: Colors.black),
                      ),
                      Expanded(
                        child: Text(
                          isSearchVisible ? 'Search Destinations' : 'Nearby Destinations',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                      IconButton(
                        onPressed: () {
                          setState(() {
                            isSearchVisible = !isSearchVisible;
                            if (!isSearchVisible) {
                              _searchController.clear();
                              searchQuery = '';
                              selectedFilter = 'All';
                            }
                          });
                        },
                        icon: Icon(
                          isSearchVisible ? Icons.close : Icons.search,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),

                  // Search bar (when visible)
                  if (isSearchVisible) ...[
                    const SizedBox(height: 12),
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: TextField(
                        controller: _searchController,
                        onChanged: (value) {
                          setState(() {
                            searchQuery = value;
                          });
                        },
                        decoration: const InputDecoration(
                          hintText: 'Search destinations...',
                          prefixIcon: Icon(Icons.search, color: Colors.grey),
                          border: InputBorder.none,
                          contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                        ),
                      ),
                    ),

                    const SizedBox(height: 12),

                    // Filter chips
                    SizedBox(
                      height: 40,
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: availableFilters.length,
                        itemBuilder: (context, index) {
                          final filter = availableFilters[index];
                          final isSelected = selectedFilter == filter;

                          return Container(
                            margin: const EdgeInsets.only(right: 8),
                            child: FilterChip(
                              label: Text(filter),
                              selected: isSelected,
                              onSelected: (selected) {
                                setState(() {
                                  selectedFilter = filter;
                                });
                              },
                              selectedColor: const Color(0xFF00C569).withOpacity(0.2),
                              checkmarkColor: const Color(0xFF00C569),
                              labelStyle: TextStyle(
                                color: isSelected ? const Color(0xFF00C569) : Colors.black,
                                fontWeight: isSelected ? FontWeight.w600 : FontWeight.normal,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
          
          // Legend and Results Counter
          Positioned(
            bottom: 100,
            right: 16,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                // Results counter
                if (isSearchVisible || searchQuery.isNotEmpty)
                  Container(
                    margin: const EdgeInsets.only(bottom: 8),
                    padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C569),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      '${filteredDestinations.length} result${filteredDestinations.length != 1 ? 's' : ''}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),

                // Legend
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 8,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        'Legend',
                        style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      // Hotel marker
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              width: 16,
                              height: 16,
                              decoration: const BoxDecoration(
                                color: Color(0xFF00C569),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.hotel,
                                color: Colors.white,
                                size: 10,
                              ),
                            ),
                            const SizedBox(width: 6),
                            const Text(
                              'Hotel',
                              style: TextStyle(fontSize: 10),
                            ),
                          ],
                        ),
                      ),
                      // Destination types (filtered)
                      ...filteredDestinations.map((dest) => dest.type).toSet().map((type) =>
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 2),
                          child: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Container(
                                width: 16,
                                height: 16,
                                decoration: BoxDecoration(
                                  color: _getDestinationColor(type),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getDestinationIcon(type),
                                  color: Colors.white,
                                  size: 10,
                                ),
                              ),
                              const SizedBox(width: 6),
                              Text(
                                type,
                                style: const TextStyle(fontSize: 10),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
