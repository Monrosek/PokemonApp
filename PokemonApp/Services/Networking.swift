//
//  NetworkCalls.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit


enum NetworkError:Error{
    case BadURL
    case NoDataOnServer
    case DataContainedNoObject
}

class NetworkService {
    
    class func getImage(from url:String,completionHandler:@escaping(UIImage?,Error?)->()){
        guard let url = URL(string:url) else {
            completionHandler(nil, NetworkError.BadURL)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.NoDataOnServer)
                return
            }
            // print(String(data: data, encoding: .utf8) ?? "nothing")
            guard let image = UIImage(data: data) else {
                completionHandler(nil, NetworkError.DataContainedNoObject)
                return
            }
            completionHandler(image, nil)
        }
        task.resume()
    }
    
    //class func getPokemonImage(from ur)
    
    class func getPokemon(from url:String, completionHandler:@escaping(Pokemon?,Error?)->()){
        guard let url = URL(string:url) else {
            completionHandler(nil, NetworkError.BadURL)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.NoDataOnServer)
                return
            }
            guard let poke = Pokemon(data: data) else {
                completionHandler(nil, NetworkError.DataContainedNoObject)
                return
            }
            completionHandler(poke, nil)
        }
        task.resume()
    }
    
    class func getResourceList(ofType type:ResourceType, completionHandler:@escaping(APINamedResourceList?, Error?)->()){
        guard let url = URL(string: String(API.root+"\(type.rawValue)/"+API.limit)) else {
            completionHandler(nil, NetworkError.BadURL)
            return
        }
        let session = URLSession.shared
        let task = session.dataTask(with: url) { (data, response, error) in
            guard error == nil else {
                completionHandler(nil, error)
                return
            }
            guard let data = data else {
                completionHandler(nil, NetworkError.NoDataOnServer)
                return
            }
            guard let rsrcList = APINamedResourceList(data: data) else {
                completionHandler(nil, NetworkError.DataContainedNoObject)
                return
            }
            completionHandler(rsrcList, nil)
        }
        task.resume()
    }
    class func getCachedPokemon(url: String) -> Pokemon? {
        let cache = GlobalCache.shared.pokeCache
        if let obj = cache.object(forKey: url as NSString) {
            if let poke = obj as? Pokemon {
                return poke
            }
        }
        
        getPokemon(from: url) { (poke,error) in
            guard error == nil else {return}
            guard let poke = poke else {return}
            cache.setObject(poke as AnyObject, forKey: url as NSString)
            DispatchQueue.main.sync {
                return poke
            }
        }
        return nil
    }
    
}

