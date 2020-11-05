//
//  ContentView.swift
//  DogApp_SwiftUI
//
//  Created by Belal medhat on 11/4/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import SwiftUI
struct ContentView: View {
    @ObservedObject var NetworkManager = Network()
    // +++++ identify Network Manager as observed Object to update related value used when any change happen to published properties in network manager +++++
    
    var body: some View {
        
        ZStack{
            VStack{
                Text("SWIFTUI DOGS").foregroundColor(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))).font(.system(size: 30))
                ImageDog(UIDogImage:self.NetworkManager.Dog ?? UIImage(systemName: "photo.fill")!)
            

            Button(action: {
              
                self.NetworkManager.ApiCaller()

                
            }) {
                Text("GET DOG").font(.system(size: 20)).foregroundColor(Color(#colorLiteral(red: 0.9527974725, green: 0.9658686519, blue: 0.9782720208, alpha: 1))).padding()
                }.background(Color(#colorLiteral(red: 0.1411764771, green: 0.3960784376, blue: 0.5647059083, alpha: 1))).cornerRadius(20)
            }
                
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

struct ImageDog: View {
    var UIDogImage:UIImage
    var body: some View {
        Image(uiImage:UIDogImage).resizable().scaledToFill().frame(width: 300, height: 300, alignment: .center).clipShape(Circle()).shadow(radius: 5).overlay(Circle().stroke(Color(#colorLiteral(red: 0.5272222161, green: 0.6115953326, blue: 0.6786056161, alpha: 1)), lineWidth: 5))
        
    }
}
