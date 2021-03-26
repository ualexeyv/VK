//
//  ViewController.swift
//  P2L2
//
//  Created by пользовтель on 03.02.2021.
//

import UIKit

class LogInScreen: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var scrollView: UIScrollView!
    let login = "admin"
  
    let password = "12345"

    @IBAction func buttonTapped(_ sender: Any) {
        if loginField.text == "admin", passwordField.text == "12345" {
            print ("верно")
        } else {
            print ("ошибка")
        }
    
    }
    @objc func keyboardWasShown (notification: Notification) {
        let info = notification.userInfo! as NSDictionary
        let kbSize = (info.value(forKey: UIResponder.keyboardFrameEndUserInfoKey) as! NSValue).cgRectValue.size
        let contentInsets = UIEdgeInsets (top: 0.0, left: 0.0, bottom: kbSize.height, right: 0.0)
        self.scrollView?.contentInset = contentInsets
        scrollView?.scrollIndicatorInsets = contentInsets
    }
    @objc func keyboardWillBeHidden (notification: Notification) {
        let contentInsets = UIEdgeInsets.zero
        scrollView?.contentInset = contentInsets
    }
    override func viewWillAppear(_ animated: Bool) {
        downloadIndicatorAnimate()
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWasShown), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let hideKeabordGesture = UITapGestureRecognizer (target: self, action: #selector(hideKeyboard))
        scrollView?.addGestureRecognizer(hideKeabordGesture)
        self.view.backgroundColor = UIColor (patternImage: UIImage (named: "background")!)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    @objc func hideKeyboard () {
        self.scrollView?.endEditing(true)
    }
    @IBAction func logOutAction (unwindSegue: UIStoryboardSegue) {
        loginField.text = ""
        passwordField.text = ""
    }
    private func checkLogAndPass() -> Bool {
        return loginField.text == login && passwordField.text == password
    }
    private func pointPrepare (cView: UIView, delay: Double) {
        cView.backgroundColor = .black
        cView.layer.cornerRadius = 2
        cView.layer.masksToBounds = true
        cView.alpha = 1
        view.addSubview(cView)
        UIView.animate(withDuration: 0.5, delay: delay, options: [.repeat, .autoreverse]) {
            cView.alpha = 0
        }
    }
    
    let point1 = UIView(frame: CGRect(x: 100, y: 350, width: 4, height: 4))
    let point2 = UIView(frame: CGRect(x: 105, y: 350, width: 4, height: 4))
    let point3 = UIView(frame: CGRect(x: 110, y: 350, width: 4, height: 4))
    
    private func downloadIndicatorAnimate () {
        pointPrepare(cView: point1, delay: 0)
        pointPrepare(cView: point2, delay: 0.2)
        pointPrepare(cView: point3, delay: 0.4)
        
    }
    
    override func shouldPerformSegue(withIdentifier identifier: String, sender: Any?) -> Bool {
        if identifier == "logInScreen" {
            
                if checkLogAndPass() {
                    downloadIndicatorAnimate()
                    return true
                } else {
                    let alert = UIAlertController (title: "Alert", message: "wrong password", preferredStyle: .alert)
                    let action = UIAlertAction (title: "OK", style: .default) { (action) in
                        self.loginField.text = ""
                        self.passwordField.text = ""
                    }
                    alert.addAction(action)
                    self.present(alert, animated: true, completion: nil)
                    
                }
            
        }
        return true
    }

}


