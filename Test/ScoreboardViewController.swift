//
//  ScoreboardViewController.swift
//  Test
//
//  Created by Dipanjan Pal on 01/04/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController {

    @IBOutlet weak var lblScore: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        var arrUserInputtedWordsKeys = Array(CommonConstants.shared.arrUserInputtedWords.keys)
        arrUserInputtedWordsKeys.sort(by: <)
        lblScore.text = "Score\n\(evaluate(keysForUSerInputes: arrUserInputtedWordsKeys))"
        
    }
    
    func evaluate(keysForUSerInputes :[Int]) -> Int{
        var index = 0
        var score = 0
        for i in keysForUSerInputes{
            if CommonConstants.shared.arrUserInputtedWords[i] ==  CommonConstants.shared.arrActualRemovedWords[index]{
                score += 1
            }
            index += 1
        }
        if score >= 8 && CommonConstants.shared.level != 2{
            CommonConstants.shared.level += 1
            
        }
        return score
    }
    
    @IBAction func btnDoneAction(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
}
