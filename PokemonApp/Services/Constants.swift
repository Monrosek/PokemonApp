//
//  Constants.swift
//  PokemonApp
//
//  Created by Mac on 11/14/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import Foundation

class k {
    static let UserNameKey = "com.company.app.UserKey"
    static let PassKey = "com.company.app.Password"
}

class API {
    static let root = "https://pokeapi.co/api/v2/"
    static let offset = 0
    static let MaxPokemon = 151
    static let  limit = "?limit=\(MaxPokemon)&offset=\(offset)"
    static let img = "https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/"
}
