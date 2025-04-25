//
//  ItineriaWidget.swift
//  ItineriaWidget
//
//  Created by Bill Nguyen on 13/10/2024.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), imageName: "paris")
    }

    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), imageName: "paris")
        completion(entry)
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        let images: [String] = ["japan", "venice", "paris", "america","sydney", "china"]
        
        for hourOffset in 0 ..< 5 {
            let imageName = images[hourOffset % images.count] // Cycle through the images
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            let entry = SimpleEntry(date: entryDate, imageName: imageName)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let imageName: String
}

struct ItineriaWidgetEntryView : View {
    var entry: Provider.Entry

    var body: some View {

            Image(entry.imageName)
                .resizable()
                .scaledToFill()
                .frame(width: .infinity, height: .infinity)
                .overlay(
                    Text("Have you ever been to \(entry.imageName)?")
                        .font(.headline)
                        .padding(5)
                        .background(Color.white)
                        .shadow(radius: 10)
                        .cornerRadius(5)
                        .offset(y: -50)
                        
                    )
                

    }
}

struct ItineriaWidget: Widget {
    let kind: String = "ItineriaWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            if #available(iOS 17.0, *) {
                ItineriaWidgetEntryView(entry: entry)
                    .containerBackground(.fill.tertiary, for: .widget)
            } else {
                ItineriaWidgetEntryView(entry: entry)
                    .padding()
                    .background()
            }
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

#Preview(as: .systemMedium) {
    ItineriaWidget()
} timeline: {
    SimpleEntry(date: .now, imageName: "america")
    SimpleEntry(date: .now, imageName: "paris")
}
