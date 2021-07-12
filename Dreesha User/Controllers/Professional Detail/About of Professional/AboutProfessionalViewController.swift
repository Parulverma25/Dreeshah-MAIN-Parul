//
//  AboutProfessionalViewController.swift
//  Dreesha User
//
//  Created by promatics on 3/25/21.
//

import UIKit

class AboutProfessionalViewController: UIViewController {
    @IBOutlet weak var tableViewForContact: UITableView!
    @IBOutlet weak var collectionViewAreaCover: UICollectionView!
    
    @IBOutlet weak var emaidVal: UILabel!
    
    @IBOutlet weak var companyNameVal: UILabel!
    
    @IBOutlet weak var companyInfoVal: UILabel!
    
    @IBOutlet weak var categoryVal: UILabel!
    @IBOutlet weak var mobileNoVal: UILabel!
    @IBOutlet weak var companyEmailVal: UILabel!
    
    
    var cityArray = ["Delhi","Ahmedabad","Chandigarh","Pune"]
    var contactHeadersArray = ["Contact info","Category","Service Provided","Personal Provided"]
    var bodyArray = ["Milind Pai 120, Kuber, New Link Road Andheri-West, Mumbai Maharashtra, 100256","Interior Designers & Interior Decorators","3D Rendering, Architectural Design, Bathroom Design, Building Design, Custom Home"]
    
    var professionalData : ProfessionalListModelElement?
    //MARK:- ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()

        companyNameVal.text = professionalData?.branchNameEn ?? ""
        companyInfoVal.text = professionalData?.branchBrief ?? ""
        companyEmailVal.text = professionalData?.contactDetails?.branchEmail ?? ""
        mobileNoVal.text = professionalData?.contactDetails?.mobileNumber ?? ""
        
    }
    
}
// MARK:- Extensions
extension AboutProfessionalViewController : UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout
{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return professionalData?.serviceDetails?.serviceCity?.count ?? 0
    } 
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {

                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! AreaCoveredOfAboutCollectionViewCell
        cell.cityLabel.text  = professionalData?.serviceDetails?.serviceCity?[indexPath.row] ?? ""
              return cell
    }
}
//MARK:- TableView
extension AboutProfessionalViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactHeadersArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableViewForContact.dequeueReusableCell(withIdentifier: "cell") as! AboutContactTableViewCell
        cell.constrainLength.constant = 30
        if indexPath.row > 0{
            cell.constrainLength.constant = 0
            cell.locationImg.isHidden = true
        }
       
        cell.headerLbl.text = contactHeadersArray[indexPath.row]
        if indexPath.row == 3
        {
            cell.bodyLbl.removeFromSuperview()
        }else
        { print(bodyArray[indexPath.row])
            cell.bodyLbl.text = bodyArray[indexPath.row]
        }
        return cell
    }
   
}
