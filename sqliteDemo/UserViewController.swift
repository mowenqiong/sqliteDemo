//
//  UserViewController.swift
//  sqliteDemo
//
//  Created by mo on 15-4-16.
//  Copyright (c) 2015 sscf88. All rights reserved.
//

import UIKit

class UserViewController: UIViewController,UITextFieldDelegate {

    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var nameField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func saveUser(sender: UIButton) {

        if self.nameField.text.isEmpty {
            var alert = UIAlertView(title:"提示",message:"请输入用户名",delegate:self,cancelButtonTitle:"好的")
            alert.show()
            return
            
        }
        
        var user = UserModel()
        user.name = self.nameField.text
        user.age = self.ageField.text
        user.password = self.passwordField.text
        
        UserDao.getInstance().addUser(user)
        self.navigationController!.popViewControllerAnimated(true)
    }
    
    override func touchesEnded(touches: NSSet, withEvent event: UIEvent) {
        self.nameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.ageField.resignFirstResponder()
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool{
        self.nameField.resignFirstResponder()
        self.passwordField.resignFirstResponder()
        self.ageField.resignFirstResponder()
        return true
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
