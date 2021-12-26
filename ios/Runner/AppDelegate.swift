import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {


    let controller : FlutterViewController = window?.rootViewController as! FlutterViewController
    let nativeChannel = FlutterMethodChannel(name: "com.flutter.dev/calc" , binaryMessenger: controller.binaryMessenger)
    let encryptoChannel = FlutterMethodChannel(name: "com.flutter.dev/encrypto" , binaryMessenger: controller.binaryMessenger)

          nativeChannel.setMethodCallHandler({
              (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
              nativeChannel.setMethodCallHandler({
                  [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in
                  guard call.method == "add" else {
                      result(FlutterMethodNotImplemented)
                      return
                  }

                  if(call.method == "add"){
                      let array : Array = call.arguments as! Array<Int>
                      let sum = array[0] + array[1]
                      self?.sendNativeCalc(result: result , calcResult: sum)
                  }
              })
          })

          encryptoChannel.setMethodCallHandler({
                        (call: FlutterMethodCall, result: @escaping FlutterResult) -> Void in
                        encryptoChannel.setMethodCallHandler({
                            [weak self] (call: FlutterMethodCall, result: FlutterResult) -> Void in

                            guard call.method == "getEncrypto" || call.method == "getDecode"  else {
                                result(FlutterMethodNotImplemented)
                                return
                            }

                            if(call.method == "getEncrypto"){
                                let callString : String = call.arguments as! String
                                let returnString = callString.data(using: .utf8)!.base64EncodedString()

                                self?.sendEncrypto(result: result , calcResult: returnString)
                            }

                            if(call.method == "getDecode"){
                                let callString : String = call.arguments as! String
                                let decodedData = Data(base64Encoded: callString)!

                                let base64DecString = String(data: decodedData, encoding: .utf8)!

                                self?.sendEncrypto(result: result , calcResult: base64DecString)
                            }
                        })
                    })


    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }


    private func sendNativeCalc(result: FlutterResult , calcResult : Int) {
       result(calcResult)
    }

    private func sendEncrypto(result: FlutterResult , calcResult : String) {
           result(calcResult)
    }

}
