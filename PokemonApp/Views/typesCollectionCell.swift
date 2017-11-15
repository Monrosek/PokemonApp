//
//  typeCollectionCell.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class typesCollectionCell: UICollectionViewCell {
    
    var type:String? {
        didSet {
            guard let str = type else {return}
            switch str {
            case "grass": label.backgroundColor = UIColor(0x7AC74C)
            case "ground": label.backgroundColor = UIColor(0xE2BF65)
            case "bug": label.backgroundColor = UIColor(0xA6B91A)
            case "dark": label.backgroundColor = UIColor(0x705746)
            case "dragon": label.backgroundColor = UIColor(0x6F35FC)
            case "water": label.backgroundColor = UIColor(0x6390F0)
            case "electric": label.backgroundColor = UIColor(0xF7D02C)
            case "fire": label.backgroundColor = UIColor(0xEE8130)
            case "fighting": label.backgroundColor = UIColor(0xC22E28)
            case "flying": label.backgroundColor = UIColor(0xA98FF3)
            case "ghost": label.backgroundColor = UIColor(0x735797)
            case "ice": label.backgroundColor = UIColor(0x96D9D6)
            case "fairy": label.backgroundColor = UIColor(0xD685AD)
            case "normal": label.backgroundColor = UIColor(0xA8A77A)
            case "rock": label.backgroundColor = UIColor(0xB6A136)
            case "steel": label.backgroundColor = UIColor(0xB7B7CE)
            case "psychic": label.backgroundColor = UIColor(0xF95587)
            case "poison": label.backgroundColor = UIColor(0xA33EA1)
            case "unknown": label.backgroundColor = UIColor.black
            default: return
            }
        }
    }
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        label.layer.cornerRadius = 5
        label.clipsToBounds = true
        label.contentMode = .scaleAspectFit
        //print("hey")
    }
    
    private func RGB(_ r:CGFloat,_ b: CGFloat,_ g:CGFloat)->UIColor {
        return UIColor(red: (r/255), green: (b/255), blue: (g/255), alpha: 1.0)
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
}

