import 'package:flutter/material.dart';
import '../models/hotel.dart';
import 'date_selector_modal.dart';
import 'guest_selection_modal.dart';

class BookingDetails {
  final DateTime checkInDate;
  final DateTime checkOutDate;
  final int adults;
  final int children;
  final int infants;

  BookingDetails({
    required this.checkInDate,
    required this.checkOutDate,
    required this.adults,
    required this.children,
    required this.infants,
  });

  int get totalGuests => adults + children + infants;
  int get nights => checkOutDate.difference(checkInDate).inDays;
}

class BookingDetailsModal extends StatefulWidget {
  final Room room;

  const BookingDetailsModal({
    super.key,
    required this.room,
  });

  @override
  State<BookingDetailsModal> createState() => _BookingDetailsModalState();
}

class _BookingDetailsModalState extends State<BookingDetailsModal> {
  late BookingDetails bookingDetails;

  @override
  void initState() {
    super.initState();
    // Initialize with default values
    final now = DateTime.now();
    bookingDetails = BookingDetails(
      checkInDate: now.add(const Duration(days: 1)),
      checkOutDate: now.add(const Duration(days: 3)),
      adults: 2,
      children: 0,
      infants: 0,
    );
  }

  String _formatDate(DateTime date) {
    final months = [
      'Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun',
      'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'
    ];
    return '${date.day} ${months[date.month - 1]} ${date.year}';
  }

  void _showDateSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => DateSelectorModal(
        checkInDate: bookingDetails.checkInDate,
        checkOutDate: bookingDetails.checkOutDate,
        onDatesSelected: (checkIn, checkOut) {
          setState(() {
            bookingDetails = BookingDetails(
              checkInDate: checkIn,
              checkOutDate: checkOut,
              adults: bookingDetails.adults,
              children: bookingDetails.children,
              infants: bookingDetails.infants,
            );
          });
        },
      ),
    );
  }

  void _showGuestSelector() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => GuestSelectionModal(
        adults: bookingDetails.adults,
        children: bookingDetails.children,
        infants: bookingDetails.infants,
        maxGuests: widget.room.maxGuests,
        onGuestsSelected: (adults, children, infants) {
          setState(() {
            bookingDetails = BookingDetails(
              checkInDate: bookingDetails.checkInDate,
              checkOutDate: bookingDetails.checkOutDate,
              adults: adults,
              children: children,
              infants: infants,
            );
          });
        },
      ),
    );
  }

  double get totalPrice => widget.room.pricePerNight * bookingDetails.nights;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.8,
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
                  'Booking Details',
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
          
          // Content
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Room Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[50],
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00C569).withOpacity(0.1),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Icon(
                            Icons.hotel,
                            color: Color(0xFF00C569),
                            size: 30,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.room.name,
                                style: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                widget.room.type,
                                style: const TextStyle(
                                  fontSize: 14,
                                  color: Color(0xFF6E6E6E),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          '\$${widget.room.pricePerNight.toStringAsFixed(0)}',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF00C569),
                          ),
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Date Selection
                  const Text(
                    'Select Dates',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _showDateSelector,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF00C569),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Check-in → Check-out',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                                Text(
                                  '${_formatDate(bookingDetails.checkInDate)} → ${_formatDate(bookingDetails.checkOutDate)}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  '${bookingDetails.nights} night${bookingDetails.nights != 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF6E6E6E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 20),
                  
                  // Guest Selection
                  const Text(
                    'Select Guests',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: _showGuestSelector,
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[300]!),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.people,
                            color: Color(0xFF00C569),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  'Guests',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Color(0xFF6E6E6E),
                                  ),
                                ),
                                Text(
                                  '${bookingDetails.totalGuests} guest${bookingDetails.totalGuests != 1 ? 's' : ''}',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                if (bookingDetails.children > 0 || bookingDetails.infants > 0)
                                  Text(
                                    '${bookingDetails.adults} adults${bookingDetails.children > 0 ? ', ${bookingDetails.children} children' : ''}${bookingDetails.infants > 0 ? ', ${bookingDetails.infants} infants' : ''}',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF6E6E6E),
                                    ),
                                  ),
                              ],
                            ),
                          ),
                          const Icon(
                            Icons.chevron_right,
                            color: Color(0xFF6E6E6E),
                          ),
                        ],
                      ),
                    ),
                  ),
                  
                  const SizedBox(height: 24),
                  
                  // Price Summary
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFF00C569).withOpacity(0.1),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              '\$${widget.room.pricePerNight.toStringAsFixed(0)} × ${bookingDetails.nights} night${bookingDetails.nights != 1 ? 's' : ''}',
                              style: const TextStyle(
                                fontSize: 14,
                                color: Color(0xFF6E6E6E),
                              ),
                            ),
                            Text(
                              '\$${totalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                          ],
                        ),
                        const Divider(height: 20),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Total',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              '\$${totalPrice.toStringAsFixed(0)}',
                              style: const TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF00C569),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
          
          // Confirm Button
          Padding(
            padding: const EdgeInsets.all(16),
            child: SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: bookingDetails.totalGuests <= widget.room.maxGuests
                    ? () {
                        // Process booking
                        Navigator.pop(context);
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'Booking confirmed for ${widget.room.name}!',
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
                  bookingDetails.totalGuests <= widget.room.maxGuests
                      ? 'Confirm Booking - \$${totalPrice.toStringAsFixed(0)}'
                      : 'Too many guests for this room',
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
