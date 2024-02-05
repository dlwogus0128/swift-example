//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 픽셀로 on 2/5/24.
//

import SwiftUI

struct WeatherType: Hashable {
    var name: String
    var icon: String
}

struct ContentView: View {
    var body: some View {
        
        NavigationStack {
            List {
                NavigationLink(value: WeatherType(name: "Hail Storm",
                                                  icon: "cloud.hail"), 
                               label: {
                    Label("Hail Storm", systemImage: "cloud.hail")
                })
                NavigationLink(value: WeatherType(name: "Thunder Storm", 
                                                  icon: "cloud.bolt.rain"), 
                               label: {
                    Label("Thunder Storm", systemImage: "cloud.bolt.rain")
                })
                NavigationLink(value: WeatherType(name: "Tropical Storm", 
                                                  icon: "tropicalstorm"),
                               label: {
                    Label("Tropical Storm", systemImage: "tropicalstorm")
                })
            }
            .navigationDestination(for: WeatherType.self) { weather in
                WeatherDetailView(weather: weather)
            }
            .navigationTitle("Severe Weather")
        }
    }
}

//#Preview {
//    ContentView()
//}
