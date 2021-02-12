//
//  Order.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation

/*
 There are two data types in this file. A struct title Order and a class titled Orders. The class acts as a wrapper around the Order struct. By seperating the two, we get the benefit of the Codable protocol in the struct, without having to create conformity by hand if we were to store data in the class. The class gives us the benefit of conforming to ObservableObject so that the instance can be created once and passed to the 3 different views in the app.
 */

struct Order: Codable {
    //array that type picker gets data from
    static let types = ["vanilla", "strawberry", "chocolate", "rainbow"]
    
    //selection of the cupcake type and the quantity desired
    var type = 0
    var quantity = 3
    
    //computed property that is attached to a slider button, if the slider is set to false, it sets other values associated to the order to false as well to make things clean and easy
    var specialRequestEnabled = false {
        didSet {
           if specialRequestEnabled == false {
                extraFrosting = false
                extraSprinkles = false
            }
        }
    }
    var extraFrosting = false
    var extraSprinkles = false
    
    //values for the AddressView
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    //Computed property that checks if the AddressView fields are empt or if that have whitespace. If they do, the submit button is disabled.
    var hasValidAdress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.first?.isWhitespace ?? name.isEmpty || streetAddress.first?.isWhitespace ?? streetAddress.isEmpty || city.first?.isWhitespace ?? city.isEmpty || zip.first?.isWhitespace ?? zip.isEmpty {
            return false
        }
        return true
    }
    
    // a quick cost calculator based on quantity, extra toppings, and type.
    var cost: Double {
        var cost = Double(quantity) * 2
        cost += Double(type) / 2
        
        if extraFrosting {
            cost += Double(quantity)
        }
        
        if extraSprinkles {
            cost += Double(quantity) / 2
        }
        return cost
    }
}


// this class conforms to observableObject and used @published property wrapper to enable us to pass the struct around to all the views.
class Orders: ObservableObject {
    @Published var order = Order()
    
}
