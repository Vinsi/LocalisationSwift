//
//  LocalizationApplicationDelegate.swift
//  TrackAndTrace
//
//  Created by vinsi on 11/22/18.
//  Copyright © 2018 Maqta Gateway. All rights reserved.
//

import Foundation
import UIKit
let SharedLangugeMGR:ILanguageManager = VNLocalizerObject
class MGButtonAlignable:UIButton{
    
    
}

class MGLocalizedButton: MGButtonAlignable {
    override func awakeFromNib() {
        super.awakeFromNib()
        
            if let label = titleLabel, let labelText = label.text {
                setTitle(labelText.localize(), for: .normal)
            }
    }
}

extension UATextField {
    override func awakeFromNib() {
        super.awakeFromNib()
        if SharedLangugeMGR.currentLanguage.isRightToLeft() && contentHorizontalAlignment == .left {
            //  if self.titleLabel?.textAlignment == .natural {
            self.contentHorizontalAlignment = .right
            self.textAlignment = .right
            //   }
        }
        else {
            self.contentHorizontalAlignment = .left
            self.textAlignment = .left
        }
    }
}
extension MGButtonAlignable{
    open override func awakeFromNib() {
        super.awakeFromNib()
        if SharedLangugeMGR.currentLanguage.isRightToLeft() {
            //  if self.titleLabel?.textAlignment == .natural {
            if contentHorizontalAlignment == .left {
                self.contentHorizontalAlignment = ContentHorizontalAlignment.right
            }
            if titleLabel?.textAlignment == .left {
                self.titleLabel?.textAlignment = .right
            }
            //   }
        }
        else {
            if contentHorizontalAlignment == .right {
                self.contentHorizontalAlignment = ContentHorizontalAlignment.left
            }
            if titleLabel?.textAlignment == .right {
                self.titleLabel?.textAlignment = .left
            }
        }
    }
}

extension UILabel {
    open override func awakeFromNib() {
        super.awakeFromNib()
        
        guard isLocalizedAlignment else {
            return
        }
        
        if SharedLangugeMGR.currentLanguage.isRightToLeft() && textAlignment == .left {
            //  if self.titleLabel?.textAlignment == .natural {
            textAlignment = .right
            //   }
        }
        else if textAlignment == .right {
            textAlignment = .left
        }
    }
}

extension UITextView{
    open override func awakeFromNib() {
        super.awakeFromNib()
        if SharedLangugeMGR.currentLanguage.isRightToLeft() {
           // if self.textAlignment == .natural {
                self.textAlignment = .right
           // }
        }
        else{
             self.textAlignment = .left
        }
    }
}
final class LocalizationApplicationDelegate: NSObject, ApplicationDelegate {
 
    
 
    
    func logoutUser() {
        
    }
    
    
    public var sematic:SemanticNotifier!
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        
        // Language Manager
        SharedLangugeMGR.initialize {
            let storyboard = UIStoryboard(name: "Main_iPhone", bundle: nil)
            
            let identifier = "root"
            //applicationNavigationController is Application Default Navigation Controller if let
            let applicationNavigationController = storyboard.instantiateViewController(withIdentifier: identifier)
            UIApplication.shared.keyWindow?.rootViewController = applicationNavigationController
            
        }
        sematic = SemanticNotifier (onSematicChange: { (option) in
            
            
            UIView.appearance().semanticContentAttribute = option
            UINavigationBar.appearance().semanticContentAttribute = option
            UITextView.appearance().semanticContentAttribute = option
            UIButton.appearance().semanticContentAttribute = option
            
            
            
        })
  
        return true
    }
    
}
