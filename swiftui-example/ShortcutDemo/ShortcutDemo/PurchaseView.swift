//
//  PurchaseView.swift
//  ShortcutDemo
//
//  Created by Neil Smyth on 7/29/22.
//

import SwiftUI

struct PurchaseView: View {
    
    @State var symbol: String = ""
    @State var quantity: String = ""
    @State var status: String = "Enter symbol and quantity"
    
    @State var purchaseData: PurchaseData = PurchaseData()
    
    @AppStorage("demostorage", store: UserDefaults(
                    suiteName: "group.com.ebookfrenzy.shortcutdemo")) var store: Data = Data()
    
    @Environment(\.scenePhase) private var scenePhase
    
    var body: some View {
        
        VStack {
            Form {
                HStack {
                    Spacer()
                    Text("Purchase Stocks")
                        .bold()
                    Spacer()
                }
                TextField("Symbol", text: $symbol)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
            
                TextField("Quantity", text: $quantity)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                HStack {
                    Spacer()
                    Text(status)
                        .font(.footnote)
                    Spacer()
                }
            
                HStack {
                    Spacer()
                    Button(action: {
                        buyStock()
                    }) {
                        Text("Purchase")
                    }
                    Spacer()
                }
            }
        }
        .onAppear() {
            print("PurchaseView: onAppear")
            purchaseData.refresh()
        }
    }
    
    private func buyStock() {
        if (symbol == "" || quantity == "") {
            status = "Please enter a symbol and quantity"
        } else {
            if purchaseData.saveTransaction(symbol: symbol, quantity: quantity) {
                status = "Purchase completed"
            }
        }
    }
}

struct PurchaseView_Previews: PreviewProvider {
    static var previews: some View {
        PurchaseView()
    }
}

