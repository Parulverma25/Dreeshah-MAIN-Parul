//
//  Alert.swift
//  BubbleBud
//
//  Created by Apple on 15/07/19.
//  Copyright © 2019 Promatics. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func showAlertWithAction(Title: String , Message: String , ButtonTitle: String ,outputBlock:@escaping ()->Void) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        
        alert.view.tintColor = UIColor.blue
        
        alert.addAction(UIAlertAction(title: ButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
            
            outputBlock()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertWithActionOkandCancel(Title: String , Message: String , OkButtonTitle: String ,CancelButtonTitle: String ,outputBlock:@escaping ()->Void) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.blue
        alert.addAction(UIAlertAction(title: CancelButtonTitle, style: .default, handler: nil))
        alert.addAction(UIAlertAction(title: OkButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
            
            outputBlock()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlertWithActionsOkandCancel(Title: String , Message: String , OkButtonTitle: String, OkButtonButputBlock:@escaping ()->Void, CancelButtonTitle: String ,CancelButtonButputBlock:@escaping ()->Void) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = #colorLiteral(red: 0.0862745098, green: 0.4705882353, blue: 0.6470588235, alpha: 1)
        alert.addAction(UIAlertAction(title: CancelButtonTitle, style: .destructive, handler: { (action: UIAlertAction!) in
            
            CancelButtonButputBlock()
            
        }))
        alert.addAction(UIAlertAction(title: OkButtonTitle, style: .default, handler: { (action: UIAlertAction!) in
            
            OkButtonButputBlock()
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showAlert(Title: String , Message: String , ButtonTitle: String) {
        
        let alert = UIAlertController(title: Title, message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.blue
        alert.addAction(UIAlertAction(title: ButtonTitle, style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func showDefaultAlert(Message: String) {
        
        let alert = UIAlertController(title: "Dreeshah", message: Message, preferredStyle: UIAlertController.Style.alert)
        alert.view.tintColor = UIColor.blue
        alert.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

