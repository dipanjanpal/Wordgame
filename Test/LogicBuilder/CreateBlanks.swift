//
//  CreateBlanks.swift
//  Test
//
//  Created by Dipanjan Pal on 31/03/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import Foundation

class CreateBlanks{
    let para : String
    init(para : String){
        self.para = para
    }
    
    
    let varbsFilter = ["am", "is", "are", "was", "were"]

    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

    
    //MARK: main function to create words collection
    func createWordsCollection() -> [String]{
        let arrPara = para.split(separator: ".")
        var arrWords = [String]()
        for line in arrPara{
            if CommonConstants.shared.level == 1 {
                removeVerbs(for: String(line)).forEach { (word) in
                    arrWords.append(word)
                }
            }
            else if  CommonConstants.shared.level == 2{
                removePrepositions(for: String(line)).forEach { (word) in
                    arrWords.append(word)
                }
            }
            
        }
        CommonConstants.shared.arrShuffeledWords = CommonConstants.shared.arrActualRemovedWords.shuffled()
        print("actual words ===>>>",CommonConstants.shared.arrActualRemovedWords)
        return arrWords
    }

    
    //MARK: logic for level 1
    //remove verbs
    func removeVerbs(for text: String) -> [String]{
        var newItem = [String]()
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                
                if (tag.rawValue == "Verb" && newItem.contains("_") != true && CommonConstants.shared.arrActualRemovedWords.contains(word) != true){
                    newItem.append("_")
                    CommonConstants.shared.arrActualRemovedWords.append(word)
                }
                else{
                     newItem.append(word)
                }
                //print("\(word): \(tag.rawValue)")
            }
        }
        newItem.append(".")
        if (newItem.contains("_") == false && newItem.count > 6){
            let randNum = Int.random(in: 0...6)
            CommonConstants.shared.arrActualRemovedWords.append(newItem[randNum])
            newItem.insert("_", at: randNum)
        }
        return newItem
    }
    //MARK:- logic for level 2
    //(removing prepositions)
    func removePrepositions(for text: String) -> [String]{
        var newItem = [String]()
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                
                if (tag.rawValue == "Preposition" && varbsFilter.contains(word) != true && newItem.contains("_") != true && CommonConstants.shared.arrActualRemovedWords.contains(word) != true){
                    newItem.append("_")
                    CommonConstants.shared.arrActualRemovedWords.append(word)
                }
                else{
                     newItem.append(word)
                }
                //print("\(word): \(tag.rawValue)")
            }
        }
        newItem.append(".")
        if (newItem.contains("_") == false && newItem.count > 6){
            let randNum = Int.random(in: 0...6)
            CommonConstants.shared.arrActualRemovedWords.append(newItem[randNum])
            newItem.insert("_", at: randNum)
        }
        return newItem
    }


}
