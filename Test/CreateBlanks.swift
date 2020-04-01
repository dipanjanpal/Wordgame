//
//  CreateBlanks.swift
//  Test
//
//  Created by Dipanjan Pal on 31/03/20.
//  Copyright © 2020 Dipanjan Pal. All rights reserved.
//

import Foundation

class CreateBlanks{
    let para = "Wine is an alcoholic drink typically made from fermented grapes. Yeast consumes the sugar in the grapes and converts it to ethanol, carbon dioxide, and heat. Different varieties of grapes and strains of yeasts produce different styles of wine. These variations result from the complex interactions between the biochemical development of the grape, the reactions involved in fermentation, the grape is growing environment (terroir), and the production process. Many countries enact legal appellations intended to define styles and qualities of wine. These typically restrict the geographical origin and permitted varieties of grapes, as well as other aspects of wine production. Wines not made from grapes involve fermentation of additional crops including, rice wine and other fruit wines such as plum, cherry, pomegranate, currant and elderberry. Wine has been produced for thousands of years.The earliest evidence of wine is from Georgia (6000 BC), Iran (5000 BC), and Sicily (4000 BC). In modern times, the five countries with the largest wine-producing regions are in Italy, Spain, France, the United States, and China."
    
    let varbsFilter = ["am", "is", "are", "was", "were"]

    let tagger = NSLinguisticTagger(tagSchemes:[.tokenType, .language, .lexicalClass, .nameType, .lemma], options: 0)
    let options: NSLinguisticTagger.Options = [.omitPunctuation, .omitWhitespace, .joinNames]

    func createWordsCollection() -> [String]{
        let arrPara = para.split(separator: ".")
        var arrWords = [String]()
        //var arrLines = [[String]]()
        for line in arrPara{
            removeVerbs(for: String(line)).forEach { (word) in
                arrWords.append(word)
            }
        }

        return arrWords
    }

    
    
    func removeVerbs(for text: String) -> [String]{
        var newItem = [String]()
        tagger.string = text
        let range = NSRange(location: 0, length: text.utf16.count)
        tagger.enumerateTags(in: range, unit: .word, scheme: .lexicalClass, options: options) { tag, tokenRange, _ in
            
            if let tag = tag {
                let word = (text as NSString).substring(with: tokenRange)
                if (tag.rawValue == "Verb" && varbsFilter.contains(word) != true && newItem.contains("_") != true){
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
        if (newItem.contains("_") == false){
            let randNum = Int.random(in: 0...6)
            CommonConstants.shared.arrActualRemovedWords.append(newItem[randNum])
            newItem.insert("_", at: randNum)
        }
        return newItem
    }

}
