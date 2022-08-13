//
//  CinemaViewController.swift
//  MediaSsok
//
//  Created by taekki on 2022/08/13.
//

import UIKit
import CoreLocation
import MapKit

final class CinemaViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    
    private lazy var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.delegate = self
        setRegionAndAnnotation()
    }
}

extension CinemaViewController {
    
    private func setRegionAndAnnotation(
        center: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: 37.517829, longitude: 126.886270),
        title: String = "청년취업사관학교 영등포 캠퍼스"
    )
    {
        setRegion(center: center)
        setAnnotation(center: center, title: title)
    }
    
    private func setRegion(center: CLLocationCoordinate2D) {
        let region = MKCoordinateRegion(center: center, latitudinalMeters: 1000, longitudinalMeters: 1000)
        mapView.setRegion(region, animated: true)
    }
    
    private func setAnnotation(center: CLLocationCoordinate2D, title: String) {
        let annotation = MKPointAnnotation()
        annotation.coordinate = center
        annotation.title = title
        mapView.addAnnotation(annotation)
    }
    
    private func checkUserDeviceLocationServiceAuthorization() {
        
        let authorizationStatus: CLAuthorizationStatus
        
        if #available(iOS 14.0, *) {
            authorizationStatus = locationManager.authorizationStatus
        } else {
            authorizationStatus = CLLocationManager.authorizationStatus()
        }

        if CLLocationManager.locationServicesEnabled() {
            checkUserCurrentLocationAuthorization(authorizationStatus)
        } else {
            print("위치 서비스가 꺼져 있어 위치 권한 요청을 하지 못합니다.")
        }
    }
    
    private func checkUserCurrentLocationAuthorization(_ authorizationStatus: CLAuthorizationStatus) {

        switch authorizationStatus {
        case .notDetermined:
            locationManager.desiredAccuracy = kCLLocationAccuracyBest
            locationManager.requestWhenInUseAuthorization()
            
        case .restricted, .denied:
            showRequestLocationServiceAlert()
            
        case .authorizedWhenInUse:
            locationManager.startUpdatingLocation()
            
        default:
            print("DEFAULT")
        }
    }
    
    private func showRequestLocationServiceAlert() {
        
      let requestLocationServiceAlert = UIAlertController(
        title: "위치정보 이용",
        message: "위치 서비스를 사용할 수 없습니다. 기기의 '설정 > 개인정보 보호'에서 위치 서비스를 켜주세요.",
        preferredStyle: .alert
      )
      let goSetting = UIAlertAction(title: "설정으로 이동", style: .destructive) { _ in
          if let appSetting = URL(string: UIApplication.openSettingsURLString) {
              UIApplication.shared.open(appSetting)
          }
      }
      let cancel = UIAlertAction(title: "취소", style: .default)
        
      requestLocationServiceAlert.addAction(cancel)
      requestLocationServiceAlert.addAction(goSetting)
      present(requestLocationServiceAlert, animated: true, completion: nil)
    }
}

extension CinemaViewController: CLLocationManagerDelegate {

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let coordinate = locations.last?.coordinate {
            setRegionAndAnnotation(center: coordinate, title: "현재 위치")
        }

        locationManager.stopUpdatingLocation()
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error.localizedDescription)
    }

    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        checkUserDeviceLocationServiceAuthorization()
    }
}
