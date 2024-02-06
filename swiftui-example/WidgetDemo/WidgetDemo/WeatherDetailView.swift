//
//  WeatherDetailView.swift
//  WidgetDemo
//
//  Created by 픽셀로 on 2/6/24.
//

import SwiftUI

struct WeatherDetailView: View {
    
    var weather: WeatherType
    
    var body: some View {
        VStack {
            Image(systemName: weather.icon)
                .resizable()
                .scaledToFit()
                .frame(width: 150.0, height: 150.0)
            Text(weather.name)
                .padding()
                .font(.title)
            Text("If this were a real weather app, a description of \(weather.name) would appear here.")
                .padding()
            Spacer()
        }
    }
}

struct WeatherDetailView_Previews: PreviewProvider {
    static var previews: some View {
        let weather = WeatherType(name: "Thunder Storms", icon: "cloud.bolt")
        WeatherDetailView(weather: weather)
    }
}
