//
//  typesCell.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class typesCell: UITableViewCell {
    
    @IBOutlet var collectionView: UICollectionView!
    var src:[String] = []
    var item:Item? {
        didSet {
            guard let item = item as? TypesItem else {return}
           // src.removeAll()
            item.types.forEach{src.append($0.type?.name ?? "")}
          //  collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.collectionView.register(typesCollectionCell.nib, forCellWithReuseIdentifier: typesCollectionCell.identifier)
        
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

typealias CollectionViewCell = typesCell
extension CollectionViewCell: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        print("numTypes: \(src.count)")
        return src.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "typesCollectionCell", for: indexPath) as? typesCollectionCell {
            cell.label.text = src[indexPath.row]
            cell.type = src[indexPath.row]
            return cell
        }
        print("Cell Data is missing")
        return UICollectionViewCell()
    }
    
    
    
    
    
}

