//
//  AddressViewController.swift
//  Dreesha User
//
//  Created by Promatics on 10/03/21.
//

import UIKit

class AddressViewController: UIViewController , UITableViewDelegate, UITableViewDataSource {
 
    //Mark Outlets
    @IBOutlet weak var Adresstableview: UITableView!
    
    //Mark Variables
    var AdressLabelArray = ["Home","Office","Office","Home","Office"]
    var viewModel = AddressViewModel()
    var iconClick = true
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        Adresstableview.delegate=self
        Adresstableview.dataSource=self
        Adresstableview.reloadData()
        self.hideKeyboardWhenTappedAround()
        hitApiAddressList()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "My Profile")
        hitApiAddressList()
    }
    
    //MARK: ACTIONS
    
    @IBAction func buttonTapped(_ sender: UIButton) {
        let vc = storyboard?.instantiateViewController(identifier: "AddAdressViewController") as! AddAdressViewController
        vc.comefrom = "edit"
        vc.FirstNameStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.firstName ?? ""
        vc.LastNameStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.lastName ?? ""
        vc.addressLine2 = viewModel.getAddressListData()?.addressDetails[sender.tag]?.addressLine2 ?? ""
        vc.addressLine1 = viewModel.getAddressListData()?.addressDetails[sender.tag]?.addressLine1 ?? ""
        vc.phoneCode = viewModel.getAddressListData()?.addressDetails[sender.tag]?.countryPhCode ?? ""
        vc.AddressTypeStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.addressType ?? ""
        vc.cityStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.city ?? ""
        vc.StateStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.state ?? ""
        vc.PincodeStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.zipCode ?? ""
        vc.PhoneNumStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.phoneNumber ?? ""
        vc.countryStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.country ?? ""
        vc.add_id = viewModel.getAddressListData()?.addressDetails[sender.tag]?.id ?? ""
        vc.AddressTypeStr = viewModel.getAddressListData()?.addressDetails[sender.tag]?.addressType ?? ""
        vc.landmarkVal = viewModel.getAddressListData()?.addressDetails[sender.tag]?.landmark ?? ""
        navigationController?.pushViewController(vc, animated: true)
        }

    @IBAction func AddnewAddressButton(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "AddAdressViewController") as! AddAdressViewController
        vc.comefrom = "add"
        navigationController?.pushViewController(vc, animated: true)
    }
    
    
    //MARK: Delete Button Action
    @IBAction func DeletebuttonTapped(_ sender: UIButton) {
        deleteAddress(addId: viewModel.getAddressListData()?.addressDetails[sender.tag]?.id ?? "")
    }
    
    @IBAction func DefaultbuttonTapped(_ sender: UIButton) {
        if(viewModel.getAddressListData()?.addressDetails[sender.tag]?.isDefault == "no") {
        
            defaultAddress(addId: viewModel.getAddressListData()?.addressDetails[sender.tag]?.id ?? "", DefaultStrVal: "yes")}
          else{
            defaultAddress(addId: viewModel.getAddressListData()?.addressDetails[sender.tag]?.id ?? "", DefaultStrVal: "no")}
            }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.viewModel.getAddressListData()?.addressDetails.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "Address Cell") as! AddressTableViewCell
        cell.AdrsLabl.text = "\(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.firstName ?? "") \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.lastName ?? "")"
        cell.contactNo.text = "\(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.countryPhCode ?? "")-\(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.phoneNumber ?? "")"
        cell.Adrsdata.text =  "  \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.addressLine1 ?? ""), \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.addressLine2 ?? ""), \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.city ?? ""), \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.state ?? ""), \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.country ?? ""), \(self.viewModel.getAddressListData()?.addressDetails[indexPath.row]?.zipCode ?? "")"
        cell.EditAddressButton.tag = indexPath.row
        cell.EditAddressButton.addTarget( self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
        cell.DeleteAdressButtomn.tag = indexPath.row
        cell.DeleteAdressButtomn.addTarget(self, action: #selector(DeletebuttonTapped(_:)), for: .touchUpInside)
        cell.ToggleDefaultBtn.tag = indexPath.row
        cell.ToggleDefaultBtn.addTarget(self, action: #selector(DefaultbuttonTapped(_:)), for: .touchUpInside)

        if viewModel.getAddressListData()?.addressDetails[indexPath.row]?.isDefault ?? "" == "no" {
            cell.ToggleDefaultBtn.isOn = false
            
        }else{
            cell.ToggleDefaultBtn.isOn = true
        }
        
        
            return cell
        
    }
    
}

//MARK: API CALL
extension AddressViewController{
        func hitApiAddressList(){
            
            Indicator.shared.showProgressView(self.parent?.view ?? self.view)
           
            viewModel.apiAddressList(){(isSuccess , message) in
                Indicator.shared.hideProgressView()
                if isSuccess{
                    self.Adresstableview.reloadData()
                }else{
                    self.view.makeToast(message , position : .center)
                }
            }
        }
    
    func deleteAddress(addId : String){
        viewModel.hitDeleteAddress(addressId: addId) { (isSuccess, message) in
            if isSuccess{
                self.view.makeToast(message , position : .center)
                self.hitApiAddressList()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func defaultAddress(addId : String , DefaultStrVal : String){
        viewModel.hitDefaultAddress(addressId: addId, DefaultAddress: DefaultStrVal) { (isSuccess, message) in
            if isSuccess{
               
                self.hitApiAddressList()
                
            }else{
                
            }
        }
    }
 }
