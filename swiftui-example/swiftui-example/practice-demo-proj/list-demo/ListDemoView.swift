//
//  ListDemoView.swift
//  swiftui-example
//
//  Created by 픽셀로 on 1/30/24.
//

import SwiftUI

struct ToDoItem: Identifiable {
    var id = UUID()
    var task: String
    var imageName: String
}

struct ListDemoView: View {
    
    @State var listData: [ToDoItem] = [
        ToDoItem(task: "몽이 밥 주기", imageName: "dog.fill"),
        ToDoItem(task: "밥 먹기", imageName: "takeoutbag.and.cup.and.straw.fill"),
        ToDoItem(task: "빨래하기", imageName: "washer.fill")
    ]
    
    @State private var toggleSatus = true
    
    @State private var stackPath = NavigationPath()
    
    var body: some View {
        
        List {
            Text("Wash the car")
                .listRowSeparator(.hidden)  // 리스트 구분자 삭제
            Text("Vacuum house")
                .listRowSeparatorTint(Color.red, edges: .bottom)
            Text("Pick up kids from school bus @ 3pm")
                .listRowBackground(Image("MyBackgroundImage"))
            Text("Auction the kids on eBay")
            Text("Order Pizza for dinner")
        }
        
        List {
            HStack {
                Image(systemName: "trash.circle.fill")
                Text("Take out the trash")
            }
            
            HStack {
                Image(systemName: "person.2.fill")
                Text("Pick up the kids")
            }
            
            HStack {
                Image(systemName: "car.fill")
                Text("Wash the car")
            }
        }
        NavigationStack {
            List {
                Section(header: Text("Settings")) {
                    Toggle(isOn: $toggleSatus) {
                        Text("Allow Notifications")
                    }
                    
                    NavigationLink(value: listData.count) {
                        Text("View Task Count")
                    }
                }
                
                Section(header: Text("To Do Tasks")) {
                    ForEach (listData) { item in
                        NavigationLink(value: item.task) {
                            HStack {
                                Image(systemName: item.imageName)
                                    .padding(.trailing)
                                Text(item.task)
                            }
                        }
                    }
                    .onDelete(perform: deleteItem)
                    .onMove(perform: moveItem)
                }
            }
            .navigationTitle(Text("To Do List"))
            .navigationBarItems(trailing: EditButton()) // 편집 버튼을 이렇게 ..?간단하게?!?!?!!?!?
        }
        .navigationDestination(for: String.self) { task in
            Text("Selected task = \(task)")
        }
        // 스와이프 제스쳐를 하면 인디케이터와 함께 내부 실행
        // 새로고침
        .refreshable {
            listData = [
                ToDoItem(task: "저녁 시키기", imageName: "dollarsign.circle.fill")
            ]
        }
    }
    
    func deleteItem(at offsets: IndexSet) {
        // 데이터소스에서 항목을 삭제하는 코드를 여기에 가져옴
    }
    
    func moveItem(from source: IndexSet, to destination: Int) {
        // 항목을 재배열하는 코드가 옴
    }
}

#Preview {
    ListDemoView()
}
