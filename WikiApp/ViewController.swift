//
//  ViewController.swift
//  WikiApp
//
//  Created by Sachin Nautiyal on 7/23/18.
//  Copyright © 2018 Sachin Nautiyal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let networkHandler = NetworkHandler()
        networkHandler.getWikiData { (wiki) in
            if let wiki = wiki {
                print(wiki)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

