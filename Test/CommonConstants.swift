//
//  CommonConstants.swift
//  Test
//
//  Created by Dipanjan Pal on 01/04/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import Foundation

class CommonConstants{
    init(){}
    static let shared = CommonConstants()
    var arrShuffeledWords = [String]()
    var arrActualRemovedWords = [String]()
    var arrUserInputtedWords = [Int : String]()
    var level = 1
}
