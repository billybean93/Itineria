//
//  MapView.swift
//
//
//  Created by Bill Nguyen on 6/10/2024.
//


import SwiftUI
import MapKit
/// A view that displays a map with interactive pins and search functionality.
///
/// The `MapView` is a SwiftUI component that allows users to view a map, search for places, and interact with pins for various locations.
/// Users can search for places, toggle between map types (standard and satellite), and zoom in/out.
/// Additionally, users can toggle between 2D and 3D map modes.
///
/// - The map centers on a default location (San Francisco) with the ability to add pins dynamically based on user searches.
/// - Pins can be clicked to navigate to a detailed view for the location.
/// - A search bar allows users to look up places, and new pins are added to the map based on the search results.
/// - Buttons enable zooming, toggling map types (standard or satellite), and switching between 2D/3D views.
///
/// ## Topics
/// ### Properties
/// - `@StateObject placesManager`: Manages the API calls and data for searching places.
/// - `@State var searchQuery`: Holds the user's current search query.
/// - `@State var selectedPlace`: Stores the currently selected place.
/// - `@State var isSearching`: Tracks whether the user is in search mode.
/// - `@State var Pins`: Holds an array of `MapLocation` objects representing the pinned locations on the map.
/// - `@State var region`: Represents the current visible region of the map, which updates as users zoom or search.
/// - `@State var mapType`: Controls the type of map (standard or satellite).
/// - `@State var is3D`: Toggles between 2D and 3D map views.
///
/// ### View Components
/// - **Map Display**: The main map display that shows the region and any pins.
/// - **Search Bar**: Allows users to input search queries to find places. Results are shown in a dropdown and selected places update the map region.
/// - **Control Buttons**: Buttons to zoom in/out, toggle between 2D and 3D modes, and switch map types.
///
/// ## Example Usage
/// ```swift
/// struct ContentView: View {
///     var body: some View {
///         MapView()
///     }
/// }
/// ```
///
/// ## Detailed View Structure
/// - The map is embedded in a `ZStack`, allowing layered elements like buttons and the search bar.
/// - When a user selects a place from the search results, the map zooms in to that location and adds a pin.
/// - The control buttons allow users to interact with the map easily: zooming, switching views, or navigating to a detailed place view.
///
/// ## User Interaction
/// - Users can search for a place using the search bar, and matching places are displayed in a list. Selecting a place zooms the map to that location and adds a pin.
/// - Clicking a pin opens a detailed view for that location.
/// - Users can zoom in and out of the map using the plus and minus magnifying glass icons.
/// - Tapping the cube icon toggles between 2D and 3D views.
/// - Tapping the globe/map icon toggles between standard and satellite map views.
///
struct MapView : View {
    @StateObject private var placesManager = PlacesManager() // Manages the API calls and data
    @State private var searchQuery = "" // State for holding the user input
    @State private var selectedPlace: Place? // State for the selected place
    @State private var isSearching: Bool = true
    @State var Pins = [
        MapLocation(name: "London", coordinate: CLLocationCoordinate2D(latitude: 51.507222,longitude: -0.1275))
    ]
    @State private var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194),
        span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
    )
    
    @State private var mapType: MKMapType = .standard // Map type
    @State private var is3D: Bool = false // Toggle for 2D/3D mode
    @State private var path : [MapLocation] = []


    let latitude = -37.8136
    let longitude = 144.9631
 
    var body: some View {
        NavigationStack{
            
            ZStack
            {
                
                Map(coordinateRegion: $region, annotationItems: Pins) { pin in
                    MapAnnotation(coordinate: pin.coordinate) {
                        NavigationLink(destination: CarouselNewView(latitude: pin.coordinate.latitude, longitude: pin.coordinate.longitude)){
                            VStack {
                                Image(systemName: "mappin.circle.fill")
                                    .foregroundColor(.red)
                                    .font(.title)
                                    .imageScale(.large)
                                    .frame(width: 40, height:  40)
                                
                                
                                Text(pin.name)
                                    .foregroundColor(Color.black)
                                    .fontWeight(.bold)
                                    .font(.system(size: 13))
                                    .background(Color.white)
                                    .padding()
                                    .shadow(radius: 2)
                            }
                        }
                    }
                }
                
                .ignoresSafeArea()
                
                
                
                VStack {
                    // Search bar to input text
                    SearchBar(
                        searchQuery: $searchQuery,
                        
                        
                        onCommit: {
                            if !searchQuery.isEmpty {
                                placesManager.searchPlaces(query: searchQuery, latitude: latitude, longitude: longitude)
                                selectedPlace = nil // Reset selected place
                                
                            }
                        },
                        
                        
                        onTextChange: { newValue in
                            if !newValue.isEmpty {
                                placesManager.searchPlaces(query: newValue, latitude: latitude, longitude: longitude)
                            } else {
                                placesManager.places.removeAll() // Clear results if empty
                                isSearching = true
                            }
                        }
                    )
                    
                    
                    // Display a list of places if any
                    if !placesManager.places.isEmpty && !searchQuery.isEmpty && isSearching{
                        
                        
                        PlacesList(places: placesManager.places) { place in
                            selectedPlace = place
                            searchQuery = place.name
                            placesManager.places.removeAll()
                            isSearching = false
                            region = MKCoordinateRegion(
                                center: CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng), // Example: San Francisco
                                span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05) // Zoom level
                            )// Clear the dropdown after selection
                            //Add pin on selected location
                            Pins.append(MapLocation(name: place.name, coordinate: CLLocationCoordinate2D(latitude: place.geometry.location.lat, longitude: place.geometry.location.lng)))
                        }
                    }
                    Spacer()
                }
                
                
                //View controller buttons
                VStack {
                    Button(action: {
                        zoomMap(out: true)
                    }) {
                        Image(systemName: "minus.magnifyingglass")
                    }
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    // Zoom in button
                    Button(action: {
                        zoomMap(out: false)
                    }) {
                        Image(systemName: "plus.magnifyingglass")
                    }
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 1)
                    
                    
                    // 2D/3D toggle button
                    Button(action: {
                        toggle3DMode()
                    }) {
                        Image(systemName: is3D ? "cube.fill" : "cube")
                    }
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    
                    
                    // Map type toggle button (Standard/Satellite)
                    Button(action: {
                        toggleMapType()
                    }) {
                        Image(systemName: mapType == .standard ? "globe.americas.fill" : "map.fill")
                    }
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 5)
                    
                    //Navigate to ChatGPT Chatbot when clicked
                    NavigationLink(destination: ChatGPT()) {
                        Image(systemName: "message.badge") // Correct system image name
                            .padding(5)
                            .background(Color.white)
                            .cornerRadius(5)
                            .shadow(radius: 5)
                    }

                    
                }
                .offset(x: 170, y: 260)
                
                
                
            }
        }
    }
    /// Zooms the map in or out based on the `out` parameter.
    /// - Parameter out: A Boolean indicating whether to zoom out (true) or in (false)
    ///
    private func zoomMap(out: Bool) {
        let zoomFactor = out ? 2.0 : 0.5
        let newSpan = MKCoordinateSpan(
            latitudeDelta: region.span.latitudeDelta * zoomFactor,
            longitudeDelta: region.span.longitudeDelta * zoomFactor
        )
        region.span = newSpan
    }
    
    // Toggle between 2D and 3D mode
    private func toggle3DMode() {
        is3D.toggle()
    }
    
    // Toggle between map types (standard/satellite)
    private func toggleMapType() {
        mapType = mapType == .standard ? .satellite : .standard
    }

}

/// A view that provides a text field for searching places.
///
/// The `SearchBar` is a SwiftUI component designed to let users input search queries for places.
/// It binds the `searchQuery` state and triggers actions when the text changes or the user commits the search.
///
/// - Users can input their search query in a text field.
/// - It triggers an action when the search is submitted (`onCommit`).
/// - It also triggers an action on every change of the input (`onTextChange`).
///
/// ## Topics
/// ### Properties
/// - `@Binding searchQuery`: The query input by the user, bound to an external state.
/// - `var onCommit`: The action to be triggered when the user submits the query.
/// - `var onTextChange`: The action triggered whenever the search query changes.
///
/// ### Example Usage
/// ```swift
/// SearchBar(
///     searchQuery: $searchQuery,
///     onCommit: {
///         // Perform search on commit
///     },
///     onTextChange: { newValue in
///         // Handle the text change
///     }
/// )
/// ```
///
/// ## View Structure
/// - A `TextField` with a placeholder text ("Search for places...") is used for input.
/// - The `onCommit` closure is executed when the user presses return.
/// - The `onTextChange` closure is executed whenever the text in the field changes.
struct SearchBar: View {
    @Binding var searchQuery: String
    var onCommit: () -> Void
    var onTextChange: (String) -> Void

    var body: some View {
        TextField("Search for places...", text: $searchQuery, onCommit: onCommit)
//            .border(Color.gray, width: 2)
//            .font(.system(size: 20 , weight: .semibold))
            .frame(width: 350, height: 100, alignment: .bottom)
            .shadow(radius: 5)
            .cornerRadius(10)
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .offset(y: -10)
//            .background(Color.white)
            .onChange(of: searchQuery, perform: onTextChange)
    }
}

/// A view that represents a row for displaying a place in a list.
///
/// `PlaceRow` is a SwiftUI component that displays the name and address of a place in a button.
/// When the button is tapped, it triggers an action (usually to select the place).
///
/// - Displays a place's name and formatted address.
/// - Triggers the provided `onSelect` closure when tapped.
///
/// ## Topics
/// ### Properties
/// - `let place`: The place to be displayed, containing its name and formatted address.
/// - `var onSelect`: The action triggered when the place row is selected.
///
/// ### Example Usage
/// ```swift
/// PlaceRow(place: somePlace) {
///     // Handle place selection
/// }
/// ```
///
/// ## View Structure
/// - A `Button` wraps a `VStack` to display the place name and address.
/// - The `onSelect` closure is executed when the button is pressed.
struct PlaceRow: View {
    let place: Place
    let onSelect: () -> Void

    var body: some View {
        Button(action: onSelect) {
            VStack(alignment: .leading) {
                Text(place.name)
                    .font(.headline)
                    .foregroundColor(Color.black)
                Text(place.formattedAddress)
                    .font(.subheadline)
                    .foregroundColor(Color.black)
            }
        }
        .padding()
        .frame(width: 350, height: 50, alignment: .leading)
        .background(Color.white)
    }
}
/// A view that displays a scrollable list of places.
///
/// The `PlacesList` is a SwiftUI component that presents a vertical list of places.
/// Each place is represented by a `PlaceRow` view, and when a place is tapped, an action is triggered.
///
/// - Displays a list of places, each represented by a `PlaceRow`.
/// - When a row is tapped, the corresponding place is passed to the `onSelectPlace` closure.
///
/// ## Topics
/// ### Properties
/// - `let places`: An array of `Place` objects to be displayed in the list.
/// - `var onSelectPlace`: The closure to be called when a place is selected from the list.
///
/// ### Example Usage
/// ```swift
/// PlacesList(places: places) { selectedPlace in
///     // Handle place selection
/// }
/// ```
///
/// ## View Structure
/// - A `ScrollView` is used to display the list of `PlaceRow` views.
/// - The `onSelectPlace` closure is executed when a place is tapped.

struct PlacesList: View {
    let places: [Place]
    let onSelectPlace: (Place) -> Void

    var body: some View {
        ScrollView {
            ForEach(places) { place in
                PlaceRow(place: place) {
                    onSelectPlace(place)
                }
                .padding(.horizontal)
            }
        }
        .frame(width: 350, height: 300, alignment: .center)
        .background(Color.white)
        .cornerRadius(10)
    }
}

/// A model that represents a location on the map.
///
/// `MapLocation` is used to represent a place with a name and a geographic coordinate on the map.
/// It conforms to `Identifiable` for use in SwiftUI lists and maps.
///
/// - Each `MapLocation` has a unique identifier, a name, and a coordinate.
///
/// ## Topics
/// ### Properties
/// - `let id`: A unique identifier for the location.
/// - `let name`: The name of the location.
/// - `let coordinate`: The geographic coordinate (latitude and longitude) of the location.
///
/// ### Example Usage
/// ```swift
/// let location = MapLocation(name: "San Francisco", coordinate: CLLocationCoordinate2D(latitude: 37.7749, longitude: -122.4194))
/// ```
struct MapLocation: Identifiable {
    let id = UUID()
    let name: String
    let coordinate: CLLocationCoordinate2D
}

///
/// `CustomAnnotationView`is a SwiftUI view designed for use as a custom annotation on a map.
/// It displays a red map pin icon along with a name label beneath it.
///
/// - This view displays a map pin (using the "mappin.circle.fill" system icon) and a name below it.
/// - It is typically used within a `MapAnnotation` to display additional information about a map location.
///
/// ## Topics
/// ### Properties
/// - `var name`: The name of the location to be displayed below the map pin.
///
/// ### Example Usage
/// ```swift
/// CustomAnnotationView(name: "Golden Gate Bridge")
/// ```
///
/// ## View Structure
/// - A `VStack` containing the map pin icon and a `Text` label for the name.
/// - Both elements have shadows to improve visibility on the map.
struct CustomAnnotationView : View {
//    @Binding var path : [MapLocation]
    var name : String
    var body: some View {
        NavigationView {
            VStack {
                Image(systemName: "mappin.circle.fill")
                    .resizable()
                    .frame(width: 30, height: 30)
                    .foregroundColor(.red)
                    .background(Circle().fill(Color.white))
                    .shadow(radius: 3)
                
                Text(name)
                    .font(.caption)
                    .padding(5)
                    .background(Color.white)
                    .cornerRadius(5)
                    .shadow(radius: 3)
        }
            
        }
            .navigationBarTitle("Map")

    }
}


#Preview {
    MapView()
}


