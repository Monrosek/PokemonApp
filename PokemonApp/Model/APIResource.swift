//
//  APIResource.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//


import UIKit

enum ResourceType: String {
    case pokemon = "pokemon"
    case types = "type"
    case abilities = "ability"
    case evolution = "evolution-chain"
}
protocol resource {
    var url:String {get}
}

struct namedResource: resource {
    var name:String = String()
    var url:String = String()
    
    init?(_ dict:[String:Any]) {
        guard let name = dict["name"] as? String,
            let url = dict["url"] as? String
            else {return nil}
        self.name = name
        self.url = url
    }
}

struct APINamedResourceList {
    var count:Int?
    var next:String?
    var previous:Bool?
    var results:[namedResource]?
    
    init?(data:Data){
        do{
            let json = try JSONSerialization.jsonObject(with: data) as? [String:Any]
            if let count = json?["count"] as? Int {self.count = count}
            if let previous = json?["previous"] as? Bool {self.previous = previous}
            if let next = json?["next"] as? String {self.next = next}
            if let results = json?["results"] as? [[String:Any]] {
                self.results = results.flatMap{namedResource($0)}
            }
        }
        catch let error {
            print("APINamedResourceList init Failed! \(error.localizedDescription)")
        }
    }
}

struct Name {
    var name:String?
    var language:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let name = dict["name"] as? String,
            let language = dict["language"] as? [String:Any]
            else {return nil}
        self.name = name
        self.language = namedResource(language)
    }
}

struct VersionGameIndex {
    var game_index:Int?
    var version:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let game_index = dict["game_index"] as? Int,
            let version = dict["version"] as? [String:Any]
            else {return nil}
        self.game_index = game_index
        self.version = namedResource(version)
    }
}

struct GenerationGameIndex {
    var game_index:Int?
    var generation:namedResource?
    
    init?(_ dict:[String:Any]) {
        guard let generation = dict["generation"] as? [String:Any],
            let game_index = dict["game_index"] as? Int
            else {return nil}
        self.game_index = game_index
        self.generation = namedResource(generation)
    }
}

enum pokeView {
    case all
    case typed
    
}

