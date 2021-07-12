//
//  ProductListViewController.swift
//  Dreeshah
//
//  Created by Promatics on 18/03/21.
//

import UIKit

class ProductListViewController: UIViewController ,UITableViewDelegate,UITableViewDataSource{
   
    
//Mark Outlets
    @IBOutlet weak var tableViewProductlis: UITableView!
    
    @IBOutlet weak var outerCollectionView: UICollectionView!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBOutlet var outerView: UIView!
    
//Mark Variables
  var gridView = false
    var viewModel = ProductListViewModel()
    var countArrayData:[Int]!
    var offset = 0
    var ArrLabel1 = ["Designer Furniture","Designer Rugs","External Lights"]
    var ArrImg = [ #imageLiteral(resourceName: "1IMG"), #imageLiteral(resourceName: "2IMG"), #imageLiteral(resourceName: "3IMG")]
    
    //Mark View DID Load
    override func viewDidLoad() {
        super.viewDidLoad()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.1) {
            // your code here
            self.setView()
        }
       
        
        tableViewProductlis.dataSource=self
        tableViewProductlis.delegate=self
    //tableViewProductlis.reloadData()
        tableViewProductlis.tableFooterView=UIView()
        
        if CurrentSession.shared.isServiceListProfesstional {
         
        } else {
            
        }
    }
   //MARK:- viewWillAppear
    override func viewWillAppear(_ animated: Bool) {
        if CurrentSession.shared.isServiceListProfesstional {
            hitApiServiceList()
            setBackWithTitle(titleVal: "Service List")
        } else {
            hitApiProductsList()
            setBackWithTitle(titleVal: "Product List")
        }
        
        }
      

    //MARK:- IBActions
    @IBAction func outerViewDetails(_ sender: UIButton) {
        if CurrentSession.shared.isServiceListProfesstional {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
            vc.productID = self.viewModel.model2?.data?[sender.tag].id
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
            vc.productID = self.viewModel.model?.data?[sender.tag].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }

    }
    @IBAction func viewDetailsServiceBtn(_ sender: UIButton) {
        
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
            vc.productID = self.viewModel.model2?.data?[sender.tag].id
            
            self.navigationController?.pushViewController(vc, animated: true)
        
    }
    
    @IBAction func viewDetailsProduct(_ sender: UIButton) {
        
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
            vc.productID = self.viewModel.model?.data?[sender.tag].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func listView(_ sender: Any) {
        
        outerView.removeFromSuperview()
    }
    @IBAction func addProduct(_ sender: Any) {
        if CurrentSession.shared.isServiceListProfesstional {
            let vc = self.storyboard?.instantiateViewController(identifier: "AddServiceViewController") as! AddServiceViewController
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "AddProductViewController") as! AddProductViewController
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    
    
    @IBAction func gridView(_ sender: Any) {
        setView()
//        let vc = self.storyboard?.instantiateViewController(identifier: "ProductGridViewController") as! ProductGridViewController
//        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    @IBAction func SortTap(_ sender: UIButton) {
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SortByPopUpViewController") as! SortByPopUpViewController
        vc.modalPresentationStyle = .overCurrentContext
        vc.completionBlock = {
            value in
            print(value)
            self.sortByProductsProf(sort: "price", sortBy: value, offset: String(self.offset))
        }
        navigationController?.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func FilterTap(_ sender: UIButton) {
    }
    
    @IBAction func AddtoCollection(_ sender: UIButton) {
    let vc = self.storyboard?.instantiateViewController(identifier: "SelectCollectionViewController") as! SelectCollectionViewController
        vc.modalPresentationStyle = .overFullScreen
        vc.productIDVal = viewModel.model?.data?[sender.tag].id ?? ""
        self.present(vc, animated: true, completion: nil)
    }
    
    
}

//Mark Table View Delegate Functions
extension ProductListViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if CurrentSession.shared.isServiceListProfesstional
        {
            if viewModel.model2?.data?.count != nil
            {
                return (viewModel.model2?.data?.count)!
            }else
            {
                return 0
                
            }
            
        }else
        {
            if viewModel.model?.data?.count != nil
            {
                return (viewModel.model?.data?.count)!
            }else
            {
                return 0
                
            }
        }
        
    }
    func setView(){
        gridView = true
        outerView.frame = tableViewProductlis.frame
        view.addSubview(outerView)
    }
    
    
    //TableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if CurrentSession.shared.isServiceListProfesstional
        {
        
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell2") as! ProductListTableViewCell
            cell.Label1.text = (self.viewModel.model2?.data?[indexPath.row].serviceName)!
            cell.Label2.text = (self.viewModel.model2?.data?[indexPath.row].serviceDescription)!
            cell.Label3.text =
                "AED \((self.viewModel.model2?.data?[indexPath.row].price)!)"
            cell.cityName.text = (self.viewModel.model2?.data?[indexPath.row].country?.joined(separator: ","))
            cell.time.text = (self.viewModel.model2?.data?[indexPath.row].duration)!
            cell.ViewDetailServiceBtn.tag = indexPath.row
            let imageUrl = URLS.serviceImageUrl(viewModel.model2?.data?[indexPath.row].serviceImage ?? "").getDescription()
            print("IMAGEEEEEEEURL+++++>>\(imageUrl)")
            cell.ImgView.sd_setImage(with: URL(string : imageUrl), placeholderImage: #imageLiteral(resourceName: "4"))
//            cell.AddtoCollectionBtn.isHidden = true
            
            return cell
        
        }else
        {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! ProductListTableViewCell
            cell.ViewDetailBtn.tag = indexPath.row
            cell.Label1.text = (self.viewModel.model?.data?[indexPath.row].productTitle)!
            cell.Label2.text = (self.viewModel.model?.data?[indexPath.row].productDescription)!
            cell.Label3.text = "AED \((self.viewModel.model?.data?[indexPath.row].pricing?.price)!)"
            cell.Label4.text = "AED \((self.viewModel.model?.data?[indexPath.row].pricing?.comprice)!)"
            let imageUrl = URLS.productImgUrl(viewModel.model?.data?[indexPath.row].productMedia?.first?.name ?? "").getDescription()
            cell.ImgView.sd_setImage(with: URL(string : imageUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
            cell.AddtoCollectionBtn.isHidden = false
            cell.AddtoCollectionBtn.tag = indexPath.row
            cell.AddtoCollectionBtn.addTarget(self, action: #selector(AddtoCollection(_:)), for: .touchUpInside)
            return cell
        }
        
       
        
       
      //  cell.ImgView.image=ArrImg[indexPath.row]
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
       
        if CurrentSession.shared.isServiceListProfesstional {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
            vc.productID = self.viewModel.model2?.data?[indexPath.row].id
            
            self.navigationController?.pushViewController(vc, animated: true)
        } else {
            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
            vc.productID = self.viewModel.model?.data?[indexPath.row].id ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
//    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
////        if viewModel.isMoreData{
////            self.offset += 10
////            hitApiProductsList()
////        }
//    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
}
//MARK:- collectionVIEW DELEGATE
extension ProductListViewController : UICollectionViewDelegate , UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if CurrentSession.shared.isServiceListProfesstional
        {
            if viewModel.model2?.data?.count != nil
            {
                return (viewModel.model2?.data?.count)!
            }else
            {
                return 0
                
            }
            
        }else
        {
            if viewModel.model?.data?.count != nil
            {
                return (viewModel.model?.data?.count)!
            }else
            {
                return 0
                
            }
        }
        
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if CurrentSession.shared.isServiceListProfesstional
        {
        let cell = outerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductGridCollectionCell
        let imageUrl = URLS.serviceImageUrl(viewModel.model2?.data?[indexPath.row].serviceImage ?? "").getDescription()
            
        cell.image1.sd_setImage(with: URL(string : imageUrl), placeholderImage: #imageLiteral(resourceName: "Placehold"))
        cell.priceOfService.text = "AED \((self.viewModel.model2?.data?[indexPath.row].price)!)"
            let state = (self.viewModel.model2?.data?[indexPath.row].country?.joined(separator: ","))!
        cell.stateName.setTitle(state, for: .normal)
        cell.serviceView.isHidden = false
        let duration = (self.viewModel.model2?.data?[indexPath.row].duration)!
        cell.duration.setTitle(duration, for: .normal)
        cell.title.text = (self.viewModel.model2?.data?[indexPath.row].serviceName)!
        cell.discriptions.text = (self.viewModel.model2?.data?[indexPath.row].serviceDescription)!
        cell.outsideBtn.tag = indexPath.row
            cell.AddToCollectionBtns.isHidden = true
        return cell
    }else
        {
            let cell = outerCollectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ProductGridCollectionCell
            cell.serviceView.isHidden = true
            let imageUrl = URLS.productImgUrl(viewModel.model?.data?[indexPath.row].productMedia?.first?.name ?? "").getDescription()
            cell.image1.sd_setImage(with: URL(string : imageUrl), placeholderImage:#imageLiteral(resourceName: "Placehold"))
            cell.comPrice.text = "AED \((self.viewModel.model?.data?[indexPath.row].pricing?.comprice)!)"
            cell.priceOfProduct.text = "AED \((self.viewModel.model?.data?[indexPath.row].pricing?.price)!)"
            cell.discriptions.text = (self.viewModel.model?.data?[indexPath.row].productDescription)!
            cell.title.text = (self.viewModel.model?.data?[indexPath.row].productTitle)!
            cell.outsideBtn.tag = indexPath.row
            cell.AddToCollectionBtns.isHidden = false
            cell.AddToCollectionBtns.tag = indexPath.row
            cell.AddToCollectionBtns.addTarget(self, action: #selector(AddtoCollection(_:)), for: .touchUpInside)
             return cell
        }
    }
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if CurrentSession.shared.isServiceListProfesstional {
//            let vc = self.storyboard?.instantiateViewController(identifier: "ProfServiceDetailsViewController") as! ProfServiceDetailsViewController
//            vc.productID = self.viewModel.model2?.data?[indexPath.row].id
//
//            self.navigationController?.pushViewController(vc, animated: true)
//        } else {
//            let vc = self.storyboard?.instantiateViewController(identifier: "ProfProductDetailsViewController") as! ProfProductDetailsViewController
//            vc.productID = self.viewModel.model?.data?[indexPath.row].id ?? ""
//            self.navigationController?.pushViewController(vc, animated: true)
//        }
//    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       
            return CGSize(width: self.tableViewProductlis.frame.size.width/2 - 1, height: 250)
       
      
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if viewModel.isMoreData{
            self.offset += 10
            hitApiServiceList()
        }
    }
    
}





//MARK:- API Work
extension ProductListViewController
{
    //hit product list
    func hitApiProductsList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitApiProductList(valLimit: 20, valOffset: 0, completion: {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.tableViewProductlis.reloadData()
                self.outerCollectionView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        })
    }
    //hit Service list
    func hitApiServiceList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitApiServiceList(valLimit: 10, valOffset: 0, completion: {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.tableViewProductlis.reloadData()
                self.outerCollectionView.reloadData()

            }else{
                self.view.makeToast(message , position : .center)
            }
        })
    }
    
    
    func sortByProductsProf(sort : String , sortBy : String , offset : String){
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        viewModel.sortByProductListProf(limit: "10", offset: offset, sort: sort, sortBy: sortBy) {(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.tableViewProductlis.reloadData()
                self.outerCollectionView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    
    
    
}
