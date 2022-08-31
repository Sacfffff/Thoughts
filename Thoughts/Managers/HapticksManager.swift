//
//  HapticksManager.swift
//  
//
//  Created by Aleks Kravtsova on 31.08.22.
//

import Foundation
import UIKit

final class HapticksManager {
    static let shared  =  HapticksManager()
    
    private init(){}
    
    func vibrateForSelection(){
        let generator = UISelectionFeedbackGenerator()
        generator.prepare()
        generator.selectionChanged()
    }
    
    func vibrate(for type: UINotificationFeedbackGenerator.FeedbackType) {
        let generator = UINotificationFeedbackGenerator()
        generator.prepare()
        generator.notificationOccurred(type)
    }
}
