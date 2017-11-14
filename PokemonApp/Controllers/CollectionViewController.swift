//
//  PokeViewController.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit
import CoreData

class CollectionViewController: UIViewController {
    
    var index = Int()
    var resourceType = ResourceType.pokemon
    var resources:[namedResource] = []
    var favorites:[NSManagedObject] = []
    
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NetworkService.getResourceList(ofType: resourceType) { (rsrcList, error) in
            guard error == nil else {return}
            guard let rsrcList = rsrcList else {return}
            DispatchQueue.main.sync {
                rsrcList.results?.forEach{self.resources.append($0)}
                self.collectionView.reloadData()
            }
        }
        self.collectionView.register(PokeCell.nib, forCellWithReuseIdentifier: PokeCell.identifier)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    private func saveToCoreData(poke:namedResource){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: managedContext) else {return}
        let data = NSManagedObject(entity: entity, insertInto: managedContext)

        data.setValue(poke.name, forKey: "name")
        data.setValue(poke.url, forKey: "url")

        do {
            try managedContext.save()
            favorites.append(data)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getFavorites(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName:"PokemonEntity")
        
        do {
            favorites = try managedContext.fetch(request)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let NC = segue.destination as? UINavigationController {
            guard let VC = NC.viewControllers.first as? PokeViewController else {return}
            VC.resource = resources[index]
        }
    }
    


    @IBAction func unwindToPokeList(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.source as? PokeViewController {
            if let rsrc = sourceViewController.resource {
            saveToCoreData(poke: rsrc)
            }
        }
    }
    
}

typealias PokeCollection = CollectionViewController
extension PokeCollection: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      //  print("#OfPokemonLoaded: \(resources.count)")
        return resources.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        switch resourceType {
        case .pokemon:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
                cell.sprite.image = UIImage(named: "temp")
                cell.sprite.imageFrom(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(indexPath.row+API.offset+1).png")
                // cell.pokeFrom(url: "https://pokeapi.co/api/v2/pokemon/\(indexPath.row+1)/")
                //  cell.pokeFrom(url: resources[indexPath.row].url)
                cell.label.text = resources[indexPath.row].name
                return cell
            }
        case .types:
            if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
                
                
                return cell
            }
        default:
            return UICollectionViewCell()
            
        }
        
        // Configure the cell
        
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        index = indexPath.row
        print("Performing Segue")
        self.performSegue(withIdentifier: "showDetail", sender: self)
        // print("unit Print: " + units[unitIndex].name)
    }
    
}









