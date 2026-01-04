### Check out Project-Report.pdf for the full report

# iPhone Software Engineering Assessment 1 Report

**App Name:** Itineria

**Category:** Travel, Planning

### Student Details

* **Phan Duc Anh Nguyen** (S3915181)
* **Daniel La** (S3909873)

### Session Details

* **Tutorial Session:** Wednesday 5:30 PM - 7:30 PM
* **Tutor:** James Dale
* **Instructor:** Shekhar Kalra
* **Institution:** RMIT University (COSC2472)

---

## Introduction

Welcome to **Itineria**, a travel app designed to enhance and simplify the travel planning experience. This app is being developed by group **iPSE_22**, consisting of members Daniel La and Phan Duc Anh Nguyen. This report describes the development process of our platform.

### Project Links

* **GitHub Repository:** [https://github.com/rmit-iPSE-2024-s2/a1-S3909873-S3915181.git](https://github.com/rmit-iPSE-2024-s2/a1-S3909873-S3915181.git)
* **Figma (Wireframes Prototype):** [View Prototype on Figma](https://www.google.com/search?q=https://www.figma.com/design/N2yovaok9L6B7kQxfZ9L0g/iPhone-Engineering-Prototype-Design%3Fnode-id%3D0-1%26t%3Drtlu6xyzjy146XP7-1)

---

## Table of Contents

1. [The Purpose of Itineria](https://www.google.com/search?q=%23the-purpose-of-itineria)
2. [Detailed Review of 4 Related Travel Apps](https://www.google.com/search?q=%23detailed-review-of-4-related-travel-apps)
* Stippl App
* Wanderlog App
* Sygic Travel App
* Polarsteps App


3. [Human Interface Guideline](https://www.google.com/search?q=%23human-interface-guideline)
4. [Wireframes](https://www.google.com/search?q=%23wireframes)
5. [Data Requirements and API](https://www.google.com/search?q=%23data-requirements-and-api)
6. [Data Model](https://www.google.com/search?q=%23data-model)
7. [API](https://www.google.com/search?q=%23api)
8. [References](https://www.google.com/search?q=%23references)

---

## The Purpose of Itineria

Our travel app is specifically designed for travelers, offering a comprehensive travel planner that simplifies the entire travel planning process. The app's main task is for users to create detailed itineraries with integrated map functionalities. Users can select their desired destinations, along with adding notes, descriptions, and pictures, to create an informative travel plan or memory.

The itineraries can also be shared with friends and family, enabling users to share their memorable experiences with others. By incorporating this core feature within our app, we aim to address common travel challenges by helping users stay organized, informed, and connected throughout their journeys, ultimately making their travel experience more enjoyable and stress-free.

---

## Detailed Review of 4 Related Travel Apps

### Stippl App

Stippl helps users streamline trip planning by offering comprehensive itinerary management. After a detailed review, Stippl closely aligns with the travel app we aim to develop. It facilitates effective organization of activities, schedules, and destinations. We plan to adopt a similar minimalistic design and light-colored contrast.

* **Pros:** Great contrast, simple and effective design. Many features for planning.
* **Cons:** Can be overwhelming for novice travelers. Features are not always well-explained, leading to confusion during registration.

**Potential Features to Adopt:**

* **Profile:** A clean and organized layout for user profiles.
* **Trip Creation:** A straightforward process for planning and customizing itineraries.

### Wanderlog App

Wanderlog focuses on sharing itineraries, experiences, and travel guides with a shared community. It provides public travel guides, supports itinerary management, and allows for hotel bookings.

* **Pros:** Vibrant color contrast, community-focused guides.
* **Cons:** The planning interface can feel clustered and overwhelming. Text fonts are occasionally poorly sized.

**Potential Features to Adopt:**

* **Sharing Trips:** Utilizing ellipsis menus on itineraries for quick access to "share," "edit," and "delete" functions without cluttering the UI.

### Sygic Travel App

Sygic centers its features around a map-based experience. It offers a detailed overview of hotspots, tourist attractions, and hotels with booking capabilities.

* **Pros:** Highly interactive map-centric planning.
* **Cons:** Much content is locked behind a paywall. The itinerary planning is not as comprehensive as competitors.

**Potential Features to Adopt:**

* **Map Search Engine:** Highlights key interests (restaurants, attractions) directly on the map.

### Polarsteps App

Polarsteps is a travel tracking app that allows users to document their journey in real-time, creating a visual diary.

* **Pros:** Excellent real-time tracking and documentary features.
* **Cons:** Not optimized for detailed itinerary planning or organization prior to the trip.

**Potential Features to Adopt:**

* **Itinerary Layout:** A clean, vertical timeline layout that is ideal for organized reference.

---

## Human Interface Guideline

### App Icons

We are using a simple design that captures the essence of the app without text. The icon features a globe vector with a white, green, and blue color palette. It follows the HIG suggested rounded corner square shape with a high contrast ratio for recognizability.

### Colour

The app uses a minimal 3-color palette (White, Blue, Green). This ensures clarity and avoids distraction. The colors were chosen specifically to ensure readability and aesthetic appeal in both Light and Dark modes.

### Maps

As a core feature, we use a standard map style for full saturation. A search filter is implemented to help users find content easily. We ensure the Apple logo and legal links are visible per HIG standards.

### Settings

We minimize the number of options to prevent confusion. The settings tab is limited to three items: Change Password, Privacy & Policy, and Notifications.

### Tab View

A standard bottom navigation bar with three tabs is used to avoid layout issues. Each tab includes a clear label.

---

## Wireframes

### Profile Screen

The user’s personal page for viewing details like username and profile picture. It provides access to created itineraries and saved trips.

### Create Itinerary Screen

Allows users to input trip details, including dates, titles, and descriptions. Once created, users can begin adding specific destinations.

### Map Screen

An interactive map for searching destinations. Includes features like a search bar, 3D view, compass, and "my location."

### Edit Profile Screen

Allows users to update personal info (Email, Bio, Date of Birth). This ensures the app feels personalized.

### Settings Screen

A hub for managing app configurations like notifications and privacy.

---

## Data Requirements and API

### User

* **UserID:** Unique ID for each user.
* **Name:** Full name.
* **Email:** Address for login and notifications.
* **ProfilePicture:** URL to image.
* **Network:** List of FriendIDs.

### Itinerary

* **ItineraryID:** Unique identifier.
* **CreatorID:** Reference to the user.
* **Title, StartDate, EndDate.**
* **Counts:** Number of activities and destinations.
* **SharedWith:** List of users.

### Destination

* **DestinationID:** Unique identifier.
* **Location Data:** Country, City, Coordinates, Google Maps URL.
* **Description:** Summary of the location.

---

## Data Model

### Relationships

* **User -> Itinerary:** One-to-Many.
* **Itinerary -> ItineraryItem:** One-to-Many.
* **Destination -> Activity:** One-to-Many.
* **Shared Itinerary:** Many-to-Many between Users and Itineraries.

---

## API

We plan to implement several free APIs:

* **OpenWeatherMap API:** To provide current weather data for destinations.
* **Geonames API:** To retrieve geographical data and coordinates.
* **Google Places API:** To get detailed addresses and photos of POIs.
* **Mapbox / Here Maps API:** For routing, navigation data, and map displays.
* **Eventbrite API:** To populate itineraries with local events and activities.

---

## References

* AppStuff (2023). *AMAZING NEW SwiftUI MapKit Features | iOS 17 | WWDC23*. [YouTube].
* Daniel Budd (2021). *Setting an Image as a Button - Introduction to SwiftUI*. [YouTube].
* RMIT Credits (2024). *Example 9 - Custom Layout* [Code Archive].
* Core SwiftUI (2022). *Using ChatGPT: How to Create a Spinning Rainbow SwiftUI Animation*. [YouTube].
* Wang H (2022). *SwiftUI: How to scale and rotate an image view*. Fokswang Website.
* Indently (2021). *How to create a Bottom Navigation Bar with TabView in Xcode*. [YouTube].
