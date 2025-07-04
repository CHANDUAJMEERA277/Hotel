import '../models/hotel.dart';

class SampleData {
  static List<Facility> getAllFacilities() {
    return [
      // Popular Facilities
      Facility(id: "1", name: "Free WiFi", icon: "wifi", description: "High-speed internet throughout the property", category: "Popular"),
      Facility(id: "2", name: "Beach Access", icon: "beach_access", description: "Private beach with crystal clear waters", category: "Popular"),
      Facility(id: "3", name: "Swimming Pool", icon: "pool", description: "Infinity pool with ocean views", category: "Popular"),
      Facility(id: "4", name: "Spa", icon: "spa", description: "Full-service spa with wellness treatments", category: "Popular"),
      Facility(id: "5", name: "Restaurant", icon: "restaurant", description: "Fine dining with international cuisine", category: "Popular"),
      Facility(id: "6", name: "Gym", icon: "fitness_center", description: "24/7 fitness center with modern equipment", category: "Popular"),

      // Public Facilities
      Facility(id: "7", name: "Reception", icon: "hotel", description: "24-hour front desk service", category: "Public"),
      Facility(id: "8", name: "Concierge", icon: "support_agent", description: "Personal concierge service", category: "Public"),
      Facility(id: "9", name: "Parking", icon: "local_parking", description: "Free parking for guests", category: "Public"),
      Facility(id: "10", name: "Elevator", icon: "elevator", description: "High-speed elevators", category: "Public"),
      Facility(id: "11", name: "Garden", icon: "local_florist", description: "Beautiful tropical gardens", category: "Public"),
      Facility(id: "12", name: "Library", icon: "library_books", description: "Quiet reading area", category: "Public"),

      // Room Facilities
      Facility(id: "13", name: "Air Conditioning", icon: "ac_unit", description: "Individual climate control", category: "Room"),
      Facility(id: "14", name: "Mini Bar", icon: "wine_bar", description: "Stocked mini refrigerator", category: "Room"),
      Facility(id: "15", name: "Safe", icon: "lock", description: "In-room safety deposit box", category: "Room"),
      Facility(id: "16", name: "Balcony", icon: "balcony", description: "Private balcony with ocean view", category: "Room"),
      Facility(id: "17", name: "TV", icon: "tv", description: "Smart TV with streaming services", category: "Room"),
      Facility(id: "18", name: "Coffee Maker", icon: "coffee_maker", description: "In-room coffee and tea facilities", category: "Room"),

      // Food & Drinks
      Facility(id: "19", name: "Bar", icon: "local_bar", description: "Poolside bar with tropical cocktails", category: "Food & Drinks"),
      Facility(id: "20", name: "Room Service", icon: "room_service", description: "24/7 in-room dining service", category: "Food & Drinks"),
      Facility(id: "21", name: "Breakfast", icon: "free_breakfast", description: "Complimentary breakfast buffet", category: "Food & Drinks"),
      Facility(id: "22", name: "BBQ", icon: "outdoor_grill", description: "Beachside barbecue facilities", category: "Food & Drinks"),

      // Business
      Facility(id: "23", name: "Business Center", icon: "business_center", description: "Fully equipped business facilities", category: "Business"),
      Facility(id: "24", name: "Meeting Room", icon: "meeting_room", description: "Conference rooms for events", category: "Business"),
      Facility(id: "25", name: "Printer", icon: "print", description: "Printing and copying services", category: "Business"),

      // Medical
      Facility(id: "26", name: "First Aid", icon: "medical_services", description: "On-site medical assistance", category: "Medical"),
      Facility(id: "27", name: "Pharmacy", icon: "local_pharmacy", description: "Basic medical supplies available", category: "Medical"),
    ];
  }

  static List<FacilityCategory> getFacilityCategories() {
    final allFacilities = getAllFacilities();

    return [
      FacilityCategory(
        name: "Popular Facilities",
        icon: "star",
        facilities: allFacilities.where((f) => f.category == "Popular").toList(),
      ),
      FacilityCategory(
        name: "Public Facilities",
        icon: "public",
        facilities: allFacilities.where((f) => f.category == "Public").toList(),
      ),
      FacilityCategory(
        name: "Room Facilities",
        icon: "hotel",
        facilities: allFacilities.where((f) => f.category == "Room").toList(),
      ),
      FacilityCategory(
        name: "Food & Drinks",
        icon: "restaurant",
        facilities: allFacilities.where((f) => f.category == "Food & Drinks").toList(),
      ),
      FacilityCategory(
        name: "Business",
        icon: "business",
        facilities: allFacilities.where((f) => f.category == "Business").toList(),
      ),
      FacilityCategory(
        name: "Medical",
        icon: "medical_services",
        facilities: allFacilities.where((f) => f.category == "Medical").toList(),
      ),
    ];
  }

  static Hotel getSampleHotel() {
    return Hotel(
      id: "hotel_001",
      name: "Grand Paradise Resort",
      address: "123 Beach Boulevard, Maldives",
      rating: 4.8,
      reviewCount: 1247,
      images: [
        "https://picsum.photos/800/600?random=1",
        "https://picsum.photos/800/600?random=2",
        "https://picsum.photos/800/600?random=3",
        "https://picsum.photos/800/600?random=4",
      ],
      pricePerNight: 299.99,
      currency: "USD",
      description: "Experience luxury at its finest with our beachfront resort featuring world-class amenities and breathtaking ocean views.",
      facilities: getAllFacilities(),
      nearbyDestinations: [
        NearbyDestination(name: "Marine Zoo", type: "Attraction", distance: 2.5, unit: "km"),
        NearbyDestination(name: "Sunset Restaurant", type: "Restaurant", distance: 1.2, unit: "km"),
        NearbyDestination(name: "Local Market", type: "Shopping", distance: 3.8, unit: "km"),
        NearbyDestination(name: "Diving Center", type: "Activity", distance: 0.8, unit: "km"),
      ],
      location: HotelLocation(
        latitude: 4.1755,
        longitude: 73.5093,
        address: "123 Beach Boulevard, Maldives",
      ),
      rules: AccommodationRules(
        checkInTime: "3:00 PM",
        checkOutTime: "11:00 AM",
        childrenPolicy: "Children under 12 stay free when using existing bedding",
        aboutAccommodation: "Our resort offers a perfect blend of luxury and comfort with stunning ocean views, world-class dining, and exceptional service. Each room features modern amenities and private balconies overlooking the crystal-clear waters.",
      ),
      reviews: [
        Review(
          id: "review_001",
          userName: "Sarah Johnson",
          userAvatar: "https://picsum.photos/100/100?random=10",
          rating: 5.0,
          comment: "Absolutely amazing experience! The staff was incredibly friendly and the views were breathtaking. Would definitely come back!",
          date: DateTime.now().subtract(const Duration(days: 5)),
          photos: [
            "https://picsum.photos/400/300?random=11",
            "https://picsum.photos/400/300?random=12",
          ],
          categoryRatings: {
            "Facilities": 4.8,
            "Service": 5.0,
            "Cleanliness": 4.9,
            "Location": 5.0,
            "Value": 4.7,
          },
        ),
        Review(
          id: "review_002",
          userName: "Michael Chen",
          userAvatar: "https://picsum.photos/100/100?random=20",
          rating: 4.5,
          comment: "Great hotel with excellent facilities. The pool area is fantastic and the food was delicious.",
          date: DateTime.now().subtract(const Duration(days: 12)),
          photos: [
            "https://picsum.photos/400/300?random=21",
          ],
          categoryRatings: {
            "Facilities": 4.7,
            "Service": 4.5,
            "Cleanliness": 4.8,
            "Location": 4.6,
            "Value": 4.3,
          },
        ),
      ],
      isFavorite: false,
    );
  }

  static List<Collection> getSampleCollections() {
    return [
      Collection(
        id: "col_001",
        name: "Beach Resorts",
        location: "Maldives",
        hotelIds: ["hotel_001", "hotel_002"],
      ),
      Collection(
        id: "col_002",
        name: "City Hotels",
        location: "UK",
        hotelIds: ["hotel_003"],
      ),
      Collection(
        id: "col_003",
        name: "Luxury Stays",
        location: "Bali",
        hotelIds: ["hotel_004", "hotel_005"],
      ),
    ];
  }

  static List<Room> getSampleRooms() {
    return [
      Room(
        id: "room_001",
        name: "Ocean View Suite",
        type: "Suite",
        images: [
          "https://picsum.photos/800/600?random=101",
          "https://picsum.photos/800/600?random=102",
          "https://picsum.photos/800/600?random=103",
        ],
        pricePerNight: 450.00,
        currency: "USD",
        maxGuests: 4,
        size: 65,
        sizeUnit: "m²",
        facilities: [
          "Ocean View",
          "King Bed",
          "Private Balcony",
          "Mini Bar",
          "Free WiFi",
          "Air Conditioning",
          "Room Service",
        ],
        description: "Luxurious suite with panoramic ocean views, featuring a spacious living area and private balcony.",
      ),
      Room(
        id: "room_002",
        name: "Deluxe Beach Villa",
        type: "Villa",
        images: [
          "https://picsum.photos/800/600?random=201",
          "https://picsum.photos/800/600?random=202",
        ],
        pricePerNight: 650.00,
        currency: "USD",
        maxGuests: 6,
        size: 120,
        sizeUnit: "m²",
        facilities: [
          "Beach Access",
          "Private Pool",
          "2 Bedrooms",
          "Kitchen",
          "Garden View",
          "Free WiFi",
          "Air Conditioning",
          "Butler Service",
        ],
        description: "Exclusive beachfront villa with private pool and direct beach access, perfect for families.",
      ),
      Room(
        id: "room_003",
        name: "Standard Double Room",
        type: "Standard",
        images: [
          "https://picsum.photos/800/600?random=301",
          "https://picsum.photos/800/600?random=302",
        ],
        pricePerNight: 199.00,
        currency: "USD",
        maxGuests: 2,
        size: 35,
        sizeUnit: "m²",
        facilities: [
          "Garden View",
          "Double Bed",
          "Mini Bar",
          "Free WiFi",
          "Air Conditioning",
          "Safe",
        ],
        description: "Comfortable standard room with modern amenities and garden views.",
      ),
      Room(
        id: "room_004",
        name: "Premium Ocean Room",
        type: "Premium",
        images: [
          "https://picsum.photos/800/600?random=401",
        ],
        pricePerNight: 320.00,
        currency: "USD",
        maxGuests: 3,
        size: 45,
        sizeUnit: "m²",
        facilities: [
          "Ocean View",
          "Queen Bed",
          "Balcony",
          "Mini Bar",
          "Free WiFi",
          "Air Conditioning",
          "Coffee Maker",
        ],
        description: "Premium room with stunning ocean views and modern furnishings.",
      ),
    ];
  }
}
