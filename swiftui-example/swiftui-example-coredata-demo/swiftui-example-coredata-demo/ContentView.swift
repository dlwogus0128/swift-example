//
//  ContentView.swift
//  swiftui-example-coredata-demo
//
//  Created by 픽셀로 on 2/2/24.
//

import SwiftUI
import CoreData

struct ContentView: View {
    
    // 사용자가 입력한 제품 이름과 수량을 저장할 두 개의 상태 객체
    @State var name: String = ""
    @State var quantity: String = ""
    
    // 뷰 콘텍스트 환경 객체에 대한 접근 권한
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(entity: Product.entity(),
                  sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)])    // 정렬 디스크립션 추가
    private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            VStack {
                TextField("Product name", text: $name)
                TextField("Product quantity", text: $quantity)
                
                HStack {
                    Spacer()
                    Button("Add") {
                        addProduct()
                    }
                    Spacer()
                    NavigationLink(destination: ResultView(name: name,
                                                           viewContext: viewContext),
                                   label: {
                        Text("Find")
                    })
                    Spacer()
                    Button("Clear") {
                        name = ""
                        quantity = ""
                    }
                    Spacer()
                }
                .padding()
                .frame(maxWidth: .infinity)
                
                List {
                    ForEach(products) { product in
                        HStack {
                            Text(product.name ?? "Not Found")
                            Spacer()
                            Text(product.quantity ?? "Not Found")
                        }
                    }
                    .onDelete(perform: deleteProducts)
                }
                .navigationTitle("Product Database")
            }
            .padding()
            .textFieldStyle(RoundedBorderTextFieldStyle())
        }
    }
    
    private func addProduct() {
        withAnimation {
            // 새로운 product Instance 생성
            let product = Product(context: viewContext)
            product.name = name
            product.quantity = quantity
            
            saveContext()
        }
    }
    
    private func saveContext() {
        do {
            try viewContext.save()
        } catch {
            let error = error as NSError
            fatalError("An error occurred: \(error)")
        }
    }
    
    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            saveContext()
        }
    }
}

struct ResultView: View {
    
    var name: String
    var viewContext: NSManagedObjectContext
    
    @State var matches: [Product]?  // 일치하는 제품의 검색 결과가 표시되도록
    
    var body: some View {
        
        return VStack {
            List {
                ForEach(matches ?? []) { match in
                    HStack {
                        Text(match.name ?? "Not Found")
                        Spacer()
                        Text(match.quantity ?? "Not found")
                    }
                }
            }
            .navigationTitle("Results")
        }
        .task {
            let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()  // 가져오기 요청
            fetchRequest.entity = Product.entity()
            fetchRequest.predicate = NSPredicate(format: "name CONTAINS %@", name)  // 해당 이름을 포함하고 있는지 찾음
            matches = try? viewContext.fetch(fetchRequest)
        }
    }
}

//#Preview {
//    ContentView()
//        .environment(\.managedObjectContext, PersistenceController.shared.container.viewContext)
//}
