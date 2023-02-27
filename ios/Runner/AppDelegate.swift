import UIKit
import Flutter
import GoogleMaps 
@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    GeneratedPluginRegistrant.register(with: self)

    GMSServices.provideAPIKey("AIzaSyCHcAKXFZuQ8WhkAvW1zv3MTVibHU9EuF0")
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
