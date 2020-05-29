//
//  PhotoListTableViewCell.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import SDWebImage

class PhotoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var displayName: UILabel!
    @IBOutlet weak var lifeSpan: UILabel!
    var viewModel: PhotoTableCellViewModel? {
        didSet {
            guard let vm = viewModel else { return }
            photo.sd_setImage(with: vm.imageUrl, placeholderImage: AppData.shared.placeholder)
            displayName.text = vm.display
            lifeSpan.text = vm.lifeSpan
        }
    }

    override func awakeFromNib() {
        super.awakeFromNib()
    }
}
