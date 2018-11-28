//
//  VNLanguage+Helper.swift
//
//
//  Created by vinsi on 11/21/18.
/
//

import Foundation
extension VNLanguages {
    static   func  getDefault()->VNLanguages{
        return .English
    }
    func isSupportedLanguage()->Bool{
        return true
    }
    
   public func localizedString(key: String) -> String
    {
        let selectedLanguage = self
        
        // Get the corresponding bundle path
        if let path = Bundle.main.path(forResource: selectedLanguage.getLanguageKey(), ofType: "lproj")
        {
            // Get the corresponding localized string.
            let languageBundle = Bundle(path: path)
            if let localizedString = languageBundle?.localizedString(forKey: key, value: "", table: nil)
            {
                return localizedString
            }
        }
        return ""
    }
    func isRightToLeft() -> Bool
    {
        switch self {
        case .Arabic:
            return true
        default:
            return false
        }
    }
    func isLeftToRight() -> Bool
    {
        return !isRightToLeft()
    }
     func setAppleLanguage() {
        let userdef = UserDefaults.standard
        userdef.set([self.getLanguageKey()], forKey: APPLE_LANGUAGE_KEY)
      //  userdef.setObject([lang,currentAppleLanguage()], forKey: APPLE_LANGUAGE_KEY)
        userdef.synchronize()
    }
   
}
