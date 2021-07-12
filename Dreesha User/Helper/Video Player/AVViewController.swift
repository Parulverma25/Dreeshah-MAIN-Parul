//
//  AVViewController.swift
//  Chato
//
//  Created by promatics on 1/20/21.
//  Copyright © 2021 Promatics. All rights reserved.
//

import Foundation
import UIKit
import AVKit

class AVViewController: UIViewController {

    // MARK:- Outlets
    
    @IBOutlet var avPlayerView: AvpVideoPlayer!
    
    // MARK:- Variables
    
    var videoUrl = ""
    var playerItem:AVPlayerItem?
    
    // MARK:- View Functions
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor(red: 150/255, green: 11/255, blue: 15/255, alpha: 1)
        self.navigationController?.isNavigationBarHidden = false
        if let playerItemm = playerItem{
            avPlayerView.configureWithPlayerItem(playerItem: playerItemm)
        }
        else{
            avPlayerView.configure(url: videoUrl)
        }
       
        avPlayerView.isLoop = false
        avPlayerView.play()
        let backBtn = UIButton()
        backBtn.setImage(#imageLiteral(resourceName: "back"), for: .normal)
        backBtn.addTarget(self, action: #selector(cancelBtnTapped(_:)), for: .touchUpInside)
        backBtn.tintColor = .white
        navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
    }
    
    @objc func cancelBtnTapped(_ sender: Any) {
        print("cancel tapped")
        navigationController?.popViewController(animated: true)
    }
    
  
}
