import Foundation
import CoreLocation
import MapKit
import SwiftUI

final class LocationViewModel: NSObject, ObservableObject {
    typealias Tuple = (title: String, description: String)
    @Published var userLocation = MKCoordinateRegion()
    @Published var userHasLocation = false
    @Published var defaultRegion = MKCoordinateRegion(center: .init(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude), span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    @Published private(set) var state = LoadingState<Tuple, Tuple>.idle
    override init() {
        super.init()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        locationManager.delegate = self
        userLocation = MKCoordinateRegion(center: .init(latitude: DefaultRegion.latitude, longitude: DefaultRegion.longitude), span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
    }
    
    func checkUserAuthorization() {
        let status = locationManager.authorizationStatus
        switch status {
        case .notDetermined, .restricted, .denied:
            userHasLocation = false
        case .authorizedAlways, .authorizedWhenInUse, .authorized:
            userHasLocation = true
        @unknown default:
            userHasLocation = false
        }
        state = .loaded((title, body))
    }
    
    private var title: String {
        return "Hola!\(userHasLocation ? "🔆" : "🦠")"
    }
    
    private var body: String {
        return "Pulsa para cambiar el estado de la autorización para localizarle, ahora el esatdo es \(userHasLocation ? "Aceptado" : "Denegado")"
    }
    
    private let locationManager = CLLocationManager()
}

extension LocationViewModel: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        guard let location = locations.last else { return }
        userLocation = .init(center: location.coordinate, span: .init(latitudeDelta: Span.delta, longitudeDelta: Span.delta))
        
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        state = .failed((title, body))
    }
    
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserAuthorization()
    }
}
