class Hotel {
  final String id;
  final String name;
  final String address;
  final double rating;
  final int reviewCount;
  final List<String> images;
  final double pricePerNight;
  final String currency;
  final String description;
  final List<Facility> facilities;
  final List<NearbyDestination> nearbyDestinations;
  final HotelLocation location;
  final AccommodationRules rules;
  final List<Review> reviews;
  final bool isFavorite;

  Hotel({
    required this.id,
    required this.name,
    required this.address,
    required this.rating,
    required this.reviewCount,
    required this.images,
    required this.pricePerNight,
    required this.currency,
    required this.description,
    required this.facilities,
    required this.nearbyDestinations,
    required this.location,
    required this.rules,
    required this.reviews,
    this.isFavorite = false,
  });
}

class Facility {
  final String id;
  final String name;
  final String icon;
  final String description;
  final String category;

  Facility({
    required this.id,
    required this.name,
    required this.icon,
    required this.description,
    required this.category,
  });
}

class FacilityCategory {
  final String name;
  final String icon;
  final List<Facility> facilities;

  FacilityCategory({
    required this.name,
    required this.icon,
    required this.facilities,
  });
}

class NearbyDestination {
  final String name;
  final String type;
  final double distance;
  final String unit;

  NearbyDestination({
    required this.name,
    required this.type,
    required this.distance,
    required this.unit,
  });
}

class HotelLocation {
  final double latitude;
  final double longitude;
  final String address;

  HotelLocation({
    required this.latitude,
    required this.longitude,
    required this.address,
  });
}

class AccommodationRules {
  final String checkInTime;
  final String checkOutTime;
  final String childrenPolicy;
  final String aboutAccommodation;

  AccommodationRules({
    required this.checkInTime,
    required this.checkOutTime,
    required this.childrenPolicy,
    required this.aboutAccommodation,
  });
}

class Review {
  final String id;
  final String userName;
  final String userAvatar;
  final double rating;
  final String comment;
  final DateTime date;
  final List<String> photos;
  final Map<String, double> categoryRatings;

  Review({
    required this.id,
    required this.userName,
    required this.userAvatar,
    required this.rating,
    required this.comment,
    required this.date,
    required this.photos,
    required this.categoryRatings,
  });
}

class Collection {
  final String id;
  final String name;
  final String location;
  final List<String> hotelIds;

  Collection({
    required this.id,
    required this.name,
    required this.location,
    required this.hotelIds,
  });
}

class Room {
  final String id;
  final String name;
  final String type;
  final List<String> images;
  final double pricePerNight;
  final String currency;
  final int maxGuests;
  final double size;
  final String sizeUnit;
  final List<String> facilities;
  final String description;
  final bool isAvailable;

  Room({
    required this.id,
    required this.name,
    required this.type,
    required this.images,
    required this.pricePerNight,
    required this.currency,
    required this.maxGuests,
    required this.size,
    required this.sizeUnit,
    required this.facilities,
    required this.description,
    this.isAvailable = true,
  });
}
