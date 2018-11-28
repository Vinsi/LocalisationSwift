//
//  VNLocalizer.swift
//
//  Created by vinsi on 11/21/18.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import Foundation
import UIKit

// Supported languages.
// Add your specific sup@objc @objc ported languaages here.



let VNLocalizerObject = VNLocalizer()
protocol ILanguageManager :class{

    var currentLanguage:VNLanguages { get set}
     func initialize(callBackonReInitialise:@escaping ()->Void)
}
class VNLocalizer : ILanguageManager{
    typealias LangType = VNLanguages
    private var callBackonReInitialise:(()->Void)!
    func initialize(callBackonReInitialise:@escaping ()->Void){
        self.callBackonReInitialise = callBackonReInitialise
        self.doTheSwizzling()
        self.initalizeSelectedLanguage()
     }
    private var  __currentLanguage:VNLanguages!
    var currentLanguage:VNLanguages {
        get {
            return __currentLanguage
        }
        set {
            __currentLanguage =  newValue
        
            let userDefaults = UserDefaults.standard
            
            //check if the desired language is supported
            if __currentLanguage.isSupportedLanguage()
            {
                userDefaults.set( __currentLanguage.getLanguageKey(), forKey: VN_LANGUAGE_USR_SELECTED)
                
            }
            else
            {
                
                // if the desired language is not supported, set selectedLanguage to nil.
                userDefaults.set(VNLanguages.getDefault().getLanguageKey(), forKey: VN_LANGUAGE_USR_SELECTED)
            }
          
         
            userDefaults.set(__currentLanguage.isRightToLeft(), forKey: VN_LANGUAGE_IS_RTLKEY)
              __currentLanguage.setAppleLanguage()
         
                self.forceSematic(option: __currentLanguage.isLeftToRight() ? .forceLeftToRight:.forceRightToLeft , initializeCallback:self.callBackonReInitialise )
           
          
            
        }
    }
    
    func isSupportedLanguage(language:String)->Bool{
     
        return   VNLanguages.getVNLanguageFromKey(languageKey: language) == nil ? false : true
    }
    @objc private func doTheSwizzling() {
        // 1
        
        MethodSwizzleGivenClassName(cls: Bundle.self, originalSelector: #selector(Bundle.localizedString(forKey:value:table:)), overrideSelector:    #selector(Bundle.specialLocalizedStringForKey(key:value:table:))
        )
    }
    
    
    /// This method forces the app to change its orienation to right to left orientation, this should be used in
    /// languages like arabic, Hebrew, etc..
    ///
    /// if the parameters is passed, it will go back to the root view controller and change its orientation.
    ///
    /// else you must do it manually or in the AppDelegate didFinishLaunchingWithOptions
    /// - Parameters:
    ///   - storyboard: The storyboard from which the view controller originated.
    ///   - identifier: Root viewController identifier
    
    @available(iOS 9.0, *)
    public  func forceSematic(option:UISemanticContentAttribute , initializeCallback:()->Void)
    {
        NotificationCenter.default.post(name: .forceSematic ,object: option)
//        UIView.appearance().semanticContentAttribute = option
//        UINavigationBar.appearance().semanticContentAttribute = option
        initializeCallback()
    }
   
    
    public func initalizeSelectedLanguage()
    {
        // Get selected language from user defaults.
        let userDefaults = UserDefaults.standard
        let sLanguage:String? = userDefaults.value(forKey: VN_LANGUAGE_USR_SELECTED) as? String
        var selectedLanguage:VNLanguages? = VNLanguages.getVNLanguageFromKey( languageKey: sLanguage ?? "")
        
        // if the language is not defined in user defaults yet...
        if selectedLanguage == nil
        {
            // Get the system language.
            if let userLanguages: [String] = userDefaults.object(forKey: APPLE_LANGUAGE_KEY) as? [String]
            {
                let systemLanguage: String = userLanguages[0]
                
                selectedLanguage = VNLanguages.getVNLanguageFromKey( languageKey: sLanguage ?? "")
                
            }
        }
        VNLocalizerObject.currentLanguage = selectedLanguage ?? VNLanguages.getDefault()
        
    
        
    }
    
    
    
}






