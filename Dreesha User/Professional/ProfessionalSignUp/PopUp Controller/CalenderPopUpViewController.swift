//
//  CalenderPopUpViewController.swift
//  Dreesha User
//
//  Created by Apple on 08/04/21.
//

import UIKit
import FSCalendar

protocol SelectDate {
    func onDate(date: String)
}

class CalenderPopUpViewController: UIViewController, FSCalendarDelegate, FSCalendarDataSource {
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd-MM-yyyy"
        return formatter
    }()
    
    @IBOutlet weak var calenderView: FSCalendar!
    var maxDateReq = true
    var multipleVal = false
    var dateValue: String!
    var delegate: SelectDate?
    var firstDate: Date!
    var lastDate: Date!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if multipleVal == true{
            calenderView.allowsMultipleSelection = true
        }
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if multipleVal{
            if(firstDate != nil && lastDate != nil){
            dateValue = self.formatter.string(from: firstDate) + " - " + self.formatter.string(from: lastDate)
            }
        }
        if let s = dateValue {
            delegate?.onDate(date: s)
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        if !multipleVal{
       
        dateValue = self.formatter.string(from: date)
        }else{
        
            if firstDate == nil {
                    firstDate = date
                    return
                }

                // only first date is selected:
                if firstDate != nil && lastDate == nil {
                    // handle the case of if the last date is less than the first date:
                    if date <= firstDate! {
                        calendar.deselect(firstDate!)
                        firstDate = date

                        return
                    }
                    lastDate = date
                    return
                }
                if firstDate != nil && lastDate != nil {
                    for d in calendar.selectedDates {
                        calendar.deselect(d)
                    }

                    lastDate = nil
                    firstDate = nil

                }
            }
    }

            func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
                // both are selected:

                // NOTE: the is a REDUANDENT CODE:
                if firstDate != nil && lastDate != nil {
                    for d in calendar.selectedDates {
                        calendar.deselect(d)
                    }
                    lastDate = nil
                    firstDate = nil
                }
            }
    func maximumDate(for calendar: FSCalendar) -> Date {
        if maxDateReq == false{
            let mDate = "01-01-2100"
            let maxDate = self.formatter.date(from: mDate)
            return maxDate ?? Date()
        }else{
            return Date()
        }
    }
}
