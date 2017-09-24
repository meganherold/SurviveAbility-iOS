import UIKit

class CaptainStore {
    var allCaptains = [Captain]()
    
    private let session: URLSession = {
        let config = URLSessionConfiguration.default
        return URLSession(configuration: config)
    }()
    
    init() {
        updateCaptains()
    }
    
    func updateCaptains() {
        let url = URL(string: "https://survive-ability.herokuapp.com/api/captains")
        let request = URLRequest(url: url!)
        let task = session.dataTask(with: request) {
            (data, response, error) -> Void in
            
            if let jsonData = data {
                do {
                    let response = try JSONSerialization.jsonObject(with: jsonData, options: []) as! [String:Any]
                    self.addCaptains(fromJSON: response)
                } catch let error {
                    print("Error creating JSON object: \(error)")
                }
            } else if let requestError = error {
                print("Error: \(requestError)")
            } else {
                print("Something is wildly wrong.")
            }
        }
        task.resume()
    }
    
    func addCaptains(fromJSON json: [String: Any]) {
        guard
            let jsonDictionary = json as? [AnyHashable: Any],
            let captains = jsonDictionary["captains"] as? [[String: Any]] else {
                return
        }
        
        for captainJson in captains {
            if let captain = captain(fromJSON: captainJson) {
                allCaptains.append(captain)
            }
        }
    }
    
    func captain(fromJSON json: [String: Any]) -> Captain? {
        guard
            let name = json["name"] as? String else {
                return nil
        }
        return Captain(name: name, photo: nil)
    }
}
