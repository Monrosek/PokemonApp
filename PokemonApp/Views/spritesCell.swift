//
//  typesCell.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class spritesCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    var src:[String] = []
    var item:Item? {
        didSet {
            guard let item = item as? SpritesItem else {return}
            src.removeAll()
            item.sprites.forEach{src.append($0 ?? "")}
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(spriteViewCell.nib, forCellWithReuseIdentifier: spriteViewCell.identifier)
        
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

typealias SpriteCollectionCell = spritesCell
extension SpriteCollectionCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numTypes: \(src.count)")
        return src.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "spriteViewCell", for: indexPath) as? spriteViewCell {
        
           // cell.label.text = src[indexPath.row]
            cell.sprite.imageFrom(url: src[indexPath.row])
            return cell
        }
        print("Cell Data is missing")
        return UICollectionViewCell()
    }
    
    
    
    
    
}


