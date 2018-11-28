//
//  SemanticNotifier.swift
//  TrackAndTrace
//
//  Created by vinsi on 11/22/18.
//  Copyright © 2018 Maqta Gateway. All rights reserved.
//

import Foundation
class SemanticNotifier {
    private var callback:((_ sematic:UISemanticContentAttribute)->Void)!
    init() {
        
    }
  convenience  init(onSematicChange:@escaping (_ sematic:UISemanticContentAttribute)->Void) {
    
    self.init()
        let notificationCenter = NotificationCenter.default
        notificationCenter.addObserver(self, selector: #selector(self.onNotification(notification:)), name: NSNotification.Name.forceSematic, object: nil)
        self.callback = onSematicChange
    }
 

    @objc private func onNotification(notification:Notification){
        
        let object =  notification.object as! UISemanticContentAttribute
         self.callback(object)
    }
        
}
