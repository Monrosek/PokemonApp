//
//  PokeCell.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import CoreData

class PokeCell: UICollectionViewCell {
    
    var poke:Pokemon?
    
    @IBOutlet var label: UILabel!
    @IBOutlet var sprite: UIImageView!
    @IBOutlet var viewFrame: UIView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        sprite?.layer.cornerRadius = 5
        sprite?.clipsToBounds = true
        sprite?.contentMode = .scaleAspectFit
        sprite?.backgroundColor = UIColor(red:242,green:242,blue:242)
        viewFrame.layer.cornerRadius = 5
    }
    
    static var identifier: String {
        return String(describing: self)
    }
    
    static var nib:UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
    
    
//    private func saveToCoreData(pokemon:namedResource){
//        let appDelegate = UIApplication.shared.delegate as! AppDelegate
//        let managedContext = appDelegate.persistentContainer.viewContext
//        guard let entity = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: managedContext) else {return}
//        let poke = NSManagedObject(entity: entity, insertInto: managedContext)
//        
//        poke.setValue(pokemon.name, forKey: "name")
//        poke.setValue(pokemon.url, forKey: "url")
////
////        do {
//            try managedContext.save()
//            pokemon.append(guy)
//            tableView.reloadData()
//        } catch let error {
//            print(error.localizedDescription)
//        }
        
    }
    
    











