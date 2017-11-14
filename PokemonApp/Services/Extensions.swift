//
//  Extensions.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.

import UIKit

extension UITextField {
    func Evaluate(_ type:FieldType) -> Bool {
        var regex:String
        switch type {
        case .Email: regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        case .Password: regex = "^(?=.*[0-9]).{6,}"
        }
        return NSPredicate(format: "SELF MATCHES %@", regex).evaluate(with: self.text)
    }
}

extension UIImageView {
    
    func imageFrom(url: String) {
        let cache = GlobalCache.shared.imageCache
        if let image = cache.object(forKey: url as NSString) {
            self.image = image
            return
        }
        
        NetworkService.getImage(from: url) { (image,error) in
            guard error == nil else {return}
            guard let image = image else {return}
            cache.setObject(image, forKey: url as NSString)
            DispatchQueue.main.sync {
                self.image = image
            }
        }
    }
    
    
    
    func resizeImage(targetSize: CGSize) {
        guard let size = self.image?.size else {return}
        
        let widthRatio  = targetSize.width  / size.width
        let heightRatio = targetSize.height / size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSize(width: size.width * heightRatio, height: size.height * heightRatio)
        } else {
            newSize = CGSize(width: size.width * widthRatio,  height: size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        self.draw(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.image = newImage
    }
    
    
}

extension PokeCell {
    func pokeFrom(url:String) {
        if let poke = NetworkService.getCachedPokemon(url: url) {
            self.poke = poke
        }
        else{
            NetworkService.getPokemon(from: url) { (poke,error) in
                guard error == nil else {return}
                guard let poke = poke else {return}
                GlobalCache.shared.pokeCache.setObject(poke as AnyObject, forKey: url as NSString)
                DispatchQueue.main.sync {
                    self.poke = poke
                }
            }
        }
    }
}

extension Encodable {
    var dictionary: [String: Any] {
        return (try? JSONSerialization.jsonObject(with: JSONEncoder().encode(self))) as? [String: Any] ?? [:]
    }
    var nsDictionary: NSDictionary {
        return dictionary as NSDictionary
    }
}

extension UIColor {
    convenience init(red: Int,green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    
    convenience init(_ rgb: Int) {
        self.init(
            red: (rgb >> 16) & 0xFF,
            green: (rgb >> 8) & 0xFF,
            blue: rgb & 0xFF
        )
    }
}






