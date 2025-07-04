import 'package:flutter/material.dart';

class GuestSelectionModal extends StatefulWidget {
  final int adults;
  final int children;
  final int infants;
  final int maxGuests;
  final Function(int adults, int children, int infants) onGuestsSelected;

  const GuestSelectionModal({
    super.key,
    required this.adults,
    required this.children,
    required this.infants,
    required this.maxGuests,
    required this.onGuestsSelected,
  });

  @override
  State<GuestSelectionModal> createState() => _GuestSelectionModalState();
}

class _GuestSelectionModalState extends State<GuestSelectionModal> {
  late int adults;
  late int children;
  late int infants;

  @override
  void initState() {
    super.initState();
    adults = widget.adults;
    children = widget.children;
    infants = widget.infants;
  }

  int get totalGuests => adults + children + infants;
  bool get isAtMaxCapacity => totalGuests >= widget.maxGuests;

  Widget _buildGuestCounter({
    required String title,
    required String subtitle,
    required int count,
    required VoidCallback onIncrement,
    required VoidCallback onDecrement,
    required bool canIncrement,
    required bool canDecrement,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[300]!),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF6E6E6E),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: canDecrement ? const Color(0xFF00C569) : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: canDecrement ? onDecrement : null,
                  icon: const Icon(Icons.remove, size: 18),
                  color: canDecrement ? const Color(0xFF00C569) : Colors.grey[400],
                  padding: EdgeInsets.zero,
                ),
              ),
              Container(
                width: 50,
                child: Text(
                  count.toString(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  border: Border.all(
                    color: canIncrement ? const Color(0xFF00C569) : Colors.grey[300]!,
                  ),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: IconButton(
                  onPressed: canIncrement ? onIncrement : null,
                  icon: const Icon(Icons.add, size: 18),
                  color: canIncrement ? const Color(0xFF00C569) : Colors.grey[400],
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
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
                  'Select Guests',
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
          
          // Room capacity info
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF00C569).withOpacity(0.1),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Row(
              children: [
                const Icon(
                  Icons.info_outline,
                  color: Color(0xFF00C569),
                  size: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  'This room accommodates up to ${widget.maxGuests} guests',
                  style: const TextStyle(
                    fontSize: 14,
                    color: Color(0xFF00C569),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          
          const SizedBox(height: 24),
          
          // Guest counters
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                children: [
                  // Adults
                  _buildGuestCounter(
                    title: 'Adults',
                    subtitle: 'Ages 13 or above',
                    count: adults,
                    onIncrement: () {
                      if (!isAtMaxCapacity) {
                        setState(() => adults++);
                      }
                    },
                    onDecrement: () {
                      if (adults > 1) {
                        setState(() => adults--);
                      }
                    },
                    canIncrement: !isAtMaxCapacity,
                    canDecrement: adults > 1,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Children
                  _buildGuestCounter(
                    title: 'Children',
                    subtitle: 'Ages 2-12',
                    count: children,
                    onIncrement: () {
                      if (!isAtMaxCapacity) {
                        setState(() => children++);
                      }
                    },
                    onDecrement: () {
                      if (children > 0) {
                        setState(() => children--);
                      }
                    },
                    canIncrement: !isAtMaxCapacity,
                    canDecrement: children > 0,
                  ),
                  
                  const SizedBox(height: 16),
                  
                  // Infants
                  _buildGuestCounter(
                    title: 'Infants',
                    subtitle: 'Under 2 years',
                    count: infants,
                    onIncrement: () {
                      if (!isAtMaxCapacity) {
                        setState(() => infants++);
                      }
                    },
                    onDecrement: () {
                      if (infants > 0) {
                        setState(() => infants--);
                      }
                    },
                    canIncrement: !isAtMaxCapacity,
                    canDecrement: infants > 0,
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Current selection summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Total Guests',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              '$totalGuests guest${totalGuests != 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00C569),
                              ),
                            ),
                            if (totalGuests > widget.maxGuests)
                              const Text(
                                'Exceeds room capacity',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: Colors.red,
                                ),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          
          // Confirm button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: totalGuests <= widget.maxGuests && adults >= 1
                    ? () {
                        widget.onGuestsSelected(adults, children, infants);
                        Navigator.pop(context);
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
                  totalGuests <= widget.maxGuests && adults >= 1
                      ? 'Confirm Guests ($totalGuests)'
                      : totalGuests > widget.maxGuests
                          ? 'Too many guests'
                          : 'At least 1 adult required',
                  style: const TextStyle(
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
