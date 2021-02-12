//
//  FieldValidationExample.swift
//  cupcakeCorner
//
//  Created by Travis Brigman on 2/11/21.
//  Copyright © 2021 Travis Brigman. All rights reserved.
//
/*
import SwiftUI

struct FieldValidationExample: View {
    @State var userName = ""
    @State var password = ""
    var disabledForm: Bool {
        return userName.count < 3 || password.count < 3
    }
    
    var body: some View {
        Form {
                Section {
                    TextField("Username", text: $userName)
                    TextField("Password", text: $password)
                }
                Section {
                    Button("Sign In"){
                        print("signing In")
                    }
                }
                .disabled(disabledForm)
            }
        }
    }


struct FieldValidationExample_Previews: PreviewProvider {
    static var previews: some View {
        FieldValidationExample()
    }
}
*/
