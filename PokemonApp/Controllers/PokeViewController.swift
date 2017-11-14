//
//  DetailViewController.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

class PokeViewController: UIViewController, UITableViewDelegate {
    
    @IBOutlet var back: UIBarButtonItem!
    @IBOutlet var tableView: UITableView!
    
    var viewModel:PokeViewModel?
    var poke:Pokemon?
    var resource:namedResource?
    
    @IBOutlet var addFav: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        guard let url = resource?.url else {return}
        NetworkService.getPokemon(from: url) { (poke,error) in
            guard error == nil else {return}
            guard let poke = poke else {return}
            DispatchQueue.main.sync {
                self.poke = poke
                self.viewModel = PokeViewModel(poke:poke)
                self.tableView.dataSource = self.viewModel
                self.tableView.delegate = self
                self.tableView.estimatedRowHeight = 200
                self.tableView.rowHeight = UITableViewAutomaticDimension
                //                    print("items: \(self.viewModel?.items.count ?? 0)")
                self.tableView.reloadData()
            }
        }
        self.tableView.register(imageCell.nib, forCellReuseIdentifier: imageCell.identifier)
        self.tableView.register(statsCell.nib, forCellReuseIdentifier: statsCell.identifier)
        self.tableView.register(typesCell.nib, forCellReuseIdentifier: typesCell.identifier)
        self.tableView.register(spritesCell.nib, forCellReuseIdentifier: spritesCell.identifier)

        
        print("items: \(self.viewModel?.items.count ?? 0)")
    }
    
    @IBAction func Return(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
//     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//     // Get the new view controller using segue.destinationViewController.
//     // Pass the selected object to the new view controller.
//     }
 
}

extension PokeViewModel:UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
       // print("numsections: \(items.count)")
        return items.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //print("numRows: \(items[section].rowCount)")
        return items[section].rowCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       // print("Enter Cell")
        let cell = UITableViewCell()
        let item = items[indexPath.section]
        switch item.type {
        case .image:
           // tableView.estimatedRowHeight = 383
            if let cell = tableView.dequeueReusableCell(withIdentifier: imageCell.identifier, for: indexPath) as? imageCell {
                if let data = item as? ImageItem {
                    
                    tableView.rowHeight = 383
                    cell.sprite.imageFrom(url: data.imgUrl)
                   // cell.sprite.resizeImage(targetSize: CGSize(width:359, height:281))
                }
                cell.item = item
                return cell
            }
        
        case .stats:
            if let cell = tableView.dequeueReusableCell(withIdentifier: statsCell.identifier, for: indexPath) as? statsCell {
                tableView.rowHeight = 186

                //tableView.backgroundColor = UIColor.blue
                cell.item = item
              return cell
            }
        case .type:
            if let cell = tableView.dequeueReusableCell(withIdentifier: typesCell.identifier, for: indexPath) as? typesCell {
                tableView.rowHeight = 59
                cell.item = item
                print("Sending Cell \(item.sectionTitle)")
                return cell
            }
        case .sprites:
            print("Enter sprites")
            if let cell = tableView.dequeueReusableCell(withIdentifier: spritesCell.identifier, for: indexPath) as? spritesCell {
                tableView.rowHeight = 294
                cell.item = item
              //  print("Sending Cell \(item.sectionTitle)")
                return cell
            }
        default: return cell
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return items[section].sectionTitle
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
}


