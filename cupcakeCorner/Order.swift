//
//  Order.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//

import Foundation

struct Order: Codable {
    static let types = ["vanilla", "strawberry", "chocolate", "rainbow"]
    
    var type = 0
    var quantity = 3
    
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
    
    var name = ""
    var streetAddress = ""
    var city = ""
    var zip = ""
    
    var hasValidAdress: Bool {
        if name.isEmpty || streetAddress.isEmpty || city.isEmpty || zip.isEmpty {
            return false
        }
        if name.first?.isWhitespace ?? name.isEmpty || streetAddress.first?.isWhitespace ?? streetAddress.isEmpty || city.first?.isWhitespace ?? city.isEmpty || zip.first?.isWhitespace ?? zip.isEmpty {
            return false
        }
        return true
    }
    
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

class Orders: ObservableObject {
    @Published var order = Order()
    

    

}










//-----------------------------------------------
/*
 enum CodingKeys: CodingKey {
     case type, quantity, extraFrosting, extraSprinkles, name, streetAddress, city, zip
 }
 
 
 
 
 
 
 
 init() {}
 
 required init(from decoder: Decoder) throws {
     let container = try decoder.container(keyedBy: CodingKeys.self)
     type = try container.decode(Int.self, forKey: .type)
     quantity = try container.decode(Int.self, forKey: .quantity)
     extraFrosting = try container.decode(Bool.self, forKey: .extraFrosting)
     extraSprinkles = try container.decode(Bool.self, forKey: .extraSprinkles)
     name = try container.decode(String.self, forKey: .name)
     streetAddress = try container.decode(String.self, forKey: .streetAddress)
     city = try container.decode(String.self, forKey: .city)
     zip = try container.decode(String.self, forKey: .zip)
 }
 
 func encode(to encoder: Encoder) throws {
     var container = encoder.container(keyedBy: CodingKeys.self)
     try container.encode(type, forKey: .type)
     try container.encode(quantity, forKey: .quantity)
     try container.encode(extraFrosting, forKey: .extraFrosting)
     try container.encode(extraSprinkles, forKey: .extraSprinkles)
     try container.encode(name, forKey: .name)
     try container.encode(streetAddress, forKey: .streetAddress)
     try container.encode(city, forKey: .city)
     try container.encode(zip, forKey: .zip)
 }
 */
