//
//  BusinessDetailViewController.swift
//  Dreeshah
//
//  Created by Apple on 23/03/21.
//

import UIKit
import AnimatedField
import SBCardPopup


class CountryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var countyNameLabel: UILabel!
    
    var onDeleteCountry: (() -> Void)!
    
    
    @IBAction func deleteBtn(_ sender: Any) {
        onDeleteCountry()
    }
    
}



class CityCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var cityNameLabel: UILabel!
    
    var onCityDelete: (() -> Void)!
    
    @IBAction func deleteBtn(_ sender: Any) {
        onCityDelete()
    }
}


class BusinessDetailViewController: UIViewController, CountryList, Year {
    
    func getYearValue(year: String) {
        print(year)
        lowerYearLabel.text = year
        upperYearLabel.isHidden = false
        lowerYearLabel.alpha = 1.0
    }
    
    
    func countries(name: [String], isCity: Bool, code: [String]) {
        if !isCity {
            if name.count > 0 {
                self.countryName = name
                collectionView.reloadData()
                collectionView.isHidden = false
                countryLabel.isHidden = false
                countryHighlightLabel.isHidden = true
                print(code)
                selectedCode = code
                self.city(countryCode: selectedCode)
                self.cityName.removeAll()
                cityCollectionView.reloadData()
            } else {
//                collectionView.isHidden = true
//                countryLabel.isHidden = true
//                countryHighlightLabel.isHidden = false
            }
        } else {
            if name.count > 0 {
                self.cityName = name
                cityCollectionView.reloadData()
                cityCollectionView.isHidden = false
                cityLabel.isHidden = false
                cityHighlightLabel.isHidden = true
            } else {
//                cityCollectionView.isHidden = true
//                cityLabel.isHidden = true
//                cityHighlightLabel.isHidden = false
            }
        }
    }
    
    var format = AnimatedFieldFormat()
    
    var countryName: [String] = []
    var cityName: [String] = []
    
    
    var viewModelP = PersonalInfoViewModel()
    var isEdit: Bool! = false
    
    
    @IBOutlet weak var browseBtnOutlet: SetButton!
    @IBOutlet weak var fileName: UILabel!
    
    
    var countryNameArray: [String] = []
    var codeNameArray: [String] = []
    var cityNameArray: [String] = []
    var selectedCode: [String] = []
    
    var dataBusiness = ProfessionalSignUpdata()
    var viewModel = SignupViewModel()
    var imageData = Data()
    var imagePicker = ImagePickerViewControler()

    var shownImage : UIImage!
    
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var cityCollectionView: UICollectionView!
    
    
    @IBOutlet weak var countryLabel: UILabel!
    @IBOutlet weak var countryHighlightLabel: UILabel!
    
    @IBOutlet weak var cityHighlightLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    @IBOutlet weak var establishYear: AnimatedField!
    @IBOutlet weak var licenceNoView: AnimatedField!
    
    @IBOutlet weak var btn1: SetButton!
    @IBOutlet weak var btn2: SetButton!
    @IBOutlet weak var btn3: SetButton!
    @IBOutlet weak var btn4: SetButton!
    @IBOutlet weak var btn5: SetButton!
    
    @IBOutlet weak var upperYearLabel: UILabel!
    @IBOutlet weak var lowerYearLabel: UILabel!
    @IBOutlet weak var topImageHeight: NSLayoutConstraint!
    @IBOutlet weak var topImage: UIImageView!
    
    
    var data: [CountryName] = []
    var isBranchAdd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        establishYear.keyboardType = .phonePad
//        establishYear.placeholder = "Branch Establishment Year*"
        licenceNoView.placeholder = "Licence Number*"
        
        format.textColor = .black
        format.lineColor = .black
        format.highlightColor = .black
        format.titleColor = .black
        
        //establishYear.format = format
        licenceNoView.format = format
        
        btn1.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn1.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        
        upperYearLabel.isHidden = true
        collectionView.isHidden = true
        countryLabel.isHidden = true
        cityCollectionView.isHidden = true
        cityLabel.isHidden = true
        self.dataBusiness.branchLicence = ""
        country()
        
        if isEdit {
            collectionView.reloadData()
            collectionView.isHidden = false
            countryLabel.isHidden = false
            countryHighlightLabel.isHidden = true
            
            cityCollectionView.isHidden = false
            cityLabel.isHidden = false
            cityHighlightLabel.isHidden = true
            
            lowerYearLabel.text = String(viewModelP.dataModel?.data?.businessDetails?.branchYear ?? 0)
            upperYearLabel.isHidden = false
            lowerYearLabel.alpha = 1.0
            
            licenceNoView.text = viewModelP.dataModel?.data?.businessDetails?.licenceNumber
            
            self.browseBtnOutlet.sd_setImage(with: URL(string: URLS.certificateImageUrl((self.viewModelP.dataModel?.data?.businessDetails?.branchLicence)!).getDescription()), for: .normal, placeholderImage: UIImage(named: "placeholder.png"))
            
            fileName.text = self.viewModelP.dataModel?.data?.businessDetails?.branchLicence
        }else if isBranchAdd{
            topImageHeight.constant = 60
            topImage.isHidden = true
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

        setBackWithTitle(titleVal : "Personal Information")
    }
    
    
    func country() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUserCountry(){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.countryNameArray = (self.viewModel.countryModel?.data?.map({$0.name ?? ""}))!
                print(self.countryNameArray)
                self.codeNameArray = (self.viewModel.countryModel?.data?.map({$0.isoCode ?? ""}))!
                print(self.codeNameArray)
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    
    func city(countryCode : [String]){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUserCity(CountryCode: countryCode){(isSuccess , message) in
        
            Indicator.shared.hideProgressView()
            if isSuccess {
                self.cityNameArray = (self.viewModel.cityModel?.data?.map({$0.name ?? ""}))!
            } else {
                self.view.makeToast(message)
            }
        }
    }
    
    @IBAction func browseBtn(_ sender: Any) {
        imagePicker.imagePickerDelegete = self
        imagePicker.showImagePicker(viewController: self)
    }
    
    @IBAction func calenderBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(identifier: "YearPopUpViewController") as! YearPopUpViewController
        vc.delegate = self
        let card = SBCardPopupViewController(contentViewController: vc)
        card.show(onViewController: self)
    }
    
    
    @IBAction func btn1Action(_ sender: Any) {
        btn1.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn1.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    @IBAction func btn2Action(_ sender: Any) {
        btn2.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn2.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    @IBAction func btn3Action(_ sender: Any) {
        btn3.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn3.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    @IBAction func btn4Action(_ sender: Any) {
        btn4.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn4.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
        btn5.BorderColor = .gray
        btn5.setImage(nil, for: .normal)
    }
    
    @IBAction func btn5Action(_ sender: Any) {
        btn5.BorderColor = #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1)
        btn5.setImage(UIImage(named: "Ellipse 14"), for: .normal)
        btn2.BorderColor = .gray
        btn2.setImage(nil, for: .normal)
        btn3.BorderColor = .gray
        btn3.setImage(nil, for: .normal)
        btn4.BorderColor = .gray
        btn4.setImage(nil, for: .normal)
        btn1.BorderColor = .gray
        btn1.setImage(nil, for: .normal)
    }
    
    @IBAction func serviceBtn(_ sender: Any) {
        

        print(countryName)
        print(cityName)
        print(lowerYearLabel.text as Any)

        if CurrentSession.shared.isProfesstionalSignUp || isBranchAdd{
            if self.lowerYearLabel.text == "Branch Establishment Year*" {
                self.view.makeToast("Please Select Branch Establishment Year")
            } else if self.countryName.isEmpty {
                self.view.makeToast("Please Select Country")
            }  else if self.cityName.isEmpty {
                self.view.makeToast("Please Select City")
            }  else if self.licenceNoView.text == "" {
                self.view.makeToast("Please Enter Licence Number")
            }  else if (self.dataBusiness.branchLicence == nil || self.dataBusiness.branchLicence == "") {
                self.view.makeToast("Please Upload Branch Licence")
            } else {

                self.dataBusiness.branchYear = Int(lowerYearLabel.text ?? "")
                self.dataBusiness.issued_in_countries = countryName
                self.dataBusiness.issued_in_cities = cityName
                self.dataBusiness.licenceNumber = licenceNoView.text

                if btn1.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "1 to 10"
                } else if btn2.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 50"
                } else if btn3.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 100"
                } else if btn4.BorderColor == #colorLiteral(red: 0.04464936256, green: 0.2999614477, blue: 0.5387767553, alpha: 1) {
                    self.dataBusiness.no_of_emp = "upto 500"
                } else {
                    self.dataBusiness.no_of_emp = "more than 500"
                }

                let vc = storyboard?.instantiateViewController(identifier: "ServiceDetailViewController") as! ServiceDetailViewController
                vc.dataService = dataBusiness
                vc.isBranchAdd = self.isBranchAdd
                self.navigationController?.pushViewController(vc, animated: true)
            }
        } else {
            self.navigationController?.popViewController(animated: true)
        }
       
    }
    
   
    
    @IBAction func countryBtn(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
        vc.delegate = self
        vc.isCity = false
        vc.countryAndCity = countryNameArray
        vc.countryCode = codeNameArray
        let cardPopup = SBCardPopupViewController(contentViewController: vc)
        cardPopup.show(onViewController: self)
    }
    
    @IBAction func cityBtn(_ sender: Any) {
        if cityNameArray.isEmpty {
            self.view.makeToast("No city found.")
        } else {
            let vc = self.storyboard?.instantiateViewController(withIdentifier: "CountyPopUpViewController") as! CountyPopUpViewController
            vc.delegate = self
            vc.isCity = true
            vc.countryAndCity = cityNameArray
            let cardPopup = SBCardPopupViewController(contentViewController: vc)
            cardPopup.show(onViewController: self)
        }
    }
    
    
}

//MARK:- Collection View Delegates


extension BusinessDetailViewController: UICollectionViewDelegate , UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == cityCollectionView {
            return cityName.count
        }
        return countryName.count
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == cityCollectionView {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CityCollectionViewCell
            cell.cityNameLabel.text = cityName[indexPath.row]
            cell.onCityDelete = {
                self.cityName.remove(at: indexPath.row)
                self.cityCollectionView.reloadData()
            }
            return cell
        } else {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CountryCollectionViewCell
            cell.countyNameLabel.text = countryName[indexPath.row]
            cell.onDeleteCountry = {
                self.countryName.remove(at: indexPath.row)
                if !self.isEdit {
                    self.selectedCode.remove(at: indexPath.row)
                    self.city(countryCode: self.selectedCode)
                }
                collectionView.reloadData()
                self.cityName.removeAll()
                self.cityCollectionView.reloadData()
            }
            return cell
        }
    }
}



extension BusinessDetailViewController : ImagePickerDelegete {
    
    func disFinishPicking(imgData: Data, img: UIImage) {
        
        imageData = img.jpegData(compressionQuality: 0.6)!
        uploadImage()
        self.shownImage = img
    }
    
    func showPic() {
        self.browseBtnOutlet.setImage(self.shownImage, for: .normal)
    }
    
    func uploadImage() {
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.hitUploadImage(imageData: imageData, imageName: GenerateUniqueImageName(), imageMime: "jpeg/image") { (isSuccess, message) in
            print(message)
            if isSuccess {
                self.dataBusiness.branchLicence = self.viewModel.imageData?.data
                self.showPic()
                //self.fileName.text = self.viewModel.imageData?.data
            } else {
                self.view.makeToast(message)
            }
        }
    }
}
