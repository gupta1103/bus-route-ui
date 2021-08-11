//
//  APIService.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class APIService: NSObject {
    
    func fetchRouteDetails(completion: @escaping (RouteDetail?) -> Void) {
        let urlString = "https://jsonkeeper.com/b/RM9W"
        let url = URL(string: urlString)
        let task = URLSession.shared.dataTask(with: url!) { data, urlResponse, error in
            if let data = data {
                do {
                    let result = try JSONDecoder().decode(RouteDetail.self, from: data)
                    DispatchQueue.main.async {
                        completion(result)
                    }
                }
                catch {
                    print("Error: \(error)")
                }
            }
        }
        task.resume()
    }
}
