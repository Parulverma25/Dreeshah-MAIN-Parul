//
//  GeneralDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 22/03/21.
//

import UIKit
import AnimatedField
import SBCardPopup


class CertificateCell: UITableViewCell {
    
    @IBOutlet weak var imageBtnOutlet: SetButton!
    @IBOutlet weak var addBtnOutlet: SetButton!
    @IBOutlet weak var dateLabel: UILabel!
    
    
    var onImage : (() -> Void)!
    var onAdd : (() -> Void)!
    var onCalender : (() -> Void)!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    @IBAction func imageBtn(_ sender: Any) {
        onImage()
    }
    
    @IBAction func addBtn(_ sender: Any) {
        onAdd()
    }
    
    @IBAction func calenderBtn(_ sender: Any) {
        onCalender()
    }
}


class GeneralDetailViewController: UIViewController, TypeAndCategoryList, SelectDate {
    func listData(name: String, ListType: String, id: String?){
        
    }

    func onDate(date: String) {
        if dateArray.indices.contains(selectedCell) {
            dateArray[selectedCell] = date
        } else {
            dateArray.append(date)
        }
        tableView.reloadData()
    }
    
    
    func listData(name: String, isType: Bool, id: String?) {
        if isType {
            lowerBranchType.text = name
            lowerBranchType.alpha = 1.0
            upperBranchType.isHidden = false
            typeId = id
            categoryNameArray.removeAll()
            categoryidNameArray.removeAll()
            categoryId = ""
            branchCategory(id: id!)
            if lowerBranchCategory.text != "Branch Category" {
                lowerBranchCategory.text = ""
            }
            
        } else {
            print(id as Any)
            categoryId = id
            upperBranchCategory.isHidden = false
            lowerBranchCategory.alpha = 1.0
            lowerBranchCategory.text = name
        }
    }
    
    

    @IBOutlet weak var firstNameView: AnimatedField!
    @IBOutlet weak var lastNameView: AnimatedField!
    @IBOutlet weak var emailView: AnimatedField!
    @IBOutlet weak var passwordView: AnimatedField!
    @IBOutlet weak var confirmPasswordView: AnimatedField!
    @IBOutlet weak var branchNameEnglishView: AnimatedField!
    @IBOutlet weak var branchNameArabicView: AnimatedField!
    @IBOutlet weak var branchDescriptionView: AnimatedField!
    
    
    @IBOutlet weak var upperBranchType: UILabel!
    @IBOutlet weak var lowerBranchType: UILabel!
    
    @IBOutlet weak var lowerBranchCategory: UILabel!
    @IBOutlet weak var upperBranchCategory: UILabel!
    
    @IBOutlet weak var passBtn: UIButton!
    @IBOutlet weak var confirmBtn: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var viewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    @IBOutlet weak var bottomTableHeight: NSLayoutConstraint!
    @IBOutlet weak var firstNameTopConstaint: NSLayoutConstraint!
    
    @IBOutlet weak var profileImageView: SetImage!
    @IBOutlet weak var profileImgBtn: SetButton!
    @IBOutlet weak var profSignUPHeading: UILabel!
    
    
    var typeNameArray: [String] = []
    var typeidNameArray: [String] = []
    var categoryNameArray: [String] = []
    var categoryidNameArray: [String] = []
    var typeId: String!
    var categoryId: String!
    
    
    var dateArray : [String] = []
    var certificateArray : [UIImage] = []
    var certificateCount = 1
    var selectedCell = 0
    var certificateDataArray : [String] = []
    var certificateAndRewardArray : [[String : String]] = [[:]]
    
    
    var imageData = Data()
    var imagePicker = ImagePickerViewControler()
    
    var shownImage : UIImage!
    
    var passClick = true
    var confirmClick = true
    
    var format = AnimatedFieldFormat()

    var dataGeneral = ProfessionalSignUpdata()
    
    var viewModel = SignupViewModel()
    var typeModel = BranchTypeAndCategoryViewModel()
    
    var viewModelP = PersonalInfoViewModel()
    var isEdit: Bool! = false
    
    var isBranchAdd = false
    
    var profileImageData = Data()
    var isProfileImage = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        emailView.keyboardType = .emailAddress
        
        upperBranchType.isHidden = true
        upperBranchCategory.isHidden = true
        
        passwordView.isSecure = true
        confirmPasswordView.isSecure = true
        
        firstNameView.placeholder = "First Name*"
        lastNameView.placeholder = "LastName*"
        emailView.placeholder = "Email Address*"
        //emailView.type = .email
        passwordView.placeholder = "Password"
        confirmPasswordView.placeholder = "Confirm Password"
        branchNameEnglishView.placeholder = "Company Name (in English)*"
        branchNameArabicView.placeholder = "Company Name (in Arabic)*"
        branchDescriptionView.placeholder = "Company Description"

        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        //format.alertColor = .red
        //format.counterColor = .blue
        format.titleColor = .black
        
        lastNameView.format = format
        firstNameView.format = format
        emailView.format = format
        passwordView.format = format
        confirmPasswordView.format = format
        branchDescriptionView.format = format
        branchNameEnglishView.format = format
        branchNameArabicView.format = format
        //branchDescriptionView.type = .multiline
        branchType()
        
        if isEdit {
            firstNameTopConstaint.constant = 16
            profileImageView.isHidden = true
            profileImgBtn.isHidden = true
            firstNameView.text = viewModelP.dataModel?.data?.firstName
            lastNameView.text = viewModelP.dataModel?.data?.lastName
            emailView.text = viewModelP.dataModel?.data?.email
            passwordView.text = viewModelP.dataModel?.data?.password
            confirmPasswordView.text = viewModelP.dataModel?.data?.password
            branchNameEnglishView.text = viewModelP.dataModel?.data?.branchNameEn
            branchNameArabicView.text = viewModelP.dataModel?.data?.branchNameAr
            branchDescriptionView.text = viewModelP.dataModel?.data?.branchBrief
        }else if isBranchAdd{
            profSignUPHeading.isHidden = true
            topImageHeight.constant = 60
            topImage.isHidden = true
            firstNameTopConstaint.constant = 150
            profileImageView.isHidden = false
            profileImgBtn.isHidden = false
        }else{
            profSignUPHeading.isHidden = false
            firstNameTopConstaint.constant = 16
            profileImageView.isHidden = true
            profileImgBtn.isHidden = true
            
        }
    }
   

    
    
    
    
    @IBAction func branchTypeBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
        vc.isType = true
        vc.delegate = self
        vc.name = typeNameArray
        vc.id = typeidNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func branchCategoryBtn(_ sender: Any) {
        if categoryNameArray.isEmpty {
            self.view.makeToast("No category found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "BranchTypeAndCategoryPopUpViewController") as! BranchTypeAndCategoryPopUpViewController
            vc.isType = false
            vc.delegate = self
            vc.name = categoryNameArray
            vc.id = categoryidNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    @IBAction func tapProfileImgBtn(_ sender: Any) {
        self.imagePicker.imagePickerDelegete = self
        isProfileImage = true
        imagePicker.showImagePicker(viewController: self)
    }
    
    func branchType() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchType { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            print(message)
            if isSuccess {
                self.typeNameArray = (self.typeModel.typeModelData?.data?.map({$0.name ?? ""}))!
                self.typeidNameArray = (self.typeModel.typeModelData?.data?.map({$0.id ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func branchCategory(id: String) {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        typeModel.hitBranchCategory(typeId: id) { (isSuccess, message) in
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.categoryNameArray = (self.typeModel.categoryModel?.data?.map({$0.name ?? ""}))!
                self.categoryidNameArray = (self.typeModel.categoryModel?.data?.map({$0.id ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func passEyeBtn(_ sender: Any) {
        if(passClick == true) {
            passwordView.isSecure = false
            passBtn.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            passwordView.isSecure = true
            passBtn.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        passClick = !passClick
    }
    
    @IBAction func confirmPassEyeBtn(_ sender: Any) {
        if(confirmClick == true) {
            confirmPasswordView.isSecure = false
            confirmBtn.setImage(UIImage(named: "Pass On") ,for: .normal)
        } else {
            confirmPasswordView.isSecure = true
            confirmBtn.setImage(UIImage(named: "Pass Off"), for: .normal)
        }
        confirmClick = !confirmClick
    }
    
    @IBAction func continueBtn(_ sender: Any) {
        
       print(categoryId as Any)
        print(typeId as Any)
        print(certificateArray)
        print(certificateDataArray)
        print(dateArray)
        print(certificateAndRewardArray)
        
       
        
        if CurrentSession.shared.isProfesstionalSignUp || isBranchAdd{

             if (self.dataGeneral.branchProfile ?? "" == "") && !(profileImageView.isHidden){
                self.view.makeToast("Please upload profile image")
            }
            else if self.firstNameView.text == "" {
                self.view.makeToast("Please Enter First Name")
            } else if self.lastNameView.text == "" {
                self.view.makeToast("Please Enter Last Name")
            }  else if self.emailView.text == "" {
                self.view.makeToast("Please Enter Email")
            }  else if !(self.emailView.text?.isValidEmail() ?? false) {
                self.view.makeToast("Please Enter valid email")
            } else if self.passwordView.text == "" {
                self.view.makeToast("Please Enter Password")
            } else if self.passwordView.text?.count ?? 0 < 8 {
                self.view.makeToast("Password cannot be less than 8 characters")
            }else if !(self.passwordView.text?.isValidPassword() ?? false) {
                self.view.makeToast("Please enter valid Password")
            } else if self.confirmPasswordView.text == "" {
                self.view.makeToast("Please Enter Confirm Password")
            }else if (self.passwordView.text != self.confirmPasswordView.text) {
                self.view.makeToast("Confirm Password Should be same as Password")
            }    else if self.branchNameEnglishView.text == "" {
                self.view.makeToast("Please Enter Company Name")
            }  else if self.branchNameArabicView.text == "" {
                self.view.makeToast("Please Enter Company Name in Arabic")
            }  else if !(Validation().validOnlyArabic(arabicTextField: self.branchNameArabicView.text ?? "")){
                self.view.makeToast("Please Enter Company Name in Arabic")
            }else if lowerBranchType.text == "Company Type" {
                self.view.makeToast("Please Select Company Type")
            }  else if lowerBranchCategory.text == "Company Category" || lowerBranchCategory.text == "" {
                self.view.makeToast("Please Select Company Category")
            }  else if self.branchDescriptionView.text == "" {
                self.view.makeToast("Please Enter Company Description")
            }   else if certificateArray.isEmpty || dateArray.isEmpty || certificateDataArray.isEmpty {
                if certificateArray.isEmpty || certificateDataArray.isEmpty {
                    self.view.makeToast("Please Select Certificate & Reward")
                } else {
                    self.view.makeToast("Please Select Date")
                }
            } else if certificateDataArray.count == dateArray.count {
                self.addParam()
                for i in 0..<certificateDataArray.count {
                    if certificateAndRewardArray.indices.contains(i) {
                        certificateAndRewardArray[i] = ["image" : certificateDataArray[i], "date" : dateArray[i]]
                    } else {
                        certificateAndRewardArray.insert(["image" : certificateDataArray[i], "date" : dateArray[i]], at: i)
                    }
            }

                self.dataGeneral.certificateAward = certificateAndRewardArray
                print(self.dataGeneral.certificateAward)

                let vc = storyboard?.instantiateViewController(identifier: "AddressDetailViewController") as! AddressDetailViewController
                vc.dataAddress = self.dataGeneral
                vc.isBranchAdd = self.isBranchAdd
                self.navigationController?.pushViewController(vc, animated: true)


            } else if certificateDataArray.count > dateArray.count {

                self.addParam()

                for i in 0..<dateArray.count {
                    if certificateAndRewardArray.indices.contains(i) {
                        certificateAndRewardArray[i] = ["image" : certificateDataArray[i], "date" : dateArray[i]]
                    } else {
                        certificateAndRewardArray.insert(["image" : certificateDataArray[i], "date" : dateArray[i]], at: i)
                    }
                }
                self.dataGeneral.certificateAward = self.certificateAndRewardArray

                self.showAlertWithActionsOkandCancel(Title: "Alert", Message: "You Don't Choose date. Press Choose to select date of last certificate or Press Continue for ignore last date ", OkButtonTitle: "Continue", OkButtonButputBlock: {

                    let vc = self.storyboard?.instantiateViewController(identifier: "AddressDetailViewController") as! AddressDetailViewController
                   // vc.dataAddress = self.dataGeneral
                   // vc.isBranchAdd = self.isBranchAdd
                    self.navigationController?.pushViewController(vc, animated: true)

               }, CancelButtonTitle: "Choose") {
                    return
                }
                print(self.dataGeneral.certificateAward)
            } else {

                self.addParam()

                for i in 0..<certificateDataArray.count {
                    if certificateAndRewardArray.indices.contains(i) {
                        certificateAndRewardArray[i] = ["image" : certificateDataArray[i], "date" : dateArray[i]]
                    } else {
                        certificateAndRewardArray.insert(["image" : certificateDataArray[i], "date" : dateArray[i]], at: i)
                    }
                }

                self.dataGeneral.certificateAward = self.certificateAndRewardArray

                self.showAlertWithActionsOkandCancel(Title: "Alert", Message: "You Don't Choose Certificate. Press Choose to select Certificate of last date  or Press Continue for ignore last certificate ", OkButtonTitle: "Continue", OkButtonButputBlock: {

                    let vc = self.storyboard?.instantiateViewController(identifier: "AddressDetailViewController") as! AddressDetailViewController
                    vc.dataAddress = self.dataGeneral
                    vc.isBranchAdd = self.isBranchAdd
                    self.navigationController?.pushViewController(vc, animated: true)

                }, CancelButtonTitle: "Choose") {
                    return
                }
                print(self.dataGeneral.certificateAward)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
    }
    
//    override func viewWillDisappear(_ animated: Bool) {
//        navigationController?.isNavigationBarHidden = false
//    }
    
    override func viewWillAppear(_ animated: Bool) {
//        if CurrentSession.shared.isProfesstionalSignUp {
//            navigationController?.isNavigationBarHidden = true
//        } else {
//            setBackWithTitle(titleVal : "Personal Information")
//        }
        navigationController?.navigationBar.isHidden = false
        setBackWithTitle(titleVal : "Personal Information")
    }
 
    
    func addParam() {
        self.dataGeneral.firstName = firstNameView.text!
        self.dataGeneral.lastName = lastNameView.text!
        self.dataGeneral.email = emailView.text!
        self.dataGeneral.password = passwordView.text!
        self.dataGeneral.branchNameEn = branchNameEnglishView.text!
        self.dataGeneral.branchNameAr = branchNameArabicView.text!
        self.dataGeneral.branchTypeId = typeId
        self.dataGeneral.branchCategoryId = categoryId
        self.dataGeneral.branchBrief = branchDescriptionView.text!
    }
    
}


extension GeneralDetailViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
        if isProfileImage{
            profileImageData = img.jpegData(compressionQuality: 0.6)!
            self.profileImageView.image = img
            uploadProfileImage()
        }else{
            
            print(self.certificateDataArray.count)
            
            imageData = img.jpegData(compressionQuality: 0.6)!
            uploadImage()
            self.shownImage = img
        }
        

    }
    
    
    func showPic() {
        if self.certificateArray.indices.contains(selectedCell) {
            self.certificateArray[selectedCell] = self.shownImage
        } else {
            self.certificateArray.append(self.shownImage)
        }
        print(self.certificateDataArray)
        tableView.reloadData()
    }
    
    func uploadImage() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUploadImage(imageData: imageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            if isSuccess {
                if self.certificateDataArray.indices.contains(self.selectedCell) {
                    self.certificateDataArray[self.selectedCell] = (self.viewModel.imageData?.data)!
                } else {
                    self.certificateDataArray.append((self.viewModel.imageData?.data)!)
                }
                self.showPic()
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    func uploadProfileImage(){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.apiUploadProfileImage(imageData: profileImageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message, data) in
            if isSuccess{
                self.dataGeneral.branchProfile = (data as? [String : AnyObject])?["data"] as? String ?? ""
            }else{
                self.view.makeToast(message)
            }
        }
    }
    
    
}



//MARK:- Table View Delegates

extension GeneralDetailViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return certificateCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CertificateCell

        indexPath.row == 0 ? cell.addBtnOutlet.setImage(UIImage(named: "plus 6"), for: .normal) : cell.addBtnOutlet.setImage(UIImage(named: "minus-bt"), for: .normal)
        
        cell.dateLabel.text = "Choose Date"
        cell.dateLabel.alpha = 0.3
        cell.imageBtnOutlet.setImage(UIImage(named: "cloud-computing 1"), for: .normal)
        
        if dateArray.indices.contains(indexPath.row) {
            cell.dateLabel.text = dateArray[indexPath.row]
            cell.dateLabel.alpha = 1.0
        }
        
        if certificateArray.indices.contains(indexPath.row) {
            cell.imageBtnOutlet.setImage(certificateArray[indexPath.row], for: .normal)
        }
        
        cell.onAdd = {
            self.selectedCell = indexPath.row
            
            if indexPath.row == 0 {
                if self.certificateArray.count != self.certificateCount {
                    self.view.makeToast("Please Select Certificate & Reward")
                    return
                } else if self.dateArray.count != self.certificateCount {
                    self.view.makeToast("Please Select Date")
                    return
                }
                self.certificateCount += 1
                tableView.reloadData()
//                self.viewHeightConstraint.constant = CGFloat((1263 + (53 * self.certificateCount)))
                self.bottomTableHeight.constant = CGFloat((53 * self.certificateCount))
            } else {
                if self.certificateCount > 1 {
                    self.certificateCount -= 1
                    
                    if self.dateArray.indices.contains(self.selectedCell) {
                        self.dateArray.remove(at: self.selectedCell)
                    }
                    if self.certificateArray.indices.contains(self.selectedCell) {
                        self.certificateArray.remove(at: self.selectedCell)
                    }
                    if self.certificateDataArray.indices.contains(self.selectedCell) {
                        self.certificateDataArray.remove(at: self.selectedCell)
                    }
                    
                    self.certificateAndRewardArray.removeAll()
                    
                    tableView.reloadData()
                    //self.viewHeightConstraint.constant = CGFloat((1263 + (53 * self.certificateCount)))
                    
                    self.bottomTableHeight.constant = CGFloat((53 * self.certificateCount))
                }
            }
        }
                
        cell.onCalender = {
            self.selectedCell = indexPath.row
            let vc = self.storyboard?.instantiateViewController(identifier: "CalenderPopUpViewController") as! CalenderPopUpViewController
            vc.delegate = self
            let card = SBCardPopupViewController(contentViewController: vc)
            card.show(onViewController: self)
        }

        cell.onImage = {
            self.selectedCell = indexPath.row
            self.imagePicker.imagePickerDelegete = self
            self.isProfileImage = false
            self.imagePicker.showImagePicker(viewController: self)
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
}

