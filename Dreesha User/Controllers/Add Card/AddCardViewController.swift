//
//  AddCardViewController.swift
//  Dreesha User
//
//  Created by Apple on 16/03/21.
//

import UIKit

class AddCardViewController: UIViewController {
    //Mark Outlets
    @IBOutlet weak var numberTxt: SkyFloatingLabelTextField!
    private var previousTextFieldContent: String?
    private var previousSelection: UITextRange?
    
    
    @IBOutlet weak var nameTxt: SkyFloatingLabelTextField!
    
    @IBOutlet weak var expiryTxt: SkyFloatingLabelTextField!
    @IBOutlet weak var cvvTxt: SkyFloatingLabelTextField!
    
    //Mark ViewDidLoad
    override func viewDidLoad() {
        super.viewDidLoad()
        self.hideKeyboardWhenTappedAround()
        numberTxt.addTarget(self, action: #selector(reformatAsCardNumber), for: .editingChanged)

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        setBackWithTitle(titleVal: "Add Debit Card")
    }
    
    //Mark Actions
    @IBAction func addPaymentMethod(_ sender: Any) {
        let vc = storyboard?.instantiateViewController(identifier: "PaymentMethodViewController") as! PaymentMethodViewController
        navigationController?.pushViewController(vc, animated: true)
    }
    
    @objc func reformatAsCardNumber(textField: UITextField) {
        var targetCursorPosition = 0
        if let startPosition = textField.selectedTextRange?.start {
            targetCursorPosition = textField.offset(from: textField.beginningOfDocument, to: startPosition)
        }
        
        var cardNumberWithoutSpaces = ""
        if let text = textField.text {
            cardNumberWithoutSpaces = self.removeNonDigits(string: text, andPreserveCursorPosition: &targetCursorPosition)
        }
        
        if cardNumberWithoutSpaces.count > 16 {
            textField.text = previousTextFieldContent
            textField.selectedTextRange = previousSelection
            return
        }
        
        let cardNumberWithSpaces = self.insertSpacesEveryFourDigitsIntoString(string: cardNumberWithoutSpaces, andPreserveCursorPosition: &targetCursorPosition)
        textField.text = cardNumberWithSpaces
        
        if let targetPosition = textField.position(from: textField.beginningOfDocument, offset: targetCursorPosition) {
            textField.selectedTextRange = textField.textRange(from: targetPosition, to: targetPosition)
        }
    }

    func removeNonDigits(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var digitsOnlyString = ""
        let originalCursorPosition = cursorPosition
        
        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            if characterToAdd >= "0" && characterToAdd <= "9" {
                digitsOnlyString.append(characterToAdd)
            }
            else if i < originalCursorPosition {
                cursorPosition -= 1
            }
        }
        
        return digitsOnlyString
    }

    func insertSpacesEveryFourDigitsIntoString(string: String, andPreserveCursorPosition cursorPosition: inout Int) -> String {
        var stringWithAddedSpaces = ""
        let cursorPositionInSpacelessString = cursorPosition
        
        for i in Swift.stride(from: 0, to: string.count, by: 1) {
            if i > 0 && (i % 4) == 0 {
                stringWithAddedSpaces.append(contentsOf: " ")
                if i < cursorPositionInSpacelessString {
                    cursorPosition += 1
                }
            }
            let characterToAdd = string[string.index(string.startIndex, offsetBy: i)]
            stringWithAddedSpaces.append(characterToAdd)
        }
        
        return stringWithAddedSpaces
    }
    
}
extension AddCardViewController : UITextFieldDelegate{
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        if textField == numberTxt {
            previousTextFieldContent = textField.text;
            previousSelection = textField.selectedTextRange;
        }
        
        return true
    }
    
}
