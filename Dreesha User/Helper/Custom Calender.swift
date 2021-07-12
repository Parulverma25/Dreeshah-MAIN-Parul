//
//  Custom Calender.swift
//  Dreesha User
//
//  Created by promatics on 04/05/21.
//

import Foundation
import UIKit
import WWCalendarTimeSelector

extension UIViewController{
    
    func showDateTimeCalander(selector : WWCalendarTimeSelector){
        // let selector = WWCalendarTimeSelector.instantiate()
         
         selector.optionStyles.showTime(true)
         selector.optionLayoutHeight = self.view.bounds.height / 1.2
         selector.optionTopPanelFont = UIFont.systemFont(ofSize: 14)
         selector.optionCalendarFontMonth = UIFont.systemFont(ofSize: 14)
         selector.optionSelectorPanelFontYear = UIFont.systemFont(ofSize: 14)
         selector.optionSelectorPanelFontMonth = UIFont.systemFont(ofSize: 8)
         selector.optionSelectorPanelFontDate = UIFont.systemFont(ofSize: 12)
         selector.optionBottomPanelBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         selector.optionTopPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
         selector.optionMainPanelBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
         selector.optionSelectorPanelScaleDate = 2
         selector.optionSelectorPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
         selector.optionCalendarBackgroundColorTodayHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
         selector.optionCalendarBackgroundColorFutureDatesHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)

         selector.optionCalendarBackgroundColorPastDatesHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
         selector.optionButtonFontColorCancel = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
         selector.optionButtonFontColorDone = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)

        selector.optionClockBackgroundColorMinuteHighlightNeedle =  #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorMinuteHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorMinuteHighlightNeedle = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorHourHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorHourHighlightNeedle = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorAMPMHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)

        // selector.optionLayoutTopPanelHeight = 28
        
         present(selector, animated: true, completion: nil)
     }
    
    func showDateCalander(selector : WWCalendarTimeSelector){
       // let selector = WWCalendarTimeSelector.instantiate()
        
        selector.optionStyles.showTime(false)
        selector.optionLayoutHeight = self.view.bounds.height / 1.2
        selector.optionTopPanelFont = UIFont.systemFont(ofSize: 14)
        selector.optionCalendarFontMonth = UIFont.systemFont(ofSize: 14)
        selector.optionSelectorPanelFontYear = UIFont.systemFont(ofSize: 14)
        selector.optionSelectorPanelFontMonth = UIFont.systemFont(ofSize: 8)
        selector.optionSelectorPanelFontDate = UIFont.systemFont(ofSize: 12)
        selector.optionBottomPanelBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selector.optionTopPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionMainPanelBackgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        selector.optionSelectorPanelScaleDate = 2
        selector.optionSelectorPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionCalendarBackgroundColorTodayHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionCalendarBackgroundColorFutureDatesHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)

        selector.optionCalendarBackgroundColorPastDatesHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionButtonFontColorCancel = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionButtonFontColorDone = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)

       // selector.optionLayoutTopPanelHeight = 28
       
        present(selector, animated: true, completion: nil)
    }
    
    func showTimeCalander(selector : WWCalendarTimeSelector){
        
        selector.optionLayoutHeight = self.view.bounds.height / 1.5
        
        selector.optionStyles.showDateMonth(false)
        selector.optionStyles.showTime(true)
        selector.optionStyles.showYear(false)
        
        selector.optionButtonFontColorCancel = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionButtonFontColorDone = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        
        selector.optionClockBackgroundColorMinuteHighlightNeedle =  #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorMinuteHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorMinuteHighlightNeedle = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorHourHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorHourHighlightNeedle = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        
        selector.optionClockBackgroundColorAMPMHighlight = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionTopPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        selector.optionSelectorPanelBackgroundColor = #colorLiteral(red: 0.0431372549, green: 0.2980392157, blue: 0.537254902, alpha: 1)
        present(selector, animated: true, completion: nil)
    }
}
