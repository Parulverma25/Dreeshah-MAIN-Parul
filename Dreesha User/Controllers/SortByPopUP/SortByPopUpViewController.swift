//
//  SortByPopUpViewController.swift
//  Dreesha User
//
//  Created by promatics on 2/21/1400 AP.
//

import UIKit

class SortByPopUpViewController: UIViewController {
    
    //MARK:- Outlets
    
    @IBOutlet weak var radioNearFar: UIButton!
    
    @IBOutlet weak var radioLow2High: UIButton!
    @IBOutlet weak var radioHigh2Low: UIButton!
    
    var radioBtnNear = false
    var radioLowHigh = false
    var radioHighLow = false
    
    typealias sortBy = (_ infoToReturn :String) ->()
    var completionBlock : sortBy?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
    }
    
    //MARK:- IBActions
    
    @IBAction func tapCross(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func tapNearFar(_ sender: Any) {
        
        if radioBtnNear == false{
            radioBtnNear = true
            radioHighLow = false
            radioLowHigh = false
            radioNearFar.setImage(UIImage(named: "radio On"), for: .normal)
            radioLow2High.setImage(UIImage(named: "radio Off"), for: .normal)
            radioHigh2Low.setImage(UIImage(named: "radio Off"), for: .normal)
            
        }else{
            

        }
        
    }
    
    @IBAction func tapLow2High(_ sender: Any) {
        
        if radioLowHigh == false{
            radioLowHigh = true
            radioBtnNear = false
            radioHighLow = false
            radioLow2High.setImage(UIImage(named: "radio On"), for: .normal)
            radioNearFar.setImage(UIImage(named: "radio Off"), for: .normal)
            radioHigh2Low.setImage(UIImage(named: "radio Off"), for: .normal)
            guard let cb = completionBlock else {return}
            cb("asc")

        }else{
            
        }
    }
    
    @IBAction func tapHigh2Low(_ sender: Any) {
        
        if radioHighLow == false{
            radioHighLow = true
            radioBtnNear = false
            radioLowHigh = false
            radioHigh2Low.setImage(UIImage(named: "radio On"), for: .normal)
            radioLow2High.setImage(UIImage(named: "radio Off"), for: .normal)
            radioNearFar.setImage(UIImage(named: "radio Off"), for: .normal)
            guard let cb = completionBlock else {return}
            cb("desc")
        }else{
            
        }
    }
    
}
