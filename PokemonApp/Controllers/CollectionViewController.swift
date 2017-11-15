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
    var user:NSManagedObject?
    
    @IBOutlet var segment: UISegmentedControl!
    @IBOutlet var collectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        loadUser()
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
    
    
    private func loadUser() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSManagedObject>(entityName:"UserAccount")
        guard let uid = LoginInfo.shared.user?.uid else {return}
        print("User UID: \(uid)")
        request.predicate = NSPredicate(format: "uid == %@", uid)
        
        do {
                let users = try managedContext.fetch(request)
                if users.count > 0{
                     user = users.first
                }
                else
                {
                    guard let entity = NSEntityDescription.entity(forEntityName: "UserAccount", in: managedContext) else {return}
                    let data = NSManagedObject(entity: entity, insertInto: managedContext)
                    data.setValue(uid, forKey: "uid")
                    
                    do {
                        try managedContext.save()
                        user = data
                        collectionView.reloadData()
                    } catch let error {
                        print(error.localizedDescription)
                }
                    
                }
            } catch let error {
            print(error.localizedDescription)
         }
    }

    private func saveToCoreData(poke:namedResource){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        guard let entity = NSEntityDescription.entity(forEntityName: "PokeResource", in: managedContext) else {return}
        let data = NSManagedObject(entity: entity, insertInto: managedContext)

        data.setValue(poke.name, forKey: "name")
        data.setValue(poke.url, forKey: "url")
        user?.setValue(data, forKey: "favorite")

        do {
            try managedContext.save()
            favorites.append(data)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func deleteFromCoreData(index:Int) {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        managedContext.delete(favorites[index])
        favorites.remove(at: index)
        collectionView.reloadData()
    }
    
    private func getFavorites(){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
    
        let request = NSFetchRequest<NSManagedObject>(entityName:"PokeResource")
        guard let uid = LoginInfo.shared.user?.uid else {return}
        request.predicate = NSPredicate(format: "ANY user.uid == %@", uid)
        
        do {
            favorites = try managedContext.fetch(request)
            collectionView.reloadData()
        } catch let error {
            print(error.localizedDescription)
        }
    }
    
    private func getFavoriteResource(_ index:Int) ->namedResource? {
        let data = favorites[index]
        guard let name = data.value(forKeyPath: "name") as? String else {return nil}
        guard let url = data.value(forKeyPath: "url") as? String else {return nil}
        return namedResource(name,url)
    }

    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
        if let NC = segue.destination as? UINavigationController {
            guard let VC = NC.viewControllers.first as? PokeViewController else {return}
            if(segment.selectedSegmentIndex == 1) {
                VC.addFav.setTitle("Remove from Favorites", for: .normal)
                VC.resource = getFavoriteResource(index)
              }
            else {
                VC.addFav.setTitle("Add to Favorites", for: .normal)
                VC.resource = resources[index]
            }
        }
    }
    
    @IBAction func Change(_ sender: Any) {
        if sender is UISegmentedControl {
            collectionView.reloadData()
        }
    }
    
    @IBAction func unwindToPokeList(sender: UIStoryboardSegue) {
        print("Unwinding Segue w/ index: \(index)")
        if sender.source is PokeViewController {
            if segment.selectedSegmentIndex == 0 {
                saveToCoreData(poke: resources[index])
            }
            else {
                deleteFromCoreData(index: index)
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
        if segment.selectedSegmentIndex == 1 {
            return favorites.count
        }
            else {
            return resources.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        if segment.selectedSegmentIndex == 1 {
           if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PokeCell", for: indexPath) as? PokeCell {
            let data = favorites[indexPath.row]
            guard let name = data.value(forKeyPath: "name") as? String else {return cell}
            guard let url = data.value(forKeyPath: "url") as? String else {return cell}
            let img = URL(string: url)?.lastPathComponent ?? ""
            cell.label?.text = "\(name)"
            cell.sprite.image = UIImage(named: "temp")
            cell.sprite.imageFrom(url: "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"+img+".png")

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
      //  if(segment.selectedSegmentIndex)
        index = indexPath.row
          print("Performing Segue w/ index: \(index)")
          self.performSegue(withIdentifier: "showDetail", sender: self)
           // print("unit Print: " + units[unitIndex].name)
    }
    
}









