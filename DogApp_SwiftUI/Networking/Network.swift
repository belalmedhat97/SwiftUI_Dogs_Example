//
//  Network.swift
//  DogApp_SwiftUI
//
//  Created by Belal medhat on 11/4/20.
//  Copyright © 2020 Belal medhat. All rights reserved.
//

import UIKit
class Network:ObservableObject {
    // ++++++ confirm to Observable to observe any change in the class published data ++++++
    
    @Published var Dog:UIImage? // publish changes happen to Dog
    //  This Api return random dog images every time you request it
    // https://dog.ceo/api/breeds/image/random
    
    
     // MARK: Network Caller
    func ApiCaller(){ // used URLSession for Network requesting and Codable For parsing JSON
            
        // 1 :: create URL
        if let DogURL = URL(string: "https://dog.ceo/api/breeds/image/random") {
        
        // 2 :: create URLSession
            let session = URLSession(configuration: .default)
        
        // 3 :: give Sesion Task
            let Dogtask = session.dataTask(with: DogURL) { (data, response, error) in
                if error == nil {
                    if let DogData = data {
                    do {
                        let DogResponseResult = try JSONDecoder().decode(DogResponse.self, from: DogData)
                        print(DogResponseResult.message!)
                        if let data = try? Data(contentsOf: URL(string: DogResponseResult.message!)!){
                            DispatchQueue.main.async {
                                self.Dog = UIImage(data: data)
                            }
                        }
                        
                    }catch{
                        print(error)
                    }
                    }
            }
            }
        
        // 4 :: Start Session Task
            Dogtask.resume() // Send the request here
        }
        
    }
  
}
