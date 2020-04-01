//
//  CollectionViewCell.swift
//  Test
//
//  Created by Dipanjan Pal on 31/03/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tfWord: UITextField!
    @IBOutlet weak var lblWords: UILabel!
//    @IBOutlet var maxWidthConstraint: NSLayoutConstraint!{
//        didSet {
//            maxWidthConstraint.isActive = false
//        }
//    }
//    
//    var maxWidth: CGFloat? = nil {
//        didSet {
//            guard let maxWidth = maxWidth else {
//                return
//            }
//            maxWidthConstraint.isActive = true
//            maxWidthConstraint.constant = maxWidth
//        }
//    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }

}


