//
//  ContentView.swift
//  watch-demo Watch App
//
//  Created by 픽셀로 on 2/26/24.
//

import SwiftUI

struct ListData: Identifiable {
    var id = UUID()
    var name: String
    var bgColor: Color
}

struct WatchContentView: View {
    
    var listData = [
        ListData(name: "김종명", bgColor: .blue),
        ListData(name: "노수인", bgColor: .yellow),
        ListData(name: "심재민", bgColor: .purple)
    ]
    
    var body: some View {
        VStack {
            List {
                ForEach(listData) { item in
                    HStack {
                        Text(item.name)
                        Spacer()
                    }
                    .padding()
                    .background(item.bgColor)
                    .cornerRadius(10)
                }
                .listRowBackground(Color.clear)
            }
        }
        .padding()
    }
}

#Preview {
    WatchContentView()
}
