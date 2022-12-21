//
//  ActionCollectionViewCell.swift
//  manga
//
//  Created by Apple on 05/09/2021.
//

import UIKit

class ActionCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet weak var image_tich: UIImageView!
    @IBOutlet weak var ViewTich: UIView!
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var Image_Ans: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        ViewTich.backgroundColor = .clear
        image_tich.image = nil
    }

}
