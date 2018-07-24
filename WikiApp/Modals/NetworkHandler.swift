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
    
    typealias wikiMediaCompletionHandler = (Wiki?) -> Void
    
    var cacheObj = WikiCache.shared
    
    struct Constants {
        static let apiURL1 = "https://en.wikipedia.org//w/api.php?action=query&format=json&prop=pageimages%7Cpageterms&generator=prefixsearch&redirects=1&formatversion=2&piprop=thumbnail&pithumbsize=50&pilimit=10&wbptterms=description&gpssearch="
        static let apiUrl2 = "&gpslimit=10"
    }
    
    func getWikiData(fromKey key: String, withCompletionBlock : @escaping wikiMediaCompletionHandler) {
        if key.count>3 {
            let text = key.replacingOccurrences(of: " ", with: "+")
            let request = Constants.apiURL1 + text + Constants.apiUrl2
            if let cacheData = cacheObj.getData(forKey: key) {
                do {
                    let wikiData = try JSONDecoder().decode(Wiki.self, from: cacheData)
                    withCompletionBlock(wikiData)
                } catch let error {
                    print("error on Serializing object", error)
                    withCompletionBlock(nil)
                }
            } else {
                guard let url = URL(string : request) else { return }
                let request = URLRequest(url : url)
                let session = URLSession.shared
                let task = session.dataTask(with: request) { (data, urlResponse, error) in
                    guard let data = data else { return }
                    do {
                        let wikiData = try JSONDecoder().decode(Wiki.self, from: data)
                        self.cacheObj.update(data, forKey: key)
                        withCompletionBlock(wikiData)
                    } catch let error {
                        print("error on Serializing object", error)
                        withCompletionBlock(nil)
                    }
                }
                task.resume()
            }
        } else {
            return
        }
    }
}
