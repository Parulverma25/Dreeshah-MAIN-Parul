//
//  BackgroundLabels.swift
//  Pracup
//
//  Created by promatics on 29/12/20.
//  Copyright © 2020 promatics. All rights reserved.
//

import Foundation
import UIKit

public func tableCollectionErrors<T>(view:T,text:String){

    if let table = view as? UITableView{

        let label = UILabel()

        label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height:  table.frame.height)

        label.text = text

        label.font = UIFont.systemFont(ofSize: 20)

        label.textAlignment = .center

        label.textColor = .black

        table.backgroundView = label

    }

    else if let collection = view as? UICollectionView{

        let label = UILabel()

        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height:  collection.frame.height)

        label.text = text

        label.font = UIFont.systemFont(ofSize: 20)

        label.textAlignment = .center

        label.textColor = .black

        collection.backgroundView = label

    }

    else{

        print("sdsds")

    }

    

}

public func displayRedErrorMessages<T>(view:T,text:String){

    if let table = view as? UITableView{

        let label = UILabel()

        label.frame = CGRect(x: 0, y: 0, width: table.frame.width, height:  table.frame.height)

        label.text = text

        label.font = UIFont.systemFont(ofSize: 20)

        label.textAlignment = .center

        label.textColor = .black

        table.backgroundView = label

    }

    else if let collection = view as? UICollectionView{

        let label = UILabel()

        label.frame = CGRect(x: 0, y: 0, width: collection.frame.width, height:  collection.frame.height)

        label.text = text

        label.font = UIFont.systemFont(ofSize: 20)

        label.textAlignment = .center

        label.textColor = .black

        collection.backgroundView = label

    }

    else{

        print("sdsds")

    }

}
