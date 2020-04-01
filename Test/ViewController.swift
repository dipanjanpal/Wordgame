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
        
        let objItems = CreateBlanks()
        arrWords = objItems.createWordsCollection()
        collectionMain.reloadData()
    }


}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return arrWords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.reuseID, for: indexPath) as! CollectionViewCell
        
        let word = arrWords[indexPath.item]
        if word != Constants.blank{
            cell.lblWords.isHidden = false
            cell.tfWord.isHidden = true
            cell.lblWords.text = word
        }
        else{
            cell.lblWords.isHidden = true
            cell.tfWord.isHidden = false
            cell.tfWord.text =  "         "
            cell.tfWord.isUserInteractionEnabled = true
            cell.layer.borderWidth = Constants.borderWidth
            cell.layer.borderColor = UIColor.lightGray.cgColor
        }
        
        //cell.maxWidth = collectionView.bounds.width - Constants.spacing
        return cell
    }
}

private enum Constants {
    static let spacing: CGFloat = 16
    static let borderWidth: CGFloat = 0.5
    static let reuseID = "CollectionViewCell"
    static let blank = "_"
}



