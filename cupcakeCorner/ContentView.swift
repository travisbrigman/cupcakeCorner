//
//  ContentView.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var orders: Orders
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    Picker("Select your Cake Type", selection: $orders.order.type) {
                        ForEach(0..<Order.types.count, id: \.self ){
                            Text(Order.types[$0])
                        }
                    }
                    
                    Stepper(value: $orders.order.quantity, in: 3...20) {
                        Text("Number of Cakes: \(orders.order.quantity)")
                    }
                }
                
                Section {
                    Toggle(isOn: $orders.order.specialRequestEnabled.animation()) {
                        Text("Any Special Requests?")
                    }
                    
                    if orders.order.specialRequestEnabled {
                        Toggle(isOn: $orders.order.extraFrosting) {
                            Text("Add Extra Frosting")
                        }
                        Toggle(isOn: $orders.order.extraSprinkles) {
                            Text("Add Extra Sprinkles")
                        }
                    }
                }
                
                Section {
                    NavigationLink(destination: AddressView(orders: orders)) {
                        Text("Delivery Details")
                    }
                }
            }
        .navigationBarTitle("Cupcake Corner")
        }
        
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(orders: Orders())
    }
}
