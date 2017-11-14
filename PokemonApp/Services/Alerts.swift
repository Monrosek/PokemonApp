//
//  Alerts.swift
//  Pokedex
//
//  Created by Mac on 11/12/17.
//  Copyright © 2017 Mobile Apps Company. All rights reserved.
//

import UIKit

enum FieldType {
    case Email
    case Password
}

class Alert {
    class func Send(_ show:UIViewController, _ text:String) {
        let alert = UIAlertController(title: "Alert", message: text, preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        show.present(alert, animated: true, completion: nil)
    }
}

