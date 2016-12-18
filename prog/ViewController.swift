

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let urlString = "http://localhost:6000/session"
        let request = NSMutableURLRequest(url: URL(string: urlString)!)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        let params: [String: String] = [
            "seed": "hoge"
        ]
        
        try! request.httpBody = JSONSerialization.data(withJSONObject: params, options: JSONSerialization.WritingOptions.prettyPrinted)
        
        let task = URLSession.shared.dataTask(with: request as URLRequest, completionHandler: {data, response, error in
            if (error == nil) {
                guard let data = data else {
                    print("Data is empty")
                    return
                }
                _ = try! JSONSerialization.jsonObject(with: data, options: [])
                print("hoge")
                
                
            } else {
               
                print(error.debugDescription)
                
            }
            return
        })
        task.resume()

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}

