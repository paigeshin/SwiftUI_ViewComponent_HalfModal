//
//  ContentView.swift
//  HalfModalSheet
//
//  Created by paige on 2021/11/07.
//

import SwiftUI

struct ContentView: View {
    
    @State var showSheet: Bool = false
    
    var body: some View {
        Button {
            print("button clicked")
            showSheet.toggle()
        } label: {
            Text("Present Sheet")
        }
        .navigationTitle("Half Modal Sheet")
        .halfSheet(present: $showSheet, onDimsiss: {
            print("Dismissed")
        }) {
            // Custom Page
            ZStack {
                Color.red
                
                VStack {
                 
                    Text("Hello Paige")
                        .font(.title)
                        .bold()
                    
                    Button {
                        showSheet.toggle()
                    } label: {
                        Text("Close From Sheet")
                            .foregroundColor(.white)
                    }
                    .padding()
                }
                
            }
            .ignoresSafeArea()
        }
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}



