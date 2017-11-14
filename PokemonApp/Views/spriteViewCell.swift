//
//  spriteViewCell.swift
//  PokemonApp
//
//  Created by Mac on 11/14/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class spriteViewCell: UICollectionViewCell {

    @IBOutlet var sprite: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sprite?.layer.cornerRadius = 50
        sprite?.clipsToBounds = true
        sprite?.contentMode = .scaleAspectFit
         //sprite?.backgroundColor = UIColor.
    }

    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
