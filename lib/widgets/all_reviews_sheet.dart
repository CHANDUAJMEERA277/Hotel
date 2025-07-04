import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../models/hotel.dart';
import '../data/sample_data.dart';
import 'review_filter_modal.dart';
import 'photos_only_view.dart';

class AllReviewsSheet extends StatefulWidget {
  const AllReviewsSheet({super.key});

  @override
  State<AllReviewsSheet> createState() => _AllReviewsSheetState();
}

class _AllReviewsSheetState extends State<AllReviewsSheet> {
  List<Review> reviews = [];
  List<Review> filteredReviews = [];
  TimeFilter currentTimeFilter = TimeFilter.latest;
  RatingFilter currentRatingFilter = RatingFilter.all;

  @override
  void initState() {
    super.initState();
    reviews = SampleData.getSampleHotel().reviews;
    filteredReviews = List.from(reviews);
    _applyFilters();
  }

  void _applyFilters() {
    setState(() {
      filteredReviews = List.from(reviews);

      // Apply rating filter
      if (currentRatingFilter != RatingFilter.all) {
        int targetRating = _getRatingFromFilter(currentRatingFilter);
        filteredReviews = filteredReviews.where((review) =>
          review.rating.floor() == targetRating).toList();
      }

      // Apply time filter
      if (currentTimeFilter == TimeFilter.latest) {
        filteredReviews.sort((a, b) => b.date.compareTo(a.date));
      } else {
        filteredReviews.sort((a, b) => a.date.compareTo(b.date));
      }
    });
  }

  int _getRatingFromFilter(RatingFilter filter) {
    switch (filter) {
      case RatingFilter.five: return 5;
      case RatingFilter.four: return 4;
      case RatingFilter.three: return 3;
      case RatingFilter.two: return 2;
      case RatingFilter.one: return 1;
      default: return 0;
    }
  }

  void _showFilterModal() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => ReviewFilterModal(
        currentTimeFilter: currentTimeFilter,
        currentRatingFilter: currentRatingFilter,
        onApplyFilters: (timeFilter, ratingFilter) {
          currentTimeFilter = timeFilter;
          currentRatingFilter = ratingFilter;
          _applyFilters();
        },
      ),
    );
  }

  void _showPhotosOnlyView() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PhotosOnlyView(reviews: reviews),
      ),
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.9,
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
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'All Reviews (${filteredReviews.length})',
                      style: const TextStyle(
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
                const SizedBox(height: 12),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _showFilterModal,
                        icon: const Icon(Icons.filter_list, size: 18),
                        label: const Text('Filter'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF00C569)),
                          foregroundColor: const Color(0xFF00C569),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: OutlinedButton.icon(
                        onPressed: _showPhotosOnlyView,
                        icon: const Icon(Icons.photo_library, size: 18),
                        label: const Text('Photos'),
                        style: OutlinedButton.styleFrom(
                          side: const BorderSide(color: Color(0xFF00C569)),
                          foregroundColor: const Color(0xFF00C569),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          
          // Reviews List
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: filteredReviews.length,
              itemBuilder: (context, index) {
                final review = filteredReviews[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 20),
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    color: Colors.grey[50],
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // User Info and Rating
                      Row(
                        children: [
                          CircleAvatar(
                            radius: 20,
                            backgroundImage: CachedNetworkImageProvider(review.userAvatar),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  review.userName,
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  _formatDate(review.date),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: const Color(0xFF00C569).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                const Icon(
                                  Icons.star,
                                  color: Color(0xFFFFC107),
                                  size: 14,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  review.rating.toString(),
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF00C569),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Review Text
                      Text(
                        review.comment,
                        style: const TextStyle(
                          fontSize: 14,
                          height: 1.4,
                          color: Colors.black,
                        ),
                      ),
                      
                      const SizedBox(height: 12),
                      
                      // Category Ratings (Compact)
                      if (review.categoryRatings.isNotEmpty) ...[
                        Wrap(
                          spacing: 12,
                          runSpacing: 8,
                          children: review.categoryRatings.entries.map((entry) => 
                            Container(
                              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(8),
                                border: Border.all(color: Colors.grey[300]!),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Text(
                                    entry.key,
                                    style: const TextStyle(fontSize: 12),
                                  ),
                                  const SizedBox(width: 4),
                                  Icon(
                                    Icons.star,
                                    color: const Color(0xFFFFC107),
                                    size: 12,
                                  ),
                                  const SizedBox(width: 2),
                                  Text(
                                    entry.value.toString(),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ).toList(),
                        ),
                        const SizedBox(height: 12),
                      ],
                      
                      // Review Photos
                      if (review.photos.isNotEmpty) ...[
                        SizedBox(
                          height: 80,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: review.photos.length,
                            itemBuilder: (context, photoIndex) {
                              return Container(
                                width: 80,
                                margin: const EdgeInsets.only(right: 8),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(8),
                                  child: CachedNetworkImage(
                                    imageUrl: review.photos[photoIndex],
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) => Container(
                                      color: Colors.grey[300],
                                      child: const Center(
                                        child: CircularProgressIndicator(strokeWidth: 2),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) => Container(
                                      color: Colors.grey[300],
                                      child: const Icon(Icons.error, size: 16),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                        ),
                      ],
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
