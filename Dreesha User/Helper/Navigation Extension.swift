import UIKit
extension UIViewController {
  func setBackBtn(){
      let qrButton = UIButton()
      
      let image = UIImage(named: "Back Button123")
      
      qrButton.setImage(image, for: .normal)
   
      qrButton.addTarget(self, action: #selector(tapBack), for: .touchUpInside)
      
      self.navigationItem.leftBarButtonItems = [UIBarButtonItem(customView: qrButton)]
      
  }
    
    func setBackWithTitle(titleVal : String){
        navigationItem.title = titleVal
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for:.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.layoutIfNeeded()
        setBackBtn()
    }
  
  //MARK:- @objc Functions
  
  @objc func tapBack(){
      navigationController?.popViewController(animated: true)
  }
}
