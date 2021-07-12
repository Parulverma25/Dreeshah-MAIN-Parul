//
//  BookingTrackingViewController.swift
//  Dreesha User
//
//  Created by Promatics on 15/03/21.
//

import UIKit

class BookingTrackingViewController: UIViewController {
    //Mark Outlets
    @IBOutlet weak var trkImgView: UIImageView!
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        trkImgView.layer.cornerRadius = 15
        trkImgView.clipsToBounds = true
        self.hideKeyboardWhenTappedAround()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal : "Booking Detail")
    }

}
