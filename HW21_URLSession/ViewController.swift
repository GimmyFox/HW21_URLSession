//
//  ViewController.swift
//  HW21_URLSession
//
//  Created by Maksim Guzeev on 30.05.2022.
//

import UIKit

class ViewController: UIViewController {

    private let endpointClient = EndpointClient(applicationSettings: ApplicationSettingsService())

    override func viewDidLoad() {
        super.viewDidLoad()
        
        executeCall()
    }
    
    func executeCall() {
        let endpoint = GetNameEndpoint()
        let completion: EndpointClient.ObjectEndpointCompletion<String> = { result, response in
            guard let responseUnwrapped = response else { return }

            print("\n\n response = \(responseUnwrapped.allHeaderFields) ;\n \(responseUnwrapped.statusCode) \n")
            switch result {
            case .success(let team):
                print("team = \(team)")
                
            case .failure(let error):
                print(error)
            }
        }
        
        endpointClient.executeRequest(endpoint, completion: completion)
    }


}

final class GetNameEndpoint: ObjectResponseEndpoint<String> {
    
    override var method: RESTClient.RequestType { return .get }
    override var path: String { "/v1/public/characters" }
//    override var queryItems: [URLQueryItem(name: "id", value: "1")]?
    
    override init() {
        super.init()

        queryItems = [URLQueryItem(name: "name", value: "Iron-Man"),
                      URLQueryItem(name: "ts", value: "1"),
                      URLQueryItem(name: "apikey", value: "d9b6f53924f20c519c1e0fba7a3bb50c"),
                      URLQueryItem(name: "hash", value: "81e1317a245192e18375ee2f0737c731")]
    }
    
}











func decodeJSONOld() {
    let str = """
        {\"team\": [\"ios\", \"android\", \"backend\"]}
    """
    
    let data = Data(str.utf8)

    do {
        if let json = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
            if let names = json["team"] as? [String] {
                print(names)
            }
        }
    } catch let error as NSError {
        print("Failed to load: \(error.localizedDescription)")
    }
}

