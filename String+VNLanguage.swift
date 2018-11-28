
//
//  String+VNLanaguage.swift

//
//  Created by vinsi on 11/21/18.

//

import Foundation
extension String {
    
    public func localize()->String{
       return VNLocalizerObject.currentLanguage.localizedString(key: self)
    }
    public func localizeWithValues(params:[CVarArg])->String{
        
        let text = String(format: NSLocalizedString(self,  comment: ""),arguments: params)
        return text
    }
}
