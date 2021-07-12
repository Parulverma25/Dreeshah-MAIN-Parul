//
//  SideMenuViewController.swift
//  SideMenu
//
//  Created by promatics on 3/27/21.
//

import UIKit
//MARK:- global declare
var innerSideMenuData = [String]()

class SideMenuViewController: UIViewController {
    @IBOutlet weak var tableViewSideMenu: UITableView!
    var showHideArray = [false,false,false,false,false,false,false,false]
    var b : Int? = nil
    var viewController = UIViewController()
    let viewModel = AddProjectViewModel()
   let sideMenuArray = ["Catalogue","Professionals","Service","Products","Photographers","Login","Signup","Dreeshah Support","Settings","Rate the App","Share the App"]
    var underArraySide = [["Design and Remodelling","Design and Remodelling","Design and Remodelling"],["Professional Sub Item","Professional Sub Item","Professional Sub Item"],["Service Sub Item","Service Sub Item","Service Sub Item"],["Product Sub Item","Product Sub Item","Product Sub Item"],["Hire Photographers"],[],[],["Contact Dreeshah Support","Product Sub Item"],[],[],[]
    ]
    override func viewDidLoad() {
        hitCategory()
        super.viewDidLoad()
        tableViewSideMenu.reloadData()
        tableViewSideMenu.layoutIfNeeded()
        // Do any additional setup after loading the view.
    }
    override func viewDidLayoutSubviews() {
     
    }
    
    func setCategory(){
        underArraySide[1] = viewModel.getProfCategory().map({$0.name ?? ""})
        underArraySide[2] = viewModel.getProfCategory().map({$0.name ?? ""})
        underArraySide[3] = viewModel.getProfCategory().map({$0.name ?? ""})
    }
    
   /* func showSubCategories(tag: Int){
        //hitCategory()
        let vc = self.storyboard!.instantiateViewController(identifier: "SubCategoryListViewController") as! SubCategoryListViewController
        print(viewModel.getProfCategory())
        print(tag)
        let subCats: [ProfessionalCategoryModelElement] = viewModel.getProfCategory()[tag].subCategories ?? []
        vc.subCategories = subCats.map({$0.name ?? ""})
        vc.Category = viewModel.getProfCategory()[tag].name ?? ""
        self.navigationController?.pushViewController(vc, animated: true)
    }*/
    
    @IBAction func DissmissBtn(_ sender: UIButton) {
        
//        let nav = self.navigationController //grab an instance of the current navigationController
            DispatchQueue.main.async { //make sure all UI updates are on the main thread.
//                nav?.view.layer.add(CATransition().popFromRight(), forKey: nil)
                self.dismissDetail()
    }
    }
        
        func dismissDetail() {
            
            UIView.animate(withDuration: 0.3, animations: {
                
                self.view.frame.origin = CGPoint(x: -self.view.frame.size.width, y:0)
                
            }) { (completion) in

                let transition = CATransition()
                
                transition.duration = 0.3
                
                transition.type = CATransitionType.fade
                
                transition.subtype = CATransitionSubtype.fromRight
                
                self.view.window!.layer.add(transition, forKey: kCATransition)

                self.dismiss(animated: false)
                
            }
     
        }
    
    

    @IBAction func showHideBtn(_ sender: UIButton) {
        b = sender.tag
        if showHideArray[b!] == false
        {
            
            showHideArray[b!] = true
            for i in 0...(showHideArray.count - 1){
                if i != b
                {
                showHideArray[i] = false
                }
            }
        }else
        {
            showHideArray[b!] = false
        }
        
        tableViewSideMenu.reloadData()
    }
}

//MARK:- Tableview Delegates

extension SideMenuViewController : UITableViewDelegate,UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sideMenuArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        innerSideMenuData = underArraySide[indexPath.row]
        let cell = tableViewSideMenu.dequeueReusableCell(withIdentifier: "cell") as! SideMenuCell
        cell.headerlabel.text = sideMenuArray[indexPath.row]
        cell.buttonShow.tag = indexPath.row
        cell.viewController = self
        switch indexPath.row
        {
        case 0:
            cell.buttonShow.isHidden = false
            if showHideArray[0] == true
        {     cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
            cell.underLineView.isHidden = false
            cell.viewAllBtn.isHidden = false
        }else{
            cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

            cell.underLineView.isHidden = true
            cell.viewAllBtn.isHidden = true
        }
            
            
        case 1:
            cell.buttonShow.isHidden = false
            if showHideArray[1] == true
        {   cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
            cell.underLineView.isHidden = false
            cell.viewAllBtn.isHidden = false
        }else{
            cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

            cell.underLineView.isHidden = true
            cell.viewAllBtn.isHidden = true
        }
            
        case 2:
            cell.buttonShow.isHidden = false
            if showHideArray[2] == true
            {   cell.buttonShow.setImage(UIImage(systemName:"remove 4"), for: .normal)
                cell.underLineView.isHidden = false
                cell.viewAllBtn.isHidden = false
            }else{
                cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

                cell.underLineView.isHidden = true
                cell.viewAllBtn.isHidden = true
            }
        case 3:
            cell.buttonShow.isHidden = false
            if showHideArray[3] == true
            {   cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
                cell.underLineView.isHidden = false
                cell.viewAllBtn.isHidden = false
            }else{
                cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

                cell.underLineView.isHidden = true
                cell.viewAllBtn.isHidden = true
            }
        case 4:
            cell.buttonShow.isHidden = false
            if showHideArray[4] == true
            {   cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
                
            }else{
                cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

            }

        case 7:
            cell.buttonShow.isHidden = false
            if showHideArray[7] == true
            {   cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
                
            }else{
                cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)

            }
        
        default:
            cell.buttonShow.isHidden = true
        }
//        cell.buttonShow.setImage(UIImage(named:"plus"), for: .normal)
//
//        }else {
//            cell.cellHeight.constant = 200
//            cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
        cell.insideTableView.reloadData()
        
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let cell = tableViewSideMenu.dequeueReusableCell(withIdentifier: "cell") as! SideMenuCell
        if indexPath.row == b
        {  switch indexPath.row
        {
        case 4: if showHideArray[4] == true
        {
            return 100
        }else
        {
            
            return 50
            
        }
        
        case 5:
        return 50
        case 6:
        return 50
        case 7:
            if showHideArray[7] == true
            {cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
                return 150
            }else
            { cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)
                return 50
                
            }
        case 8:
        return 50
        case 9:
        return 50
        case 10:
        return 50
        
        default:
            if showHideArray[b!] == true
            {cell.buttonShow.setImage(UIImage(named:"remove 4"), for: .normal)
                return 200
            }else
            { cell.buttonShow.setImage(UIImage(systemName:"plus"), for: .normal)
                return 50
            }
          
        }
            
        }else
        {
            return 50
        }
    }
    
    
}
//MARK:- TABLEVIEW CLASSES
class SideMenuCell : UITableViewCell,UITableViewDataSource,UITableViewDelegate
{
    @IBOutlet weak var insideTableView: UITableView!
    @IBOutlet weak var headerlabel: UILabel!
    @IBOutlet weak var cellHeight: NSLayoutConstraint!
    @IBOutlet weak var underLineView: UIView!
    @IBOutlet weak var viewAllBtn: UIButton!
    @IBOutlet weak var buttonShow: UIButton!
    
    
    var viewController = UIViewController()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        insideTableView.delegate = self
        insideTableView.dataSource = self
        // Initialization code
        buttonShow.isHidden = true
        underLineView.isHidden = true
        viewAllBtn.isHidden = true
    }
       
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        innerSideMenuData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = insideTableView.dequeueReusableCell(withIdentifier: "cell2") as! SideMenuInsideCell
        cell.lbl.text = innerSideMenuData[indexPath.row]
        cell.btn.tag = indexPath.row
        cell.btn.addTarget(self, action: #selector(CategorySelected(_:)), for: .touchUpInside)
        return cell
    }
    @objc func CategorySelected(_ sender: UIButton){
    
        let vc = viewController as! SideMenuViewController
        let mainVC = vc.viewController as! HomeViewController
        vc.viewModel.getProfCategory()
       // vc.showSubCategories(tag: sender.tag)
        let nextView = mainVC.storyboard!.instantiateViewController(identifier: "SubCategoryListViewController") as! SubCategoryListViewController
      //  print(viewModel.getProfCategory())
     //   print(tag)
        let subCats: [ProfessionalCategoryModelElement] = vc.viewModel.getProfCategory()[sender.tag].subCategories ?? []
        nextView.subCategories = subCats.map({$0.name ?? ""})
        nextView.Category = vc.viewModel.getProfCategory()[sender.tag].name ?? ""
        vc.dismissDetail()
        mainVC.navigationController?.pushViewController(nextView, animated: true)
    }

   /* @objc func showSubCategories(_ sender: UIButton){
        let vc = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "SubCategoryListViewController") as! SubCategoryListViewController
       
        let subCats: [ProfessionalCategoryModelElement] = catModel.getProfCategory()[sender.tag].subCategories!
        vc.subCategories = subCats.map({$0.name ?? ""})
    
    }*/
}

class SideMenuInsideCell : UITableViewCell
{
    @IBOutlet weak var lbl: UILabel!
    @IBOutlet weak var btn: UIButton!
}

extension SideMenuViewController{
    func hitCategory(){
        viewModel.apigetCategory(){ (isSuccess, msg) in
            if(isSuccess){
                self.setCategory()
               // self.categoryList = self.viewModel.getProfCategory().map({$0.name ?? ""})
               // self.categoryListId = self.viewModel.getProfCategory().map({$0.id ?? ""})
                
            }else{
                print("Hit Fail")
                self.view.makeToast(msg)
            }
        }
    }
}
