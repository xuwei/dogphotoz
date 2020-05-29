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
    
    /// data update happens whenever we set a new viewModel
    var viewModel: PhotoTableCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            photo.sd_setImage(with: vm.imageUrl, placeholderImage: AppData.shared.placeholder)
            displayName.text = vm.display
            lifeSpan.text = vm.lifeSpan
            
            /// if lifeSpan is not available, we'll just hide min/max labels 
            if (vm.lifeSpan != AppData.shared.NA) {
                max.isHidden = false; min.isHidden = false
                min.text = String(vm.minSpan)
                max.text = String(vm.maxSpan)
            } else {
                max.isHidden = true; min.isHidden = true
            }
            // random filler bg color on imageview
            self.photo.backgroundColor = AppData.shared.colors.randomElement()
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
