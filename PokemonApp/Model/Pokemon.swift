//
//  Pokemon.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

struct Pokemon {
    var id:Int?
    var name:String?
    var base_experience:Int?
    var height:Int?
    var is_default:Bool?
    var order:Int?
    var weight:Int?
    var abilities:[Ability]?
    var forms:[namedResource]?
    var game_indices:[VersionGameIndex]?
    var held_items:[PokemonHeldItem]?
    var location_area_encounters:String?
    var moves:[PokemonMove]?
    var sprites:PokemonSprite?
    var species:namedResource?
    var stats:[PokemonStat]?
    var types:[PokemonType]?
    
    init? (data:Data) {
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            guard let id = json?["id"] as? Int,
                let name = json?["name"] as? String,
                let base_experience = json?["base_experience"] as? Int,
                let height = json?["height"] as? Int,
                let is_default = json?["is_default"] as? Bool,
                let order = json?["order"] as? Int,
                let weight = json?["weight"] as? Int,
                let location_area_encounters = json?["location_area_encounters"] as? String,
                let abilities = json?["abilities"] as? [[String:Any]],
                let forms = json?["forms"] as? [[String:Any]],
                let game_indices = json?["game_indices"] as? [[String:Any]],
                let held_items = json?["held_items"] as? [[String:Any]],
                let moves = json?["moves"] as? [[String:Any]],
                let sprites = json?["sprites"] as? [String:Any],
                let species = json?["species"] as? [String:Any],
                let stats = json?["stats"] as? [[String:Any]],
                let types = json?["types"] as? [[String:Any]]
                else {return nil}
            self.id = id
            self.name = name
            self.base_experience = base_experience
            self.height = height
            self.is_default = is_default
            self.order = order
            self.weight = weight
            self.location_area_encounters = location_area_encounters
            self.forms = forms.flatMap{namedResource($0)}
            self.sprites = PokemonSprite(sprites)
            self.species = namedResource(species)
            self.game_indices = game_indices.flatMap{VersionGameIndex($0)}
            self.abilities = abilities.flatMap {Ability($0)}
            self.held_items = held_items.flatMap {PokemonHeldItem($0)}
            self.moves = moves.flatMap {PokemonMove($0)}
            self.stats = stats.flatMap {PokemonStat($0)}
            self.types = types.flatMap {PokemonType($0)}
        } catch let error {
            print("Couldnt create Pokemon obj! \(error.localizedDescription )")
        }
    }
}

struct PokemonSprite {
    var front_default:String?
    var front_Shiny:String?
    var front_female:String?
    var front_shiny_female:String?
    var back_default:String?
    var back_shiny:String?
    var back_female:String?
    var back_shiny_female:String?
    
    init(_ sprite:[String:Any]) {
        
        if let front_default = sprite["front_default"] as? String {
            self.front_default = front_default
        }
        if let front_Shiny = sprite["front_Shiny"] as? String {
            self.front_Shiny = front_Shiny
        }
        if let front_female = sprite["front_female"] as? String {
            self.front_female = front_female
        }
        if let front_shiny_female = sprite["front_shiny_female"] as? String {
            self.front_shiny_female = front_shiny_female
        }
        if let back_default = sprite["back_default"] as? String {
            self.back_default = back_default
        }
        if let back_shiny = sprite["back_shiny"] as? String {
            self.back_shiny = back_shiny
        }
        if let back_female = sprite["back_female"] as? String {
            self.back_female = back_female
        }
        if let back_shiny_female = sprite["back_shiny_female"] as? String {
            self.back_shiny_female = back_shiny_female
        }
    }
}

enum statType: String, Codable {
    case HP = "Hp"
    case ATK = "attack"
    case DEF = "defense"
    case SATK = "special-attack"
    case SDEF = "special-defense"
    case SPD = "speed"
    case ACC = "accuracy"
    case EVA = "evasion"
    case NA = "N/A"
}
struct PokemonStat {
    var stat:namedResource?
    var effort:Int?
    var base_stat:Int?
    
    init?(_ dict:[String:Any]) {
        guard let stat = dict["stat"] as? [String:Any],
            let effort = dict["effort"] as? Int,
            let base_stat = dict["base_stat"] as? Int
            else {return nil}
        self.stat = namedResource(stat)
        self.effort = effort
        self.base_stat = base_stat
    }
    
    func getStat()->String? {
        return stat?.name
    }
    
    func getStatType()->statType {
        if let s = self.getStat() {
            switch s {
            case "hp": return .HP
            case "attack": return .ATK
            case "defense": return .DEF
            case "special-attack": return .SATK
            case "special-defense": return .SDEF
            case "speed": return .SPD
            case "accuracy": return .ACC
            case "evasion": return .EVA
            default:
                fatalError("No Stat identifier matches")
            }
        }
        return .NA
    }
}

struct PokemonHeldItem {
    var item:namedResource?
    var version_details:PokemonHeldItemVersion?
    
    init?(_ dict:[String:Any]) {
        guard let item = dict["item"] as? [String:Any],
            let vDetail = dict["version_details"] as? [String:Any]
            else {return nil}
        self.item = namedResource(item)
        self.version_details = PokemonHeldItemVersion(vDetail)
    }
}

struct PokemonHeldItemVersion {
    var version:namedResource?
    var rarity:Int?
    
    init?(_ dict:[String:Any]) {
        guard let version = dict["version"] as? [String:Any],
            let rarity = dict["rarty"] as? Int
            else {return nil}
        self.version = namedResource(version)
        self.rarity = rarity
    }
}

