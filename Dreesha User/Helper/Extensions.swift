import Foundation
import UIKit
import AVFoundation

extension UIView {
    
    func addShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: 0, height: 0)
        layer.shadowOpacity = 1
        layer.shadowRadius = 5
        //layer.shouldRasterize = true
        //clipsToBounds = true
    }
    
    func roundView() {
        layer.cornerRadius = 5
        layer.masksToBounds = false
        clipsToBounds = true
    }
    
    func roundView(radius : CGFloat,borderClr : UIColor,borderWd : CGFloat , circleImg : Bool) {
        layer.masksToBounds = false
        clipsToBounds = true
        if circleImg {
            self.layer.cornerRadius = self.frame.size.width/2
            
            
        } else {
            layer.cornerRadius = radius
            
        }
        
        layer.borderColor = borderClr.cgColor
        layer.borderWidth = borderWd
        
    }
    
    func applyGradient(colours: [UIColor], locations: [NSNumber]?) {
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = self.bounds
        gradient.colors = colours.map { $0.cgColor }
        gradient.locations = locations
        self.layer.insertSublayer(gradient, at: 0)
    }
    
    func roundSpecificCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
    
}
extension UIButton {
    func btnAddShadow() {
        layer.masksToBounds = false
        layer.shadowColor = UIColor.lightGray.cgColor
        layer.shadowOffset = CGSize(width: -1, height: 1)
        layer.shadowOpacity = 0.5
        layer.shadowRadius = 0
        clipsToBounds = true
    }
    
    func btnRoundView() {
        layer.cornerRadius = 5
        layer.masksToBounds = false
        clipsToBounds = true
    }
    
    
    
    
}
extension UITextField {
    func addInputViewDatePicker(target: Any, selector: Selector) {
        
        let screenWidth = UIScreen.main.bounds.width
        
        //Add DatePicker as inputView
        let datePicker = UIDatePicker(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 216))
        datePicker.datePickerMode = .date
        self.inputView = datePicker
        
        //Add Tool Bar as input AccessoryView
        let toolBar = UIToolbar(frame: CGRect(x: 0, y: 0, width: screenWidth, height: 44))
        let flexibleSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let cancelBarButton = UIBarButtonItem(title: "Cancel", style: .plain, target: self, action: #selector(cancelPressed))
        let doneBarButton = UIBarButtonItem(title: "Done", style: .plain, target: target, action: selector)
        toolBar.setItems([cancelBarButton, flexibleSpace, doneBarButton], animated: false)
        
        self.inputAccessoryView = toolBar
    }
    
    @objc func cancelPressed() {
        self.resignFirstResponder()
    }
    
    func changePlaceholderTxtClr(color : UIColor,placeHolderStr : String) {
        
        self.attributedPlaceholder = NSAttributedString(string: placeHolderStr,
                                                        attributes: [NSAttributedString.Key.foregroundColor: color])
    }
}

extension UILabel {
    func underlineText(range1:String, range2:String) {
        if let textString = self.text {
            
            let str = NSString(string: textString)
            let firstRange = str.range(of: range1)
            let secRange = str.range(of: range2)
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: firstRange)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle, value: NSUnderlineStyle.single.rawValue, range: secRange)
            attributedText = attributedString
        }
    }
    
    func underline() {
        if let textString = self.text {
            let attributedString = NSMutableAttributedString(string: textString)
            attributedString.addAttribute(NSAttributedString.Key.underlineStyle,
                                          value: NSUnderlineStyle.single.rawValue,
                                          range: NSRange(location: 0, length: textString.count))
            self.attributedText = attributedString
        }
    }
}

extension UIViewController {
    
    func generateTransactionId(length: Int) -> String {
        var result = ""
        let base62chars = [Character]("0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz")
        let maxBase : UInt32 = 62
        let minBase : UInt16 = 32
        
        for _ in 0..<length {
            let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
            result.append(base62chars[random])
        }
        return result
    }
    func generatenumber(length: Int) -> String {
        var result = ""
        let base62chars = [Character]("0123456789")
        let maxBase : UInt32 = 10
        let minBase : UInt16 = 32
        
        for _ in 0..<length {
            let random = Int(arc4random_uniform(UInt32(min(minBase, UInt16(maxBase)))))
            result.append(base62chars[random])
        }
        return result
    }
    
    
    
    
    func GenerateUniqueName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()))
    }
    
    func GenerateUniqueImageName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()) + ".jpeg")
    }
    
    func GenerateUniqueDocName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()) + ".doc")
    }
    func GenerateUniquePdfName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()) + ".pdf")
    }
    
    func GenerateUniqueVideoName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()) + ".mp4")
    }
    
    func GenerateUniqueAudioName() -> String {
        let formatter        = DateFormatter()
        formatter.dateFormat = "yyyyMMddHHmmss"
        return (formatter.string(from: Date()) + ".mp3")
    }
}

extension Date {
    //    func currentDateString() -> String {
    //        let  dateFormatter = DateFormatter()
    //        dateFormatter.locale = .current
    //        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
    //        return dateFormatter.string(from: Date())
    //    }
    
    func toDateStr(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> String?{
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.string(from: self)
        return dateString
    }
}


extension String {
    
    
    func fromBase64() -> String? {
        guard let data = Data(base64Encoded: self) else {
            return nil
        }
        
        return String(data: data, encoding: .utf8)
    }
    
    func toBase64() -> String {
        return Data(self.utf8).base64EncodedString()
    }
    
    
    func isValidEmail() -> Bool {
        let emailRegex = "^[A-Za-z0-9._%+\\-]+@[A-Za-z0-9.\\-]+\\.[A-Za-z]{2,4}$"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return emailTest.evaluate(with: self)
    }
    
    func isValidUrl() -> Bool {
        let urlRegEx = "((?:http|https)://)?(?:www\\.)?[\\w\\d\\-_]+\\.\\w{2,3}(\\.\\w{2})?(/(?<=/)(?:[\\w\\d\\-./_]+)?)?"
        return NSPredicate(format: "SELF MATCHES %@", urlRegEx).evaluate(with: self)
    }
    
    func isValidName() -> Bool{
        let regex = try? NSRegularExpression(pattern: "^[\\p{L}\\.]{2,30}(?: [\\p{L}\\.]{2,30}){0,2}$", options: .caseInsensitive)
        return regex?.firstMatch(in: self, options: [], range: NSMakeRange(0, self.count)) != nil
    }
    
    func isValidPhone() -> Bool {
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let phoneTest = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return phoneTest.evaluate(with: self)
    }
    
    func isValidHex() -> Bool {
        let regularExpression = "^(?=.*[A-Z])(?=.*\\d)(?=.*[$#$!%*?&])[A-Za-z\\d$#$!%*?&]{6,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    func isValidPassword() -> Bool {
        let regularExpression = "^(?=.*[a-z])(?=.*[A-Z])(?=.*\\d)(?=.*[$@$!%*?&])[A-Za-z\\d$@$!%*?&]{8,}"
        let passwordValidation = NSPredicate.init(format: "SELF MATCHES %@", regularExpression)
        
        return passwordValidation.evaluate(with: self)
    }
    
    static func uniqueFilename(withSuffix suffix: String? = nil) -> String {
        let uniqueString = ProcessInfo.processInfo.globallyUniqueString
        
        if suffix != nil {
            return "\("Pracup-")-\(uniqueString)" + "\(suffix ?? "")"
        }
        
        return uniqueString
    }
    
    var dateStringToUTCString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd"
        guard let utcDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let utcString = dateFormatter.string(from: utcDate)
        return utcString
    }
    
    var dateFormatStringToUTCString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let utcDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd MMM, yyyy"
        let utcString = dateFormatter.string(from: utcDate)
        return utcString
    }
    
    var dateFormatStringToFullUTCString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let utcDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"
        let utcString = dateFormatter.string(from: utcDate)
        return utcString
    }
    
    func toDate(withFormat format: String = "yyyy-MM-dd HH:mm:ss")-> Date?{
        
        let dateFormatter = DateFormatter()
        //            dateFormatter.timeZone = TimeZone(identifier: "Asia/Tehran")
        //            dateFormatter.locale = Locale(identifier: "fa-IR")
        dateFormatter.calendar = Calendar(identifier: .gregorian)
        dateFormatter.dateFormat = format
        let date = dateFormatter.date(from: self)
        
        return date
        
    }
    
    var dateToString:String {
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let utcDate = dateFormatter.date(from: self) else { return "" }
        dateFormatter.dateFormat = "dd-MM-yyyy hh:mm a"
        let utcString = dateFormatter.string(from: utcDate)
        return utcString
    }
    
}

extension Data {
    var html2AttributedString: NSAttributedString? {
        do {
            return try NSAttributedString(data: self, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            print("error:", error)
            return  nil
        }
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}

extension String {
    var html2AttributedString: NSAttributedString? {
        return Data(utf8).html2AttributedString
    }
    var html2String: String {
        return html2AttributedString?.string ?? ""
    }
}



extension UIColor {
    class var mySystemBackground: UIColor {
        if #available(iOS 13, *) {
            return .systemBackground
        } else {
            return .white
        }
    }
}

extension URL {
    func download(to directory: FileManager.SearchPathDirectory, fileName: String? = nil, overwrite: Bool = false, completion: @escaping (URL?, Error?) -> Void) throws {
        let directory = try FileManager.default.url(for: directory, in: .userDomainMask, appropriateFor: nil, create: true)
        let destination: URL
        if let fileName = fileName {
            destination = directory
                .appendingPathComponent(fileName)
                .appendingPathExtension(self.pathExtension)
        } else {
            destination = directory
                .appendingPathComponent(lastPathComponent)
        }
        if !overwrite, FileManager.default.fileExists(atPath: destination.path) {
            completion(destination, nil)
            return
        }
        URLSession.shared.downloadTask(with: self) { location, _, error in
            guard let location = location else {
                completion(nil, error)
                return
            }
            do {
                if overwrite, FileManager.default.fileExists(atPath: destination.path) {
                    try FileManager.default.removeItem(at: destination)
                }
                try FileManager.default.moveItem(at: location, to: destination)
                completion(destination, nil)
            } catch {
                print(error)
            }
        }.resume()
    }
}
