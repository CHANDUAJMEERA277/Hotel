# Hotel Booking App – UI Design Requirements

## Screen 05 – Hotel Details Screen

This screen showcases detailed information about a selected hotel. It includes image banners, hotel info, user reviews, popular facilities, a map, and interactions like "Add to Favorites" and "Create New Collection".

---

### 🎨 Color Scheme

| Element                     | Color Code       |
|----------------------------|------------------|
| Primary Button (Green)     | `#00C569`        |
| Background                 | `#FFFFFF` (White)|
| Text - Primary             | `#000000`        |
| Text - Secondary           | `#6E6E6E`        |
| Icon Backgrounds           | Light Gray       |
| Rating Star (Gold)         | `#FFC107`        |
| Favorite Heart (Red)       | `#EB5757`        |

---

### 📱 UI Components & Layouts

#### 5.1 – Hotel Details
- Fullscreen image of the hotel (rounded corners at top).
- Back & Favorite buttons (top corners).
- Hotel Name, Address, Star Rating (with count).
- One sample review with user image.
- **Popular Facilities** – horizontal scroll with icons (Sunny, Free WiFi, Beach, etc.).
- Price per night and CTA Button: **“See Room”**.

#### 5.2 – Scrolling Section 1
- Continues hotel details.
- Section: Nearby Destinations (e.g., Zoo, Restaurant) with distance.
- Small embedded map view (non-interactive).
- Button: **See map**.

#### 5.3 – Scrolling Section 2
- Searchable list of locations (drop-down/filter).
- Accommodation Rules
  - Check-in/Check-out Time
  - Children Info
  - About Accommodation paragraph
- Price & CTA Button persists: **“See Room”**.

#### 5.4 – Add to Favorite
- Modal sheet.
- Lists user collections grouped by location (Bali, UK, Maldives, etc.).
- Button: **“Create New Collection”**

#### 5.5 – Create New Collection
- Modal sheet with:
  - Text input: **Collection Name**
  - Button: **Create**

#### 5.6 – Open Review
- Modal sheet opens individual review with:
  - Review text
  - Date
  - User avatar

#### 5.7 – All Reviews
- List of reviews with:
  - Star rating
  - Review categories: Facilities, Service, Cleanliness, etc.
  - Photos uploaded by guests
  - Horizontal image scroll
  - Date, username

---

### 🧩 Fonts & Typography

- Likely using **Google Fonts** – Suggest: `Poppins` or `Montserrat` (match your Figma).
- Heading: Bold
- Body: Regular
- Rating & Price: Emphasized (semi-bold)

---

### 🔁 Scroll Behavior

- Main screen supports vertical scroll for content.
- Facilities and Images are horizontally scrollable.
- Modal sheets slide up from bottom.

---

### 🗺️ Map View

- Embedded mini map for hotel location (use `flutter_map` or `Google Maps Flutter`).
- Not interactive; just displays pin.

---

### ❤️ Favorite & Collection Features

- “Heart” icon toggles favorite state.
- Collections are customizable.
- Modal pop-ups for managing favorites and creating new collections.

---

### 📸 Assets

Ensure the following folders exist under `assets/`:


# Hotel Booking App – UI Design Requirements (Part 2)

## Screens 5.7 to 5.19 – Extended Hotel Details, Reviews, Facilities & Booking Flow

---

### 5.7 – All Reviews (Base View)
- Displays total rating and review categories (Facilities, Cleanliness, Service, Value, Location).
- Horizontal scroll of guest-uploaded images.
- Individual review cards: Avatar, Name, Rating, Date, Review Text.

### 5.8 – All Reviews (Filter)
- Bottom sheet modal.
- Filters: 
  - Time (Latest, Oldest)
  - Rating (All, 5★, 4★, etc.)
- Apply button (Green: `#00C569`).

### 5.9 – All Reviews (Photos Only)
- Shows grid gallery of images submitted by guests.
- On tap → Full screen photo viewer.

### 5.10 – Review Details
- Modal sheet showing expanded review.
- Large image with navigation dots.
- Reviewer name, date, full review.

---

### 5.11 – All Facilities
- Scrollable list of facilities.
- Sectioned as:
  - Popular Facilities (icon grid view)
  - Public Facilities
  - Room Facilities
  - Food & Drinks
  - Business, Medical, etc.
- Use expansion tiles or collapsible sections.

---

### 5.12 – Location (Map View)
- Fullscreen interactive map.
- Hotel location pin centered.
- Bottom drawer with hotel name and address.

### 5.13 – Nearby Destinations
- Nearby places shown on map with labeled icons.
- Bottom sheet shows name + distance from hotel.
- Icons represent type (restaurant, zoo, mall, etc.).

---

### 5.14 – Accommodation Rules
- Static scrollable content.
- Lists check-in/check-out times, child policy, etc.
- Markdown-style formatting or RichText widget.

### 5.15 – About Accommodation
- Paragraph about the hotel/resort.
- Use justified alignment.
- Supports scrollable long-form content.

---

### 5.16 – Room Selection Screen
- List of available rooms.
- Room image, type, facilities.
- Price per night.
- “See Details” + “Book Now” buttons.

### 5.17 – Change Booking Details
- Bottom sheet.
- Select date range + guest details.
- Green confirm button.

### 5.18 – Booking Date Selector
- Calendar popup to choose check-in and check-out dates.
- Navigation arrows for months.
- Green date selection highlight.

### 5.19 – Booking Details (Guests)
- Bottom sheet for guest selection.
- Select number of:
  - Adults
  - Children
  - Infants
- Plus/minus steppers for each.
- Confirm button with summary.

---

### 🎨 Color Codes (Used Throughout)

| Element                    | Color Code       |
|---------------------------|------------------|
| Primary Button/CTA        | `#00C569`        |
| Filter Modal Background   | `#FFFFFF`        |
| Header Background         | `#F9F9F9`        |
| Text - Primary            | `#000000`        |
| Text - Subtle             | `#6E6E6E`        |
| Map Pin                   | `#000000`        |
| Selected Date Highlight   | `#00C569`        |

---

### 🧩 UX Behavior

- All modals and bottom sheets must be:
  - Smooth sliding with bounce animation
  - Dismissible by swiping or tapping outside
- Calendar must not allow reverse-date selection
- Guest picker should remember previously selected values
- Reviews must support lazy loading for large datasets

---

### 📸 Assets Needed

Ensure the following folders exist under `assets/`:

