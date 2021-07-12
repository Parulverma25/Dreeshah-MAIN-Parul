//
//  QuotationDetailViewController.swift
//  Dreesha User
//
//  Created by Apple on 17/03/21.
//

import UIKit

class QuotationDetailViewController: UIViewController {
    
   //MARK: Outlets
    
    @IBOutlet weak var CategoryTitleVal: UILabel!
    @IBOutlet weak var ViewQuotationBTN: SetButton!
    @IBOutlet weak var ImgView: UIView!
    @IBOutlet weak var CustomerName: UILabel!
    @IBOutlet weak var PhNo: UILabel!
    @IBOutlet weak var EmailVal: UILabel!
    @IBOutlet weak var QuotationRef: UILabel!
    @IBOutlet weak var Date_timeVal: UILabel!
    @IBOutlet weak var ServiceNameVal: UILabel!
    @IBOutlet weak var SalesReprestVal: UILabel!
    @IBOutlet weak var LocationVal: UILabel!
    @IBOutlet weak var SrvcNoVal: UILabel!
    @IBOutlet weak var EstimatedBgtVAl: UILabel!
    @IBOutlet weak var ExpctDateVal: UILabel!
    @IBOutlet weak var QuantityVal: UILabel!
    @IBOutlet weak var ImageViewQuot: UIImageView!
    @IBOutlet weak var DecrptVal: UILabel!
    
    
    
    //MARK: VARAIBLES
    var viewModel = QuotationDetailsViewModel()
    var QuotationIDStrVal = ""
    var comefrom = ""
    //MARK: ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = true
        if comefrom == "Modify"{
            ViewQuotationBTN.isHidden = false
        }else if comefrom == "inProgress"{
            ViewQuotationBTN.isHidden = false
        }else{
            ViewQuotationBTN.isHidden = true
        }
        hitApiQuotationsDetails(QuotationIDStr: QuotationIDStrVal)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.isNavigationBarHidden = false
    }
    

    @IBAction func back(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func viewQuotation(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(withIdentifier: "ViewQuotationViewController") as! ViewQuotationViewController
        vc.quotationId = viewModel.model?.details?.id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func Setdata(){
        
        let url = URLS.ServiceImgUrl(viewModel.model?.details?.professionalServiceID?.serviceImage ?? "").getDescription()
        ImageViewQuot.sd_setImage(with: URL(string : url),  placeholderImage: #imageLiteral(resourceName: "Placehold"))
        CustomerName.text = viewModel.model?.details?.name ?? ""
        PhNo.text = viewModel.model?.details?.phoneNumber ?? ""
        EmailVal.text = viewModel.model?.details?.email ?? ""
        QuotationRef.text = viewModel.model?.details?.quotationRef ?? ""
        Date_timeVal.text = viewModel.model?.details?.date ?? ""
        ServiceNameVal.text = viewModel.model?.details?.serviceName ?? ""
        SalesReprestVal.text = viewModel.model?.details?.salesRepresentative ?? ""
        LocationVal.text = viewModel.model?.details?.location ?? ""
        SrvcNoVal.text = viewModel.model?.details?.quotationNo ?? ""
        EstimatedBgtVAl.text = "AED \(viewModel.model?.details?.estimatedBudget ?? "")"
        ExpctDateVal.text = viewModel.model?.details?.expectedDate ?? ""
        if (viewModel.model?.details?.quantity ?? "") == ""{
            QuantityVal.isHidden = true
            QuantityVal.text = "\(viewModel.model?.details?.quantity ?? "")pcs"
        }else{
            QuantityVal.isHidden = false
            QuantityVal.text = "\(viewModel.model?.details?.quantity ?? "")pcs"
        }
       
        DecrptVal.text = viewModel.model?.details?.detailsDescription ?? ""
        CategoryTitleVal.text = viewModel.model?.details?.serviceName ?? ""
        
    }
    
}
//MARK:- API Call
extension QuotationDetailViewController{
    func hitApiQuotationsDetails(QuotationIDStr : String ){
    
    Indicator.shared.showProgressView(self.parent?.view ?? self.view)
    
    viewModel.apiQuotationDetailfunc(quotationID: QuotationIDStr)    {(isSuccess , message) in
        Indicator.shared.hideProgressView()
        if isSuccess{
            self.Setdata()
        }else{
           
            self.view.makeToast(message , position : .center)
        }
    }
}

}
