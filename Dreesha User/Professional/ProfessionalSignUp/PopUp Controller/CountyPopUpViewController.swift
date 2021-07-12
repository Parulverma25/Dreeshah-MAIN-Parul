//
//  CountyPopUpViewController.swift
//  Dreeshah
//
//  Created by Apple on 24/03/21.
//

import UIKit

class CountryPopUpCell: UITableViewCell {
    
    @IBOutlet weak var countryName: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
}



protocol CountryList {
    func countries(name: [String], isCity: Bool, code: [String])
}


class CountyPopUpViewController: UIViewController {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var headingLabel: UILabel!
    
    var data: [CountryName] = []
    var name: [String] = []
    var selectedCode: [String] = []
    var delegate: CountryList?
    var isCity: Bool! = false
    
    
    var countryAndCity: [String] = []
    var countryCode: [String] = []
    var selectedIndex: [Bool] = []
    var selectedName: [String] = []
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        if isCity {
            self.data.append(contentsOf: [CountryName(name: "Mohali"), CountryName(name: "Delhi"), CountryName(name: "Banglore"), CountryName(name: "Mumbai"), CountryName(name: "Kolkata"), CountryName(name: "Mohali")])
            self.headingLabel.text = "City List"
        } else {
            self.data.append(contentsOf: [CountryName(name: "India"), CountryName(name: "China"), CountryName(name: "Japan"), CountryName(name: "Australia"), CountryName(name: "Russia")])
            self.headingLabel.text = "Country List"
        }
        
        for _ in 0..<countryAndCity.count {
            selectedIndex.append(false)
        }
        print(countryAndCity.count)
        print(selectedIndex.count)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
//        data = data.filter({$0.isSelected == true})
//        name.append(contentsOf: data.map({$0.name}))
       
        for i in 0..<countryAndCity.count {
            if selectedIndex[i] {
                self.name.append(countryAndCity[i])
            }
        }
        
        if !isCity {
            for i in 0..<countryCode.count {
                if selectedIndex[i] {
                    self.selectedCode.append(countryCode[i])
                }
            }
            print(self.selectedCode)
        }
        
        delegate!.countries(name: name, isCity: isCity, code: selectedCode)
    }

    
}


//MARK:- Table View Delegates

extension CountyPopUpViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return countryAndCity.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! CountryPopUpCell
        cell.countryName.text = countryAndCity[indexPath.row]
        cell.accessoryType = self.selectedIndex[indexPath.row] ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //self.data[indexPath.row].isSelected.toggle()
        
        self.selectedIndex[indexPath.row].toggle()
        
        tableView.reloadData()
    }
}


struct CountryName {
    var name: String!
    var isSelected: Bool! = false
    
    init(name: String!) {
        self.name = name
    }
}
