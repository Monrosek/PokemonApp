//
//  PokeViewModel.swift
//  Pokedex
//
//  Created by Mac on 11/13/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

enum itemType {
    case image
    case stats
    case sprites
    case type
    case ability
    case label
    case list
}

protocol Item {
    var type: itemType {get}
    var rowCount: Int {get}
    var sectionTitle: String {get}
}
extension Item {
    var rowCount:Int{return 1}
}

class PokeViewModel: NSObject {
    var items = [Item]()
    
    init(poke:Pokemon) {
        super.init()
        
        if let img = poke.sprites?.front_default {
            var newItem = ImageItem(url: img)
            newItem.sectionTitle = poke.name ?? ""
            items.append(newItem)
        }
        
        if let types = poke.types {
            let newItem = TypesItem(types)
            items.append(newItem)
        }
        if let stats = poke.stats {
            let newItem = StatsItem(stats)
            items.append(newItem)
        }
        
        if let sprites = poke.sprites {
            let newItem = SpritesItem(sprites)
            items.append(newItem)
        }
        if let abilities = poke.abilities {
            let list = ListItem(list: abilities, " Main Abilities")
            items.append(list)
        }
        
    }
}

struct ImageItem: Item {
    var imgUrl:String
    var sectionTitle = String()
    var rowCount = 1
    var type: itemType {
        return .image
    }
    init(url: String) {
        self.imgUrl = url
    }
}

struct StatsItem: Item {
    var stats:[PokemonStat] = []
    var sectionTitle = String()
    var type: itemType {
        return .stats
    }
    
    init(_ stats:[PokemonStat]) {
        stats.forEach{self.stats.append($0)}
    }
}

struct TypesItem: Item {
    var types:[PokemonType] = []
    var sectionTitle = "Types"
    var type: itemType {
        return .type
    }
    
    init(_ types:[PokemonType]) {
        types.forEach{self.types.append($0)}
    }
    
}

struct LabelItem: Item {
    var resource:namedResource
    var sectionTitle = String()
    var type: itemType {
        return .label
    }
    
    init(name:String, url:String) {
        self.resource = namedResource(name,url)
    }
    
     init(_ res: namedResource) {
        self.resource = res
    }
}

struct ListItem: Item {
    var sectionTitle = String()
    var list:[LabelItem] = []
    var type: itemType {
        return .list
    }
    var rowCount: Int {
        return list.count
    }
    
    init(list: [Ability],_ section: String){
        self.sectionTitle = section
        for item in list {
            if let ability = item.ability {
                var litem = LabelItem(ability)
                litem.sectionTitle = section
                self.list.append(litem)
            }

        }
    }
}

struct SpritesItem : Item{
    var sprites:[String?] = []
    var sectionTitle = "Sprites"
    var type: itemType {
        return .sprites
    }
    
    init(_ sprite:PokemonSprite) {
        if let str = sprite.front_default {
            sprites.append(str)
        }
        if let str = sprite.front_Shiny {
            sprites.append(str)
        }
        if let str = sprite.front_female {
            sprites.append(str)
        }
        if let str = sprite.front_shiny_female {
            sprites.append(str)
        }
        if let str = sprite.back_default {
            sprites.append(str)
        }
        if let str = sprite.back_shiny {
            sprites.append(str)
        }
        if let str = sprite.back_female {
            sprites.append(str)
        }
        if let str = sprite.back_shiny_female {
            sprites.append(str)
        }
        
    }
}

