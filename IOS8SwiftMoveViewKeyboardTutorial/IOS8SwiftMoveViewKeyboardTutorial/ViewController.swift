//
//  ViewController.swift
//  IOS8SwiftMoveViewKeyboardTutorial
//
//  Created by Arthur Knopper on 23/08/14.
//  Copyright (c) 2014 Arthur Knopper. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var textField: UITextField!
   
    var kbHeight: CGFloat = 20.0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.delegate = self
    }
   
    func animateTextField(up: Bool) {
        
        let movement = (up ? -kbHeight : kbHeight)

        UIView.animateWithDuration(0.3, animations: {
            
            self.view.frame = CGRectOffset(self.view.frame, 0, movement)
        })
    }
  
    override func viewWillAppear(animated:Bool) {
        super.viewWillAppear(animated)
    
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
    }
  
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    
    func keyboardWillShow(notification : NSNotification) {
        
        let keyboardInfo : NSDictionary = notification.userInfo!
        
        let kbSize : CGSize = ((keyboardInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)) as! CGRect).size
        
        
        let durationValue : NSNumber = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration : NSTimeInterval = durationValue.doubleValue
        
        let rawAnimationCurveValue = (keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntegerValue
        let keyboardAnimationCurve = UIViewAnimationCurve(rawValue: Int(rawAnimationCurveValue))
        
        let options = UIViewAnimationOptions(rawValue: UInt((keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
        
        UIView.animateWithDuration(animationDuration, delay: 0, options:options , animations: { () -> Void in
            
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y - kbSize.height, self.view.frame.size.width, self.view.frame.size.height)
            
            }, completion: nil)
    }
  
    
    
    func keyboardWillHide(notification : NSNotification) {
        
        let keyboardInfo : NSDictionary = notification.userInfo!
        
        let kbSize : CGSize = ((keyboardInfo.objectForKey(UIKeyboardFrameEndUserInfoKey)) as! CGRect).size
        
        
        let durationValue : NSNumber = keyboardInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSNumber
        let animationDuration : NSTimeInterval = durationValue.doubleValue
        
        let rawAnimationCurveValue = (keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).unsignedIntegerValue
        let keyboardAnimationCurve = UIViewAnimationCurve(rawValue: Int(rawAnimationCurveValue))
        
        let options = UIViewAnimationOptions(rawValue: UInt((keyboardInfo[UIKeyboardAnimationCurveUserInfoKey] as! NSNumber).integerValue << 16))
        
        UIView.animateWithDuration(animationDuration, delay: 0, options:options , animations: { () -> Void in
            
            self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y + kbSize.height, self.view.frame.size.width, self.view.frame.size.height)
            
            }, completion: nil)
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        
        return true
    }
    
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
    
    
    


}

