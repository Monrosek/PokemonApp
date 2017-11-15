//
//  listCell.swift
//  PokemonApp
//
//  Created by Mac on 11/15/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class listCell: UITableViewCell {

    var item: Item? {
        didSet {
            guard let item = item as? LabelItem else {
                return
            }
            label.text = item.resource.name
        }
    }
    
    @IBOutlet var label: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(false, animated: false)
    }
    
}
