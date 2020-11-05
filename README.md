# SwiftUI_Dogs_Example
In this example it show how to use SwiftUI With Simple API call using URL Session

Note :: i Know ths is easy project and can't be compared to real world tasks but it's just the start of learning SwiftUI
## API
I used online API that retreive dogs image every time i call it : https://dog.ceo/dog-api/ then by using codable decode JSON response and change url to image and update image 
 
### Response

```
{
    "message": "https://images.dog.ceo/breeds/ovcharka-caucasian/IMG_20191107_192837.jpg",
    "status": "success"
}

```

## Network Class

```
import UIKit
class Network:ObservableObject {
    // ++++++ confirm to Observable to observe any change in the class published data ++++++
    
    @Published var Dog:UIImage? // publish changes happen to Dog
    //  This Api return random dog images every time you request it
    // https://dog.ceo/api/breeds/image/random
    
    
     // MARK: Network Caller
    func ApiCaller(){ // used URLSession for Network requesting and Codable For parsing JSON
        
    // I Know That it isn't the best practice to use static for calling network call but i use it to try the SwiftUI and how to handle data in views
    
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

```

## contentView
```
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

```

### Gif

![](https://media.giphy.com/media/8Q6gdIk51m2apmWBqB/giphy.gif)
