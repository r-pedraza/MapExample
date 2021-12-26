import MapKit
import SwiftUI

struct MapView: View {
   @StateObject var locationViewModel = LocationViewModel()
    
    var body: some View {
        switch locationViewModel.state {
        case .loaded(let tuple), .failed(let tuple):
            VStack {
                Map(coordinateRegion: $locationViewModel.userLocation, showsUserLocation: true)
                VStack{
                    Text(tuple.title)
                    Link(tuple.description, destination: Utils.authorizationsURL)
                }
                .padding(32)
            }
            .ignoresSafeArea()
        default:
            Text("Loading")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        MapView()
    }
}

