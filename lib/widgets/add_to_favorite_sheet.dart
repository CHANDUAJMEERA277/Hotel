import 'package:flutter/material.dart';
import '../models/hotel.dart';
import '../data/sample_data.dart';
import 'create_collection_sheet.dart';

class AddToFavoriteSheet extends StatefulWidget {
  final Hotel hotel;

  const AddToFavoriteSheet({
    super.key,
    required this.hotel,
  });

  @override
  State<AddToFavoriteSheet> createState() => _AddToFavoriteSheetState();
}

class _AddToFavoriteSheetState extends State<AddToFavoriteSheet> {
  List<Collection> collections = [];
  Set<String> selectedCollections = {};

  @override
  void initState() {
    super.initState();
    collections = SampleData.getSampleCollections();
  }

  void _toggleCollection(String collectionId) {
    setState(() {
      if (selectedCollections.contains(collectionId)) {
        selectedCollections.remove(collectionId);
      } else {
        selectedCollections.add(collectionId);
      }
    });
  }

  void _showCreateCollectionSheet() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const CreateCollectionSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.7,
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        children: [
          // Handle bar
          Container(
            margin: const EdgeInsets.only(top: 12),
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: Colors.grey[300],
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          
          // Header
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Add to Favorites',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          
          // Collections List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: collections.length,
              itemBuilder: (context, index) {
                final collection = collections[index];
                final isSelected = selectedCollections.contains(collection.id);
                
                return Container(
                  margin: const EdgeInsets.only(bottom: 12),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isSelected 
                          ? const Color(0xFF00C569) 
                          : Colors.grey[300]!,
                      width: isSelected ? 2 : 1,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    onTap: () => _toggleCollection(collection.id),
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: const Color(0xFF00C569).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: const Icon(
                        Icons.collections_bookmark,
                        color: Color(0xFF00C569),
                      ),
                    ),
                    title: Text(
                      collection.name,
                      style: const TextStyle(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    subtitle: Text(
                      '${collection.location} • ${collection.hotelIds.length} hotels',
                      style: const TextStyle(
                        color: Color(0xFF6E6E6E),
                      ),
                    ),
                    trailing: isSelected
                        ? const Icon(
                            Icons.check_circle,
                            color: Color(0xFF00C569),
                          )
                        : const Icon(
                            Icons.radio_button_unchecked,
                            color: Colors.grey,
                          ),
                  ),
                );
              },
            ),
          ),
          
          // Bottom Actions
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              children: [
                // Create New Collection Button
                SizedBox(
                  width: double.infinity,
                  child: OutlinedButton(
                    onPressed: _showCreateCollectionSheet,
                    style: OutlinedButton.styleFrom(
                      side: const BorderSide(color: Color(0xFF00C569)),
                      foregroundColor: const Color(0xFF00C569),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
                      'Create New Collection',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                
                const SizedBox(height: 12),
                
                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: selectedCollections.isNotEmpty
                        ? () {
                            // Save to selected collections
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(
                                  'Added to ${selectedCollections.length} collection(s)',
                                ),
                                backgroundColor: const Color(0xFF00C569),
                              ),
                            );
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF00C569),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      selectedCollections.isEmpty
                          ? 'Select Collections'
                          : 'Add to ${selectedCollections.length} Collection(s)',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
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
