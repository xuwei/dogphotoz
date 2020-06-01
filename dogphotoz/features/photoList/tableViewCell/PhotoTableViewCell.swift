//
//  PhotoListTableViewCell.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import SDWebImage

/**
  Table cell to display dog photo
 */
class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var min: UILabel!
    @IBOutlet weak var max: UILabel! 
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var lifeSpan: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
