//
//  CheckoutView.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var order: Order
    
    @State private var confirmationMessage = ""
    @State private var showingConfirmation = false
    @State private var errorMessage = ""
    @State private var showingError = false
    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your Total Is: $\(self.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("place order"){
                        self.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showingConfirmation) {
            Alert(title: Text("Thank You"), message: Text(confirmationMessage), dismissButton: .default(Text("OK")))
        }
        .alert(isPresented: $showingError) {
            Alert(title: Text("Error"), message: Text(errorMessage), dismissButton: .default(Text("OK")))
        }
    }
    func placeOrder()  {
        guard let encoded =  try? JSONEncoder().encode(order) else {
            print("failed to encode order")
            return
        }
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        var request = URLRequest(url: url)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded
        
        URLSession.shared.dataTask(with: request) {
            data, response, error in
            guard let data = data else {
                print("No Data In Response: \(error?.localizedDescription ?? "Unknown Error").")
                self.errorMessage = error?.localizedDescription ?? "Unknown Error"
                self.showingError = true
                return
            }
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                self.confirmationMessage = "Your Order For \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingConfirmation = true
            } else {
                print("invalid response from server")
            }
        }.resume()
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(order: Order())
    }
}
