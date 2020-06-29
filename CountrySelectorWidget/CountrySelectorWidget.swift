//
//  CountrySelectorWidget.swift
//  CountrySelectorWidget
//
//  Created by Ari Supriatna on 27/06/20.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    public typealias Entry = SimpleEntry
    @AppStorage("selectedCountry", store: UserDefaults(suiteName: "com.arisupriatna.CountrySelector"))
    var selectedCountry: Data = Data()

    public func snapshot(with context: Context, completion: @escaping (SimpleEntry) -> ()) {
        var entry: SimpleEntry
        if let decodedData = try? JSONDecoder().decode(Country.self, from: selectedCountry) {
            entry = SimpleEntry(date: Date(), country: decodedData)
        } else {
            entry = SimpleEntry(date: Date(), country: countries[0])
        }
        completion(entry)
    }

    public func timeline(with context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entry: SimpleEntry
        
        if let decodedData = try? JSONDecoder().decode(Country.self, from: selectedCountry) {
            entry = SimpleEntry(date: Date(), country: decodedData)
        } else {
            entry = SimpleEntry(date: Date(), country: countries[0])
        }
        
        let timeline = Timeline(entries: [entry], policy: .atEnd)
        completion(timeline)
    }
}

struct SimpleEntry: TimelineEntry {
    public let date: Date
    public let country: Country
}

struct PlaceholderView : View {
    var body: some View {
        VStack {
            Text("🇳🇵")
                .font(.largeTitle)
            Text("Nepal").font(.title2).multilineTextAlignment(.center)
            Text("Asia").font(.caption)
        }
    }
}

struct CountrySelectorWidgetEntryView : View {
    var entry: Provider.Entry
    
    @Environment(\.widgetFamily) var family

    @ViewBuilder
    var body: some View {
        switch family {
        case .systemSmall:
            VStack {
            Text(entry.country.flag)
                .font(.largeTitle)
            Text(entry.country.name).font(.title2).multilineTextAlignment(.center)
            Text(entry.country.continent).font(.caption)
            }
        case .systemMedium:
            VStack {
                Text(entry.country.flag)
                    .font(.largeTitle)
                Text("Your current country is \(entry.country.name), \(entry.country.continent).").font(.title).multilineTextAlignment(.center)
            }
        case .systemLarge:
            VStack {
                Text(entry.country.flag)
                    .font(.largeTitle)
                Text("Your current country is \(entry.country.name).").font(.largeTitle).multilineTextAlignment(.center)
                Text("It lies in \(entry.country.continent).").font(.title3)
            }
        @unknown default:
            fatalError()
        }
    }
}

@main
struct CountrySelectorWidget: Widget {
    private let kind: String = "CountrySelectorWidget"

    public var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider(), placeholder: PlaceholderView()) { entry in
            CountrySelectorWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Country Selector Widget")
        .supportedFamilies([.systemLarge, .systemMedium, .systemSmall])
        .description("Displays your current country")
    }
}

struct CountrySelectorWidget_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            CountrySelectorWidgetEntryView(entry: SimpleEntry(date: Date(), country: countries[0]))
                .previewContext(WidgetPreviewContext(family: .systemSmall))
            
            CountrySelectorWidgetEntryView(entry: SimpleEntry(date: Date(), country: countries[1]))
                .previewContext(WidgetPreviewContext(family: .systemMedium))
            
            CountrySelectorWidgetEntryView(entry: SimpleEntry(date: Date(), country: countries[2]))
                .previewContext(WidgetPreviewContext(family: .systemLarge))
        }
    }
}
