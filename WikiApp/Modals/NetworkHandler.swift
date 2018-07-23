//
//  NetworkHandler.swift
//  WikiApp
//
//  Created by Sachin Nautiyal on 7/24/18.
//  Copyright © 2018 Sachin Nautiyal. All rights reserved.
//

import Foundation
import UIKit

class NetworkHandler {
    
    typealias mediaWikiCompletionHandler = (Wiki?) -> Void
    
    struct Constants {
        static let apiURL = "https://en.wikipedia.org/w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&titles=Albert%20Einstein&formatversion=2"
        static let getJSONResponse = ".json"
    }
    
    func getWikiData(withCompletionBlock : @escaping mediaWikiCompletionHandler) {
        guard let url = URL(string : Constants.apiURL) else { return }
        let request = URLRequest(url : url)
        let session = URLSession.shared
        let task = session.dataTask(with: request) { (data, urlResponse, error) in
            guard let data = data else { return }
            do {
                let wikiData = try JSONDecoder().decode(Wiki.self, from: data)
                withCompletionBlock(wikiData)
            } catch let error {
                print("error on Serializing object", error)
                withCompletionBlock(nil)
            }
        }
        task.resume()
    }
}
