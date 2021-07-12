//
//  AddDataPopUpViewController.swift
//  Dreesha User
//
//  Created by Promatics on 18/05/21.
//

import UIKit

protocol QuantityData {
    func getDataValue(model: String, descriptn: String, quant: String, price: String, totalvat: String, toEdit: Bool )
}

class AddDataPopUpViewController: UIViewController {
    @IBOutlet weak var model_tf: SkyFloatingLabelTextField!
    @IBOutlet weak var descrip_TF: SkyFloatingLabelTextField!
    @IBOutlet weak var quantity_tf: SkyFloatingLabelTextField!
    @IBOutlet weak var Price_tf: SkyFloatingLabelTextField!
    @IBOutlet weak var totalVt_tf: SkyFloatingLabelTextField!
    var taskComplete = false
    var delegate: QuantityData?
    var toEdit = false
    var quantDetailEnterd = ["srNo": "","itemName": "", "description": "", "quantity": "", "price": "", "total_Price": ""]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(toEdit == true){
            setValue()
        }
        
    }
    
    func setValue(){
        model_tf.text = quantDetailEnterd["itemName"]
        descrip_TF.text = quantDetailEnterd["description"]
        quantity_tf.text = quantDetailEnterd["quantity"]
        Price_tf.text = quantDetailEnterd["price"]
        totalVt_tf.text = quantDetailEnterd["total_Price"]
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if taskComplete == true{
            delegate?.getDataValue(model: model_tf.text ?? "", descriptn: descrip_TF.text ?? "", quant: quantity_tf.text ?? "", price: Price_tf.text ?? "", totalvat: totalVt_tf.text ?? "", toEdit: toEdit)
        }
    }

    
     @IBAction func submit(_ sender: Any) {
        if(model_tf.text!.isEmpty){
            view.makeToast("Enter item name")
        }else if descrip_TF.text!.isEmpty{
            view.makeToast("Enter description")
        }else if quantity_tf.text!.isEmpty{
            view.makeToast("Enter quantity")
        }else if Price_tf.text!.isEmpty{
            view.makeToast("Enter price")
        }else if totalVt_tf.text!.isEmpty{
            view.makeToast("Enter total price")
        }else {
            taskComplete = true
            self.dismiss(animated: true, completion: nil)
        }
     }
    

}
