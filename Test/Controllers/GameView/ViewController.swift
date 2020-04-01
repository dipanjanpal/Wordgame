//
//  ViewController.swift
//  Test
//
//  Created by Dipanjan Pal on 31/03/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var arrWords = [String]()
    var currentLevel : Int = 100
    @IBOutlet weak var viewLoader: UIView!
    @IBOutlet weak var lblLevel: UILabel!
    @IBOutlet weak var collectionMain: UICollectionView!
    @IBOutlet weak var collectionLayout: UICollectionViewFlowLayout!{
        didSet {
            collectionLayout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        }
    }
    
    //MARK: viewlifecycle functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        let nib1 = UINib(nibName: Constants.reuseID, bundle: Bundle.main)
        collectionMain.register(nib1, forCellWithReuseIdentifier: Constants.reuseID)
        
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if CommonConstants.shared.level > currentLevel {
            CommonConstants.shared.alert(message: "Congratulations!\nLevel Up", vc: self)
        }
        
        lblLevel.text = "Level : \(CommonConstants.shared.level)"
        currentLevel = CommonConstants.shared.level
        arrWords.removeAll()
        
        CommonConstants.shared.arrShuffeledWords.removeAll()
        CommonConstants.shared.arrActualRemovedWords.removeAll()
        CommonConstants.shared.arrUserInputtedWords.removeAll()
        
        getParagraph()
        
    }

    //MARK: button actions
    
    @IBAction func btnResetAction(_ sender: Any) {
        arrWords.removeAll()
        
        CommonConstants.shared.arrShuffeledWords.removeAll()
        CommonConstants.shared.arrActualRemovedWords.removeAll()
        CommonConstants.shared.arrUserInputtedWords.removeAll()
        
        getParagraph()
        
    }
    
    @IBAction func btnSubmitAction(_ sender: Any) {
        let storyBoard : UIStoryboard = UIStoryboard(name: "Main", bundle:nil)
        let scoreVC = storyBoard.instantiateViewController(withIdentifier: Constants.scoreBoardID) as! ScoreboardViewController
        scoreVC.arrWords = self.arrWords
        self.present(scoreVC, animated:true, completion:nil)
        
    }
    
    
    // MARK: custom functions
    // netwrok calls
    func getParagraph() {
        viewLoader.isHidden = false
        BaseNetworking.getApi { (model) in
            DispatchQueue.main.async {
                let randomPara = Int.random(in: 0...5)
                let objItems = CreateBlanks(para: model.paras?[randomPara] ?? "")
                self.arrWords = objItems.createWordsCollection()
                self.collectionMain.reloadData()
                self.viewLoader.isHidden = true
                
                
                let lastIndexPath = IndexPath(item: self.arrWords.count / 2, section: 0)
                self.collectionMain.scrollToItem(at: lastIndexPath, at: UICollectionView.ScrollPosition.bottom, animated: true)
            }
        }
    }
}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! CollectionViewCell
        cell.lblWords.text = nil
        cell.tfWord.text = nil
        cell.indexPathRow = indexPath.item
        let word = arrWords[indexPath.item]
        if word != Constants.blank{
            cell.lblWords.isHidden = false
            cell.tfWord.isHidden = true
            cell.lblWords.text = word
            cell.lblWords.backgroundColor = UIColor.init(red: 239/255, green: 239/255, blue: 239/255, alpha: 1)
            cell.layer.borderWidth = 0
            cell.layer.borderColor = UIColor.clear.cgColor
        }
        else{
            cell.lblWords.isHidden = true
            cell.tfWord.backgroundColor = UIColor.white
            cell.tfWord.isHidden = false
            if (CommonConstants.shared.arrUserInputtedWords[indexPath.item] != nil || CommonConstants.shared.arrUserInputtedWords[indexPath.item] == "_________________"){
                cell.tfWord.text = CommonConstants.shared.arrUserInputtedWords[indexPath.item]
            }
            else{
                cell.tfWord.text =  "_________________"
                CommonConstants.shared.arrUserInputtedWords[indexPath.item] = "_________________"
            }
            
            cell.tfWord.isUserInteractionEnabled = true
            cell.layer.borderWidth = Constants.borderWidth
            cell.layer.borderColor = UIColor.lightGray.cgColor
        }

        return cell
    }
}
//MARK: constants for only this file
private enum Constants {
    static let spacing: CGFloat = 16
    static let borderWidth: CGFloat = 0.5
    static let reuseID = "CollectionViewCell"
    static let scoreBoardID = "ScoreboardViewController"
    static let blank = "_"
}



