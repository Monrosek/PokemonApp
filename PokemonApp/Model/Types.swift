//
//  Types.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation

struct PokemonType {
    var slot:Int?
    var type:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let slot = dict["slot"] as? Int,
            let type = dict["type"] as? [String:Any]
            else {return nil}
        self.slot = slot
        self.type = namedResource(type)
    }
}

struct TypeRelations {
    var no_damage_to:namedResource?
    var half_damage_to:namedResource?
    var double_damage_to:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let no_damage_to = dict["no_damage_to"] as? [String:Any],
            let half_damage_to = dict["half_damage_to"] as? [String:Any],
            let double_damage_to = dict["double_damage_to"] as? [String:Any]
            else {return nil}
        self.no_damage_to = namedResource(no_damage_to)
        self.half_damage_to = namedResource(half_damage_to)
        self.double_damage_to = namedResource(double_damage_to)
    }
}

struct TypePokemon {
    var slot:Int?
    var pokemon:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let slot = dict["slot"] as? Int,
            let pokemon = dict["pokemon"] as? [String:Any]
            else {return nil}
        self.slot = slot
        self.pokemon = namedResource(pokemon)
    }
}

struct Type {
    var id:Int?
    var name:String?
    var damage_relations:TypeRelations?
    var game_indices:[GenerationGameIndex]?
    var generation:namedResource?
    var move_damage_class:namedResource?
    var names:[Name]?
    var pokemon:[TypePokemon]?
    var moves:[namedResource]?
    
    init?(_ dict:[String:Any]) {
        guard let id = dict["id"] as? Int,
            let name = dict["name"] as? String,
            let damage_relations = dict["damage_relations"] as? [String:Any],
            let game_indices = dict["game_indices"] as? [[String:Any]],
            let generation = dict["generation"] as? [String:Any],
            let move_damage_class = dict["move_damage_class"] as? [String:Any],
            let names = dict["names"] as? [[String:Any]],
            let pokemon = dict["pokemon"] as? [[String:Any]],
            let moves = dict["moves"] as? [[String:Any]]
            else {return nil}
        self.id = id
        self.name = name
        self.damage_relations = TypeRelations(damage_relations)
        self.game_indices = game_indices.flatMap{GenerationGameIndex($0)}
        self.generation = namedResource(generation)
        self.move_damage_class = namedResource(move_damage_class)
        self.names = names.flatMap {Name($0)}
        self.pokemon = pokemon.flatMap {TypePokemon($0)}
        self.moves = moves.flatMap {namedResource($0)}
    }
}


enum pokeTypes: String, Codable {
    case normal = "normal"
    case fighting = "fighting"
    case flying = "flying"
    case poison = "poison"
    case ground = "ground"
    case rock = "rock"
    case bug = "bug"
    case ghost = "ghost"
    case steel = "steel"
    case fire = "fire"
    case water = "water"
    case grass = "grass"
    case electric = "electric"
    case psychic = "psychic"
    case ice = "ice"
    case dragon = "dragon"
    case dark = "dark"
    case fairy = "fairy"
    case unknown = "unknown"
    case shadow = "shadow"
}







