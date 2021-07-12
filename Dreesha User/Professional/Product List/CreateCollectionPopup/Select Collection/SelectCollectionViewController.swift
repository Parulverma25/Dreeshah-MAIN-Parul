//
//  SelectCollectionViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit
import iOSDropDown
class SelectCollectionViewController: UIViewController {

    //MARK: Outlets
    @IBOutlet weak var SelectCollection: DropDown!
    //MARK: Variables
    var viewModel = SelectCollectionViewModel()
    var productIDVal = ""
    var collectionID = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SelectCollection.didSelect { (name, index, id) in
            self.collectionID = self.viewModel.CollIDModel?.data[index]?.id ?? ""
        }
        
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
//        setBackWithTitle(titleVal: "Add Product")
        CollectionList()
    }
    
    //MARK: Actions
    
    @IBAction func CrossBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func CreateNewCollection(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "CreateCollectionPopUpViewController") as! CreateCollectionPopUpViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.ProductIdStrVal = productIDVal
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func SubmitBtn(_ sender: UIButton) {
        AddProducttoCollection()
    }
    
}
//MARK:- API CALL
extension SelectCollectionViewController{

    func AddProducttoCollection(){
        viewModel.hitAddCollection(CollectionID: collectionID, Product_id: productIDVal) { (isSuccess, message) in
            if isSuccess{
                self.dismiss(animated: true, completion: nil)
                self.view.makeToast("Added to Collection" , position : .center)
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func CollectionList(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitCollectionIDs{ (isSuccess, message) in

            Indicator.shared.hideProgressView()
            if isSuccess{
                let Collection = self.viewModel.CollIDModel?.data.map({$0?.collectionName ?? ""})
                
                self.SelectCollection.optionArray = Collection ?? []
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    
}
