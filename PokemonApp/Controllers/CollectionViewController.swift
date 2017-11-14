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
    
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.getFavorites()
        
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
    

    private func saveToCoreData(poke:pokeFav){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "PokemonEntity", in: managedContext) else {return}
        let data = NSManagedObject(entity: entity, insertInto: managedContext)

        data.setValue(poke.name, forKey: "name")
        data.setValue(poke.url, forKey: "url")
        data.setValue(poke.id, forKey: "id")


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
    
    @IBAction func Change(_ sender: Any) {
        if let seg = sender as? UISegmentedControl {
            collectionView.reloadData()
        }
    }
    

    @IBAction func unwindToPokeList(sender: UIStoryboardSegue) {
        if let SVC = sender.source as? PokeViewController {
            guard let resour = SVC.resource else {return}
            guard let poke = SVC.poke else {return}
            saveToCoreData(poke: pokeFav(name:resour.name, url:resour.url, id: poke.id ?? 0))
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
        if segment.selectedSegmentIndex == 0 {
            return favorites.count
        }
            else {
            return resources.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segment.selectedSegmentIndex == 0 {
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let data = favorites[indexPath.row]
            guard let name = data.value(forKeyPath: "name") as? String else {return cell}
            cell.label?.text = "\(name)"
            guard let img = data.value(forKey: "id") as? Int else {return cell}
            cell.sprite.image = UIImage(named: "temp")
            cell.sprite.imageFrom(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/\(img).png")

            return cell
            }
        }
        else {
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
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        if( segment.selectedSegmentIndex == 1) {
        index = indexPath.row
        print("Performing Segue")
        self.performSegue(withIdentifier: "showDetail", sender: self)
        // print("unit Print: " + units[unitIndex].name)
        }
    }
    
}









