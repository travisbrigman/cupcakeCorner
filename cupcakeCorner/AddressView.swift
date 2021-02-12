//
//  AddressView.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct AddressView: View {
    @ObservedObject var orders: Orders
    
    var body: some View {
        Form {
                Section {
                    TextField("Name", text: $orders.order.name)
                    TextField("Street Address", text: $orders.order.streetAddress)
                    TextField("City", text: $orders.order.city)
                    TextField("Zip", text: $orders.order.zip)
                }
                
                Section {
                    NavigationLink(destination: CheckoutView(orders: orders)){
                        Text("Checkout")
                    }
                }
                .disabled(orders.order.hasValidAdress == false)
            }
            .navigationBarTitle("Delivery Details", displayMode: .inline)
        }
    }


struct AddressView_Previews: PreviewProvider {
    static var previews: some View {
        AddressView(orders: Orders())
    }
}
