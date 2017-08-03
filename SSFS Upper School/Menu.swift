//
//  Menu.swift
//  SSFS Lunch
//
//  Created by Claire Youmans on 4/25/16.
//  Copyright © 2016 Claire Youmans. All rights reserved.
//

import Foundation
class Menu {
    var menuContents = String()
    
    var shorterMenu = [String]()
    var otherMenu = [String]()
    var differentMenu = [String]()
    var spacesMenu = [String]()
    var aMenu = String()
    
    init() {
//        let path = NSBundle.mainBundle().pathForResource("document", ofType: "xml")
//        
//        do {
//            self.menuContents = try String(contentsOfFile: path!) //exclamation point so that it doesn't return nil
//        }
//        catch {
//            print("There was an error.")
//        }
        
        retrieveMenuFromWebsite()
        stripOutXMLfromMenu()
        createTextOnlyMenu()
        
        var number = Int()
        var loop = -1
        var n = 0
        for item in differentMenu {
            spacesMenu.append(item)
        }
        
//        for item in differentMenu {
//            loop += 1
//            if item == "SIDES" {
//                print(item)
//                //okay, so I know that this messes up when cous cous is a side dish, because it's in the array as "cous" and then a separate, secondary "cous", but I'd rather have it look a little weird the few times a year that they have cous cous or any other side dish that is separated in the array and have it print out "cous & cous", and have everything else look nice, than to have every day of the year look weird and bunched together, and because I just spent a lot of time trying to figure out how to get it to print out an ampersand in between sides and souper soups, I am surprisingly adamant about this issue.
//                number = loop + 2 + n
//                spacesMenu.insert(" & ", at: number)
//                n += 1
//            } else if item == "SOUPER SOUPS" {
//                number = loop + 2 + n
//                spacesMenu.insert(" & ", at: number)
//                n += 1
//            }
//        }
        for item in spacesMenu {
            let newString = String(item)
            aMenu = aMenu + newString!
        }
    }
    
        func rangeFromNSRange(nsRange: NSRange, forString str: String) -> Range<String.Index>? {
            let fromUTF16 = str.utf16.startIndex.advanced(by: nsRange.location)
            let toUTF16 = fromUTF16.advanced(by: nsRange.length)
            if let from = String.Index(fromUTF16, within: str),
            let to = String.Index(toUTF16, within: str) {
                return from ..< to
            }
            return nil
        }
    
    func retrieveMenuFromWebsite() {
        if let url = NSURL(string: "https://grover.ssfs.org/menus/word/document.xml") {
            
            do {
                self.menuContents = try String(contentsOf: url as URL)
            } catch {
                print("there was an error.")
            }
        }
    }
    
    func stripOutXMLfromMenu() {
        let newMenu = self.menuContents.components(separatedBy: ">")
        for item in newMenu {
            if item.contains("</w:t") && !item.contains("</w:tc") && !item.contains("</w:tr") && !item.contains("</w:tbl"){
                shorterMenu.append(item)
            }
        }
    }
    
    func createTextOnlyMenu() {
        for item in shorterMenu {
            if item.contains("</w:t") {
                let newString = item.replacingOccurrences(of: "</w:t", with: "")
                otherMenu.append(newString)
            }
            else {
                otherMenu.append(item)
            }
        }
        
        for item in otherMenu {
            if item.contains("&amp;") {
                let newString = item.replacingOccurrences(of: "&amp;", with: "&")
                differentMenu.append(newString)
            }
            else {
                differentMenu.append(item)
            }
        }
    }
    
    func getLunch(stringToParse: String, regExText: String) -> String {
        var name: String = ""
            do {
                let regex = try NSRegularExpression(pattern: regExText, options: NSRegularExpression.Options.caseInsensitive)
                let matches = regex.matches(in: stringToParse as String, options: [], range: NSMakeRange(0, stringToParse.characters.count))
                if let match = matches.first {
                    let range = match.rangeAt(1)
                    if let swiftRange = rangeFromNSRange(nsRange: range, forString: stringToParse as String) {
                        name = stringToParse.substring(with: swiftRange)
                    }
                }
            } catch {
                //regex was bad!
            }
        return name
        }
    
}

