//
//  Constants.swift
//
//  Created by vinsi on 11/21/18.
//
//

import Foundation

enum VNLanguages : Int ,CaseIterable {
    case Arabic  = 0
    case English = 1
   
   
   
   static  func getAll()->[VNLanguages]{
       return VNLanguages.allCases
    }
    func getLanguageKey()->String{
        return  ["ar",
                 "en"
        ][self.rawValue]
    }
    func getLanguageString()->String{
        return  ["Arabic",
                 "English"
                ][self.rawValue]
    }
    public static func  getVNLanguageFromKey(languageKey:String)->VNLanguages?{
        
        let langs = VNLanguages.getAll().filter { (language) -> Bool in
            language.getLanguageKey() == languageKey
        }
        if langs.count == 0 {
            return nil
        }
        return langs[0]
        
        
    }
 
}
let APPLE_LANGUAGE_KEY         = "AppleLanguages"
let VN_LANGUAGE_IS_RTLKEY      = "VNL_IS_LNG_RTL"
let VN_LANGUAGE_USR_SELECTED   = "VNL_LNG_SELECTED"
extension Notification.Name {
    static let forceSematic  = Notification.Name("forceSematic")
    
}



