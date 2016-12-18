import WatchKit
import Foundation


class InterfaceController: WKInterfaceController {
    @IBOutlet var inputText: WKInterfaceLabel!

    @IBOutlet var outputText: WKInterfaceLabel!
    
    private func requestURL(urlString: String, method: String, params:[String:String], callback: @escaping ([String:Any]) -> Void ) {
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.httpMethod = method
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        try! request.httpBody = JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if (error == nil) {
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                let json = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                callback(json )
            } else {
                print(error.debugDescription)
                
            }
            return
        })
        task.resume()
    }
    
    @IBAction func inputSound() {
        presentTextInputController(withSuggestions: [], allowedInputMode: .plain, completion: {(str: [Any]?) -> Void in
            str?.map { (s: Any) -> Void in
                let text = s as! String
                self.inputText.setText(text)
                
//                let urlString = "http://wp.ymizushi.info/session"
//                let method = "POST"
//                let params: [String: String] = [
//                    "seed": "hoge"
//                ]c
//
//                self.requestURL(urlString: urlString, method: method, params: params) {
//                    var sessionID: NSNumber = 0
//                    let data = $0["data"] as! [String:Any]
//                    sessionID = data["session_id"] as! NSNumber
//                    
//
//                }
                
                let evalParams: [String: String] = [
                    "input": text
                ]
                let evalURLString = "http://wp.ymizushi.info/session/10/eval"
                print(evalURLString)
                self.requestURL(urlString: evalURLString, method: "POST", params: evalParams) {
                    let data = $0["data"] as! [String:Any]
                    let output = data["output"] as! String
                    print(output)
                    self.outputText.setText(output)
                }
                
                
                
                
                
//                try! request.httpBody = JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
//                
//                let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
//                    if (error == nil) {
//                        guard let data = data else {
//                            print("Data is empty")
//                            return
//                        }
//                        let json = try! JSONSerialization.jsonObject(with: data, options: []) as! Dictionary<String, String>
//                        
//                        self.inputText.setText("hoge")
//                        print(json)
//                
//                    } else {
//                        self.inputText.setText(error.debugDescription)
//                        print(error.debugDescription)
//                    
//                    }
//                    return
//                })
//                task.resume()
//                
                
            }
            return
        })

    }
    override func awake(withContext context: Any?) {
        super.awake(withContext: context)
        
        // Configure interface objects here.
    }
    
    override func willActivate() {
        // This method is called when watch view controller is about to be visible to user
        super.willActivate()
    }
    
    override func didDeactivate() {
        // This method is called when watch view controller is no longer visible
        super.didDeactivate()
    }

}
