//
//  CheckoutView.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import SwiftUI

struct CheckoutView: View {
    @ObservedObject var orders: Orders
    
    @State private var alertTitle = ""
    @State private var alertMessage = ""
    @State private var showingAlert = false


    var body: some View {
        GeometryReader { geo in
            ScrollView {
                VStack {
                    Image("cupcakes")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width)
                    Text("Your Total Is: $\(self.orders.order.cost, specifier: "%.2f")")
                        .font(.title)
                    
                    Button("place order"){
                        self.placeOrder()
                    }
                .padding()
                }
            }
        }
        .navigationBarTitle("Checkout", displayMode: .inline)
        .alert(isPresented: $showingAlert) {
            Alert(title: Text(alertTitle), message: Text(alertMessage), dismissButton: .default(Text("OK")))
        }

    }
    
    // this function sends a post request to a dummy site that sends back whatever we send it.
    func placeOrder()  {
        //encode the struct we've populated with data to JSON
        guard let encoded =  try? JSONEncoder().encode(orders.order) else {
            print("failed to encode order")
            return
        }
        //establish a URL to send request to
        let url = URL(string: "https://reqres.in/api/cupcakes")!
        //establish istance of requet
        var request = URLRequest(url: url)
        //set values needed to make a successful request
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        request.httpBody = encoded //notice this is where we send our struct data
        
        //now that we have built a request, we can try and send it
        URLSession.shared.dataTask(with: request) {
            //the 3 things below are always established, there's always a response, and either an error or data, not both
            data, response, error in
            //optional binding...
            guard let data = data else {
                // if data is unwrapped to nil, handle errors
                print("No Data In Response: \(error?.localizedDescription ?? "Unknown Error").")
                //set the alert message info
                self.alertTitle = "Error!"
                self.alertMessage = error?.localizedDescription ?? "Unknown Error"
                self.showingAlert = true
                return
            }
            //decode the data we got back from above. Notice Order.self is a direct reference to the struct. We are refrencing the data model and then mapping our data ('from:data') to that model
            if let decodedOrder = try? JSONDecoder().decode(Order.self, from: data) {
                //set the alert message info
                self.alertTitle = "🧁 Hooray!! 🧁"
                self.alertMessage = "Your Order For \(decodedOrder.quantity) x \(Order.types[decodedOrder.type].lowercased()) cupcakes is on its way!"
                self.showingAlert = true
            } else {
                print("invalid response from server")
            }
        }.resume() //<--without this, none of the above gets triggered. Remember this!
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(orders: Orders())
    }
}
