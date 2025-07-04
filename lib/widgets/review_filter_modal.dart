import 'package:flutter/material.dart';

enum TimeFilter { latest, oldest }
enum RatingFilter { all, five, four, three, two, one }

class ReviewFilterModal extends StatefulWidget {
  final TimeFilter currentTimeFilter;
  final RatingFilter currentRatingFilter;
  final Function(TimeFilter, RatingFilter) onApplyFilters;

  const ReviewFilterModal({
    super.key,
    required this.currentTimeFilter,
    required this.currentRatingFilter,
    required this.onApplyFilters,
  });

  @override
  State<ReviewFilterModal> createState() => _ReviewFilterModalState();
}

class _ReviewFilterModalState extends State<ReviewFilterModal> {
  late TimeFilter selectedTimeFilter;
  late RatingFilter selectedRatingFilter;

  @override
  void initState() {
    super.initState();
    selectedTimeFilter = widget.currentTimeFilter;
    selectedRatingFilter = widget.currentRatingFilter;
  }

  String _getTimeFilterLabel(TimeFilter filter) {
    switch (filter) {
      case TimeFilter.latest:
        return 'Latest';
      case TimeFilter.oldest:
        return 'Oldest';
    }
  }

  String _getRatingFilterLabel(RatingFilter filter) {
    switch (filter) {
      case RatingFilter.all:
        return 'All Ratings';
      case RatingFilter.five:
        return '5 Stars';
      case RatingFilter.four:
        return '4 Stars';
      case RatingFilter.three:
        return '3 Stars';
      case RatingFilter.two:
        return '2 Stars';
      case RatingFilter.one:
        return '1 Star';
    }
  }

  Widget _buildFilterOption<T>({
    required String title,
    required T value,
    required T selectedValue,
    required Function(T) onChanged,
    required String Function(T) getLabel,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      child: InkWell(
        onTap: () => onChanged(value),
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            border: Border.all(
              color: selectedValue == value 
                  ? const Color(0xFF00C569) 
                  : Colors.grey[300]!,
              width: selectedValue == value ? 2 : 1,
            ),
            borderRadius: BorderRadius.circular(12),
            color: selectedValue == value 
                ? const Color(0xFF00C569).withOpacity(0.1) 
                : Colors.white,
          ),
          child: Row(
            children: [
              Icon(
                selectedValue == value 
                    ? Icons.radio_button_checked 
                    : Icons.radio_button_unchecked,
                color: selectedValue == value 
                    ? const Color(0xFF00C569) 
                    : Colors.grey,
              ),
              const SizedBox(width: 12),
              Text(
                getLabel(value),
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: selectedValue == value 
                      ? FontWeight.w600 
                      : FontWeight.normal,
                  color: selectedValue == value 
                      ? const Color(0xFF00C569) 
                      : Colors.black,
                ),
              ),
            ],
          ),
        ),
      ),
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
                  'Filter Reviews',
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
          
          // Filter Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Time Filter Section
                  const Text(
                    'Sort by Time',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  ...TimeFilter.values.map((filter) => 
                    _buildFilterOption<TimeFilter>(
                      title: 'Time',
                      value: filter,
                      selectedValue: selectedTimeFilter,
                      onChanged: (value) => setState(() => selectedTimeFilter = value),
                      getLabel: _getTimeFilterLabel,
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Rating Filter Section
                  const Text(
                    'Filter by Rating',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  
                  ...RatingFilter.values.map((filter) => 
                    _buildFilterOption<RatingFilter>(
                      title: 'Rating',
                      value: filter,
                      selectedValue: selectedRatingFilter,
                      onChanged: (value) => setState(() => selectedRatingFilter = value),
                      getLabel: _getRatingFilterLabel,
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
          
          // Apply Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  widget.onApplyFilters(selectedTimeFilter, selectedRatingFilter);
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF00C569),
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                child: const Text(
                  'Apply Filters',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
