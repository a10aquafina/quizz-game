//
//  PlayCollectionViewCell.swift
//  manga
//
//  Created by Apple on 01/09/2021.
//

import UIKit

class PlayCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var View_Lock: UIView!
    @IBOutlet weak var Image_Lock: UIImageView!
    @IBOutlet weak var number_of_complete: UILabel!
    @IBOutlet weak var lock_Label: UILabel!
    @IBOutlet weak var Type_Label: UILabel!
    @IBOutlet weak var ViewLabel: UIView!
    @IBOutlet weak var ViewTong: UIView!
    @IBOutlet weak var Level_Label: UILabel!
    @IBOutlet weak var Image_Play: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        
        View_Lock.layer.cornerRadius = 20
        View_Lock.layer.masksToBounds = true
        Image_Play.layer.cornerRadius = 20
        Image_Play.layer.masksToBounds = true
    }

}
