//
//  WikiResultTableViewCell.swift
//  WikiApp
//
//  Created by Sachin Nautiyal on 7/24/18.
//  Copyright © 2018 Sachin Nautiyal. All rights reserved.
//

import UIKit

class WikiResultTableViewCell: UITableViewCell {

    @IBOutlet weak var imageViewOutlet: UIImageView!
    @IBOutlet weak var titleLabelOutlet: UILabel!
    @IBOutlet weak var subtitleLabelOutlet: UILabel!
    
    var pageResult : Result? {
        didSet {
            if let result = pageResult {
//                imageViewOutlet.image
                titleLabelOutlet.text = result.title
                if let description = result.terms?.description {
                    if description.count>0 {
                        subtitleLabelOutlet.text = description[0]
                    }
                }
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}
