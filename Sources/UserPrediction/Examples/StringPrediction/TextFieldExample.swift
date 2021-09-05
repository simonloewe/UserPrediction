//
//  SwiftUIView.swift
//  
//
//  Created by Simon Lion on 29.08.21.
//

import SwiftUI

struct SwiftUIView: View {
    
    @State var userTextInput = ""
    let mySearchable = ["String","Strin","Stri","Str","St","S","X"]
    
    var body: some View {
        TextField("Title", text: $userTextInput, onEditingChanged: { editing in
            UserPrediction.predictContinuous(input: $userTextInput, in: self.mySearchable, while: editing) { completion in
                print("Prediction: ", completion)
            }
        },
        onCommit: {
            UserPrediction.predict(input: self.userTextInput, in: self.mySearchable)
        }).padding()
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        SwiftUIView()
    }
}
