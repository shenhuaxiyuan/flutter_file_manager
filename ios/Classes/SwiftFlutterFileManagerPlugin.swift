import Flutter
import UIKit

public class SwiftFlutterFileManagerPlugin: NSObject, FlutterPlugin {
   static var  myController:UIViewController? = nil
    
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "flutter_file_manager", binaryMessenger: registrar.messenger())
    let instance = SwiftFlutterFileManagerPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
    
    let appDelegate = UIApplication.shared.delegate as! FlutterAppDelegate
    myController = appDelegate.window.rootViewController
    
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    if(call.method=="openFile"){
        let dic = call.arguments as! Dictionary<String, String>
        let path = dic["path"]
        let canOpen = openFile(path: path!)
        result(canOpen)
    }
    result("iOS " + UIDevice.current.systemVersion)
  }
    
    
    
    
    func openFile(path:String) ->Bool{
        let url = NSURL.fileURL(withPath: path)
        let controller = UIDocumentInteractionController(url: url)
        controller.presentOpenInMenu(from: CGRect.zero, in: SwiftFlutterFileManagerPlugin.myController!.view, animated: true)
        return true
    }
}
