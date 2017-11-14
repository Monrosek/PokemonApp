//
//  imageCell.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class imageCell: UITableViewCell {
    
    @IBOutlet var sprite:UIImageView!
    @IBOutlet var label: UILabel!
    @IBOutlet var viewFrame: UIView!
    var item:Item? {
        didSet {
             guard let item = item as? ImageItem else {return}
              label.text = item.sectionTitle   
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        sprite?.layer.cornerRadius = 5
        sprite?.clipsToBounds = true
        sprite?.contentMode = .scaleAspectFit
       // sprite?.backgroundColor = UIColor.darkGray
        viewFrame.layer.cornerRadius = 5

    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
        
        // Configure the view for the selected state
    }
    
}


