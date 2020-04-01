//
//  CommonConstants.swift
//  Test
//
//  Created by Dipanjan Pal on 01/04/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import Foundation
import UIKit
class CommonConstants{
    init(){}
    static let shared = CommonConstants()
    let BASEURL = "https://api.myjson.com/bins/147vwo"
    var arrShuffeledWords = [String]()
    var arrActualRemovedWords = [String]()
    var arrUserInputtedWords = [Int : String]()
    var level = 1
    
    func alert(message : String, vc : UIViewController){
        let alert = UIAlertController(title: "WordGame", message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        vc.navigationController?.present(alert, animated: true, completion: nil)
    }
    
}
