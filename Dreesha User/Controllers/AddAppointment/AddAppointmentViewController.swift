//
//  AddAppointmentViewController.swift
//  Dreesha User
//
//  Created by Promatics on 28/04/21.
//

import UIKit
import WWCalendarTimeSelector
class AddAppointmentViewController: UIViewController, WWCalendarTimeSelectorProtocol {

    //MARK: Outlets
    @IBOutlet weak var RequestIdVal: UILabel!
    @IBOutlet weak var NameTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var DateTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var TimeTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var RequestDtlTxtFld: UITextView!
    @IBOutlet weak var LocationTxtFld: SkyFloatingLabelTextField!
    @IBOutlet weak var SubjectValLbl: UILabel!
    @IBOutlet weak var chooseDate: UIButton!
    @IBOutlet weak var requestView: SetView!
    
    
    //MARK: VARIABLES
    var viewModel = AddAppontmentViewModel()
    var ServiceIdStr = ""
    var subject = ""
    var rqstId = ""
    var date = ""
    var time = ""
    var professionalId = ""
    var pickerType = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.navigationBar.isHidden = false

        requestView.layer.cornerRadius = 4
        requestView.layer.borderWidth = 1
        requestView.layer.borderColor = #colorLiteral(red: 0.6666666865, green: 0.6666666865, blue: 0.6666666865, alpha: 1)
    }
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Appointment")
        
        SubjectValLbl.text = subject
        RequestIdVal.text = rqstId
    }
    
    
    @IBAction func SubmitBtnAc(_ sender: UIButton) {
        
        if self.NameTxtFld.text?.replacingOccurrences(of: " ", with: "") == "" {
            self.view.makeToast("Please enter Name" , position : .center)
        }
        else if self.DateTxtFld.text == "" {
            self.view.makeToast("Please enter Date" , position : .center)
        }else if self.LocationTxtFld.text == "" {
            self.view.makeToast("Please enter Location" , position : .center)
        }else{
            AddAppointment()
        }
        
       
        
    }
   
    @IBAction func tapChooseDate(_ sender: Any) {
        
        
        //pickerType = "date"
        let selector = WWCalendarTimeSelector.instantiate()
        
        showDateTimeCalander(selector: selector)
        
        
       // selector.optionLayoutTopPanelHeight = 28
        selector.delegate = self
        
    }
    
    @IBAction func tapChooseTime(_ sender: Any) {
        
        pickerType = "time"
        
        let selector = WWCalendarTimeSelector.instantiate()
        
        showTimeCalander(selector: selector)
        
        selector.delegate = self
       
    }
    
    func WWCalendarTimeSelectorDone(_ selector: WWCalendarTimeSelector, date: Date) {
        
      
            let newDate = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "yyyy-MM-dd h:mm a")
            
            
        self.date = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "yyyy-MM-dd")
        
        self.time = Singleton.sharedInstance.dateFormatChangeLocal(date: String(describing: date), oldFormat: "yyyy-MM-dd HH:mm:ss Z", newFormat: "h:mm a")
            
            self.DateTxtFld.text = newDate
        
       
    }
    
    
    @IBAction func CancelBtnAct(_ sender: UIButton) {
        
        navigationController?.popViewController(animated: true)
    }
    
}
//MARK:- API CALL
extension AddAppointmentViewController {
    func AddAppointment(){
        
        viewModel.hitaddAppointment(Name: self.NameTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "" , RequestID: generatenumber(length: 5), ServiceID: ServiceIdStr, Subject: self.SubjectValLbl.text?.replacingOccurrences(of: " ", with: "") ?? "" , Location: self.LocationTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "" , ReqDtl: self.RequestDtlTxtFld.text?.replacingOccurrences(of: " ", with: "") ?? "" , Time: self.time , Date: self.date, professionalId: self.professionalId )
            { (isSucess, message) in
            if isSucess{
                self.showAlertWithAction(Title: "Dreeshah", Message: message, ButtonTitle: "Ok") {
                    self.navigationController?.popViewController(animated: true)
                }
            }
            else{
                self.showDefaultAlert(Message: message)
            }
        }
    }
}
