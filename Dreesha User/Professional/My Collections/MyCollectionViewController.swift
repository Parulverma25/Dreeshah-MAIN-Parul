//
//  MyCollectionViewController.swift
//  Dreesha User
//
//  Created by Promatics on 17/06/21.
//

import UIKit

class MyCollectionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
   
    var titleArr = ["My Collection","My Collection","My Collection","My Collection"]
    var ValueArr = ["25 products","25 products","25 products","25 products"]

    @IBOutlet weak var MyCollectionTableView: UITableView!
    
    //MARK: Variables
    var viewModel = CollectionsViewModel()
    var offset = 0
    var iconClick = true
    var isFetching = false
    var CollectionIDVal = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        MyCollectionTableView.dataSource = self
        MyCollectionTableView.delegate = self

    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "My Collections")
        self.offset = 0
        self.viewModel.model = []
        self.isFetching = false
        MyCollectionList()
       
    }
   
    @IBAction func tapCrossBtn(_ sender : UIButton){
        CollectionIDVal = viewModel.model[sender.tag].id ?? ""
        DeleteCollection(CollectionIDVal: CollectionIDVal)
    }
    
    
}

extension MyCollectionViewController {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.model.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! MyCollectionTableViewCell
        cell.CollectionTitle.text = viewModel.model[indexPath.row].collectionName ?? ""
        cell.CollectionValue.text = "\(viewModel.model[indexPath.row].productsCount ?? 0) products"
        cell.DeleteCollectionBtn.tag = indexPath.row
        cell.DeleteCollectionBtn.addTarget(self, action: #selector(tapCrossBtn(_:)), for: .touchUpInside)
        
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = storyboard?.instantiateViewController(identifier: "CollectionsListViewController") as! CollectionsListViewController
        
        vc.CollectionIDStr = viewModel.model[indexPath.row].id ?? ""
        navigationController?.pushViewController(vc, animated: true)
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if isFetching{
            self.offset += 10
            MyCollectionList()
        }
        
        
        
    }
    
    
}
//MARK:- API Call
extension MyCollectionViewController{
    func MyCollectionList(){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.apiCollectionList(limit: "10", offset: String(self.offset)){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.isFetching = true
//                self.TotalResultLabel.text = "\(self.viewModel.totalcount ) results found"
                self.MyCollectionTableView.reloadData()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
    func DeleteCollection(CollectionIDVal : String){
        
        Indicator.shared.showProgressView(self.parent?.view ?? self.view)
        
        viewModel.hitDeleteCollection(collection_id: CollectionIDVal ){(isSuccess , message) in
            Indicator.shared.hideProgressView()
            if isSuccess{
                self.offset = 0
                self.viewModel.model = []
                self.isFetching = false
                self.MyCollectionList()
            }else{
                self.view.makeToast(message , position : .center)
            }
        }
    }
    
}
    

