//
//  ScoreboardViewController.swift
//  Test
//
//  Created by Dipanjan Pal on 01/04/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import UIKit

class ScoreboardViewController: UIViewController {

    var arrWords = [String]()
    var arrCorrectWordsIndex = [Int]()
    @IBOutlet weak var lblScore: UILabel!
    @IBOutlet weak var collectionMain: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let nib1 = UINib(nibName: Constants.reuseID, bundle: Bundle.main)
        collectionMain.register(nib1, forCellWithReuseIdentifier: Constants.reuseID)
        
        var arrUserInputtedWordsKeys = Array(CommonConstants.shared.arrUserInputtedWords.keys)
        arrUserInputtedWordsKeys.sort(by: <)
        lblScore.text = "Score\n\(evaluate(keysForUSerInputes: arrUserInputtedWordsKeys)) / 10"
        collectionMain.reloadData()
    }
    
    func evaluate(keysForUSerInputes :[Int]) -> Int{
        var index = 0
        var score = 0
        for keyNumber in keysForUSerInputes{
            if CommonConstants.shared.arrUserInputtedWords[keyNumber] ==  CommonConstants.shared.arrActualRemovedWords[index]{
                score += 1
                arrWords[keyNumber] = CommonConstants.shared.arrActualRemovedWords[index]
                arrCorrectWordsIndex.append(keyNumber)
            }
            else{
                arrWords[keyNumber] = "*\(CommonConstants.shared.arrActualRemovedWords[index]) / \(CommonConstants.shared.arrUserInputtedWords[keyNumber] ?? "")"
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

extension ScoreboardViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! CollectionViewCell
        cell.lblWords.text = nil
        cell.tfWord.text = nil
        cell.indexPathRow = indexPath.item
        let word = arrWords[indexPath.item]
        
        cell.lblWords.isHidden = false
        cell.tfWord.isHidden = true
        cell.lblWords.text = word
        if word.contains("*"){
            cell.lblWords.backgroundColor = UIColor.red
        }
        else if arrCorrectWordsIndex.contains(indexPath.row){
            cell.lblWords.backgroundColor = UIColor.green
        }
        else{
            cell.lblWords.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
        }
        
        cell.layer.borderWidth = 0
        cell.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
}

private enum Constants {
    static let reuseID = "CollectionViewCell"
    static let scoreBoardID = "ScoreboardViewController"
}
