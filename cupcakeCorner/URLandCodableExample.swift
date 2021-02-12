//
//  URLandCodableExample.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//
/*
import SwiftUI

struct Response: Codable {
    var results: [Result]
}

struct Result: Codable {
    var trackId: Int
    var trackName: String
    var collectionName: String
}

struct URLandCodableExample: View {
        @State var results = [Result]()
    var body: some View {
        List(results, id: \.trackId) { item in
                VStack(alignment: .leading) {
                    Text(item.trackName)
                        .font(.headline)
                    Text(item.collectionName)
                }
            }
            .onAppear(perform: loadData)
        }
        func loadData()  {
            guard let url = URL(string:"https://itunes.apple.com/search?term=taylor+swift&entity=song") else {  print("invalid URL")
                return  }
            
            let request = URLRequest(url: url)
            
            URLSession.shared.dataTask(with: request) { data, response, error in
                if let data = data {
                    if let decodedResponse = try? JSONDecoder().decode(Response.self, from: data) {
                        DispatchQueue.main.async {
                            self.results = decodedResponse.results
                        }
                        
                        return
                    }
                }
                print("fetch failed: \(error?.localizedDescription ?? "unknown error")")
            }.resume()
            
        }
    }


struct URLandCodableExample_Previews: PreviewProvider {
    static var previews: some View {
        URLandCodableExample()
    }
 }
 */
