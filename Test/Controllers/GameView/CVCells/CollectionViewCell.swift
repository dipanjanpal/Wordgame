//
//  CollectionViewCell.swift
//  Test
//
//  Created by Dipanjan Pal on 31/03/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import UIKit

class CollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var tfWord: UITextField!
    @IBOutlet weak var lblWords: UILabel!
    let doneToolbar: UIToolbar = UIToolbar()
    let pickerWords = UIPickerView()
    var arrWordsSelectedIndex = 0
    var chosenWord = String()
    var indexPathRow = -1
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addWordsPicker()
        addDoneButton()
        tfWord.delegate =  self
        contentView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            contentView.leftAnchor.constraint(equalTo: leftAnchor),
            contentView.rightAnchor.constraint(equalTo: rightAnchor),
            contentView.topAnchor.constraint(equalTo: topAnchor),
            contentView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
    
    //MARK: button actions
    @objc func doneButtonAction()
    {
        chosenWord = CommonConstants.shared.arrShuffeledWords[arrWordsSelectedIndex]
        tfWord.text = chosenWord
        if indexPathRow != -1{
            CommonConstants.shared.arrUserInputtedWords[indexPathRow] = chosenWord
        }
        CommonConstants.shared.arrShuffeledWords.remove(at: arrWordsSelectedIndex)
        contentView.endEditing(true)
        pickerWords.reloadAllComponents()
    }
    
    
    //MARK: custom functions
    func addWordsPicker(){
        
        pickerWords.delegate = self
        pickerWords.dataSource = self
        tfWord.inputView = pickerWords
    }
    
    func addDoneButton(){
        
        
        doneToolbar.barStyle = UIBarStyle.default
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        let done: UIBarButtonItem = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(doneButtonAction))
        
        var items = [UIBarButtonItem]()
        
        items.append(flexSpace)
        
        items.append(done)
        
        doneToolbar.items = items
        
        doneToolbar.sizeToFit()
        
        tfWord.inputAccessoryView = doneToolbar
    }
    
    
    
}

extension CollectionViewCell : UIPickerViewDelegate, UIPickerViewDataSource{
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return CommonConstants.shared.arrShuffeledWords.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return CommonConstants.shared.arrShuffeledWords[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        arrWordsSelectedIndex = row
        tfWord.text = CommonConstants.shared.arrShuffeledWords[row]
        
    }
}

extension CollectionViewCell : UITextFieldDelegate{
    func textFieldDidBeginEditing(_ textField: UITextField) {
        if textField.text != "_________________"{
            textField.endEditing(true)
        }
    }
}

