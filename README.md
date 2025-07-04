# 🏨 Hotel Booking App

A comprehensive Flutter hotel booking application with advanced features for hotel discovery, room selection, and booking management.

## ✨ Features

### 🏨 Hotel Details
- **Hotel Information**: Complete hotel details with images, ratings, and reviews
- **Interactive Image Gallery**: Swipeable hotel images with full-screen viewing
- **Guest Reviews**: Detailed reviews with photos and category ratings
- **Facilities Overview**: Categorized facilities with icons and descriptions

### 🔍 Advanced Search & Filtering
- **Review Filters**: Filter reviews by time (Latest/Oldest) and rating (1-5 stars)
- **Photo Gallery**: Grid view of all guest photos with zoom functionality
- **Destination Search**: Search nearby destinations with real-time filtering
- **Interactive Maps**: Full-screen maps with destination markers and info sheets

### 🛏️ Room Selection & Booking
- **Room Browser**: Visual room selection with detailed specifications
- **Smart Calendar**: Date range selection with intuitive calendar interface
- **Guest Management**: Adults, children, and infants selection with capacity validation
- **Dynamic Pricing**: Real-time price calculation based on dates and guests

### 🗺️ Location & Navigation
- **Interactive Maps**: Flutter Map integration with custom markers
- **Nearby Destinations**: Color-coded destination types (Attractions, Restaurants, Shopping, Activities)
- **Location Details**: Distance calculations and destination information
- **Search Functionality**: Real-time search and filtering of destinations

### ❤️ Favorites & Collections
- **Favorite Hotels**: Save hotels to personalized collections
- **Collection Management**: Create and organize custom hotel collections
- **Quick Access**: Easy access to saved hotels

## 🛠️ Technical Stack

- **Framework**: Flutter 3.x
- **Language**: Dart
- **Maps**: Flutter Map with OpenStreetMap
- **Images**: Cached Network Image for optimized loading
- **Fonts**: Google Fonts (Poppins)
- **Architecture**: Modular widget-based architecture

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Windows (Desktop)
- ✅ Web

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.0 or higher)
- Dart SDK
- Android Studio / VS Code
- Android SDK (for Android development)
- Xcode (for iOS development)

### Installation

1. **Clone the repository**
   ```bash
   git clone https://github.com/yourusername/hotel-booking-app.git
   cd hotel-booking-app
   ```

2. **Install dependencies**
   ```bash
   flutter pub get
   ```

3. **Run the app**
   ```bash
   flutter run
   ```

### Building for Production

**Android APK:**
```bash
flutter build apk --release
```

**iOS:**
```bash
flutter build ios --release
```

**Windows:**
```bash
flutter build windows --release
```

## 📂 Project Structure

```
lib/
├── main.dart                 # App entry point
├── models/                   # Data models
│   └── hotel.dart           # Hotel, Room, Review models
├── screens/                  # Main screens
│   ├── hotel_details_screen.dart
│   ├── room_selection_screen.dart
│   └── all_facilities_screen.dart
├── widgets/                  # Reusable widgets
│   ├── facilities_section.dart
│   ├── review_modal.dart
│   ├── booking_details_modal.dart
│   └── enhanced_map_view.dart
└── data/                    # Sample data
    └── sample_data.dart
```

## 🎨 Design System

- **Primary Color**: #00C569 (Green)
- **Typography**: Poppins font family
- **Design Language**: Material Design 3
- **Responsive**: Adapts to different screen sizes

## 🤝 Contributing

1. Fork the repository
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📄 License

This project is licensed under the MIT License.

## 🙏 Acknowledgments

- Flutter team for the amazing framework
- OpenStreetMap for map data
- Material Design for UI guidelines
