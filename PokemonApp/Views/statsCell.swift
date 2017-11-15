//
//  statsCell.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class statsCell: UITableViewCell {
    
    var item:Item? {
        didSet {
            guard let item = item as? StatsItem else {return}
            item.stats.forEach {
                let val = Int(Double($0.base_stat ?? 0)/maxStat * 10)
               // let val = (($0.base_stat ?? 0)/255)*10
             //   print("base_Stat: \(val)")
                switch $0.getStatType() {
                case .HP:
                    for i in 0..<10{
                        if (val) > i {
                          HPbars[i].backgroundColor = barColor
                        }
                        else {
                            HPbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .ATK:
                    for i in 0..<10{
                        if (val) > i {
                            ATKbars[i].backgroundColor = barColor
                        }
                        else {
                            ATKbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .DEF:
                    for i in 0..<10{
                        if (val) > i {
                            DEFbars[i].backgroundColor = barColor
                        }
                        else {
                            DEFbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .SATK:
                    for i in 0..<10{
                        if (val) > i {
                            SAbars[i].backgroundColor = barColor
                        }
                        else {
                            SAbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .SDEF:
                    for i in 0..<10{
                        if (val) > i {
                            SDEFbars[i].backgroundColor = barColor
                        }
                        else {
                            SDEFbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .SPD:
                    for i in 0..<10{
                        if (val) > i {
                            SDbars[i].backgroundColor = barColor
                        }
                        else {
                            SDbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .ACC:
                    for i in 0..<10{
                        if (val) > i {
                            ACCbars[i].backgroundColor = barColor
                        }
                        else {
                            ACCbars[i].backgroundColor = UIColor.white
                        }
                    }
                case .EVA:
                    for i in 0..<10{
                        if (val/10) > i {
                            EVAbars[i].backgroundColor = barColor
                        }
                        else {
                            EVAbars[i].backgroundColor = UIColor.white
                        }
                    }
                default: return
                }
            }
            
        }
    }


    @IBOutlet var HPbars: [UIView]!
    @IBOutlet var ATKbars: [UIView]!
    @IBOutlet var SAbars: [UIView]!
    @IBOutlet var SDbars: [UIView]!
    @IBOutlet var DEFbars: [UIView]!
    @IBOutlet var SDEFbars: [UIView]!
    @IBOutlet var ACCbars: [UIView]!
    @IBOutlet var EVAbars: [UIView]!
    
    var maxStat:Double = 255.0
    var barColor:UIColor = UIColor(red:43, green: 111, blue:182)
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
        super.setSelected(false, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
}

