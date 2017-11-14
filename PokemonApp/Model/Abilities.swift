//
//  Abilities.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation

struct Ability {
    var is_hidden:Bool
    var slot:Int
    var ability:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let is_hidden = dict["is_hidden"] as? Bool,
            let slot = dict["slot"] as? Int,
            let ability = dict["ability"] as? [String:Any]
            else {return nil}
        self.is_hidden = is_hidden
        self.slot = slot
        self.ability = namedResource(ability)
    }
}

struct PokemonMoveVersion {
    var move_learn_method:namedResource?
    var version_group:namedResource?
    var level_learned_at:Int?
    
    init?(_ dict:[String:Any]) {
        guard let moveLearned = dict["move_learn_method"] as? [String:Any],
            let vgroup = dict["version_group"] as? [String:Any],
            let lvlearned = dict["level_learned_at"] as? Int
            else {return nil}
        self.move_learn_method = namedResource(moveLearned)
        self.version_group = namedResource(vgroup)
        self.level_learned_at = lvlearned
    }
}

struct PokemonMove {
    var move:namedResource?
    var version_group_details:[PokemonMoveVersion]?
    
    init?(_ dict:[String:Any]) {
        guard let move = dict["move"] as? [String:Any],
            let vergroupdet = dict["version_group_details"] as? [[String:Any]]
            else {return nil}
        self.move = namedResource(move)
        self.version_group_details  = vergroupdet.flatMap {PokemonMoveVersion($0)}
    }
}
