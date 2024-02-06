//
//  ContentView.swift
//  WidgetDemo
//
//  Created by 픽셀로 on 2/6/24.
//

import SwiftUI

struct WeatherType: Hashable {
    var name: String
    var icon: String
}

struct ContentView: View {
    var body: some View {
        
        @State var path = NavigationPath()
        
        NavigationStack(path: $path) {
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
                .navigationTitle("Severe Weather")
            }
        }
        .navigationDestination(for: WeatherType.self,
                               destination: { weather in
            WeatherDetailView(weather: weather)
        })
        .navigationTitle("Severe Weather")
        .onOpenURL(perform: { url in
            if (!path.isEmpty) {
                path.removeLast(path.count)
            }
            
            if (url == hailUrl) {
                path.append(WeatherType(name: "Hail Storm",
                                        icon: "cloud.hail"))
            } else if (url == thunderUrl) {
                path.append(WeatherType(name: "Thunder Storm", 
                                        icon: "cloud.bolt.rain"))
            } else if (url == tropicalUrl) {
                path.append(WeatherType(name: "Tropical Storm", 
                                        icon: "tropicalstorm"))
            }
        })
    }
}

#Preview {
    ContentView()
}
