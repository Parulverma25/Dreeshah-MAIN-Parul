//
//  CreateCollectionPopUpViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit

class CreateCollectionPopUpViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var TopTitleLabel: UILabel!
    
    //MARK: Variables
    var viewModel = CreatenewCollectionViewModel()
    var ProductIdStrVal = ""
    
    @IBOutlet weak var TextFieldCollection: SkyFloatingLabelTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
//MARK: ACtions
    func popViewControllerss(popViews: Int, animated: Bool = true) {
        if self.navigationController!.viewControllers.count > popViews
        {
            let vc = self.navigationController!.viewControllers[self.navigationController!.viewControllers.count - popViews - 1]
             self.navigationController?.popToViewController(vc, animated: animated)
        }
    }
    
    
    @IBAction func SubmitBtnAct(_ sender: UIButton) {
        AddProducttoCollection()
    }
    
    @IBAction func CrossBtnAct(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
}
//MARK:- API CALL
extension CreateCollectionPopUpViewController{

    func AddProducttoCollection(){
        viewModel.hitAddCollection(name: TextFieldCollection.text ?? "" , Product_id: ProductIdStrVal) { (isSuccess, message) in
            if isSuccess{
                self.showAlertWithAction(Title: "Dreeshah", Message: "Collection Created!", ButtonTitle: "OK") {
//                    self.popViewControllerss(popViews: 2)
                    self.presentingViewController?.presentingViewController?.dismiss(animated: true, completion: nil)
                }
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
}
