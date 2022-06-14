//
//  ViewController.swift
//  proiectios
//
//  Created by user216341 on 6/13/22.
//


import UIKit
import FirebaseAuth
import SafariServices
import UserNotifications

class ViewController: UIViewController {
    @IBOutlet weak var filmebuton: UIButton!
    @IBOutlet weak var siteewbbuton: UIButton!
    @IBOutlet weak var videobuton: UIButton!
    
    @IBAction func Site(_ sender: UIButton) {
        if let url = URL(string:
                    "https://imdb.com"){
            let safariVC = SFSafariViewController(url: url)
            present(safariVC, animated: true,completion: nil)
        }
    }
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.text = "Log In"
        label.font = .systemFont(ofSize: 24, weight: .semibold)
        return label
    }()

    private let emailField: UITextField = {
        let emailField = UITextField()
        emailField.placeholder = "Email Address"
        emailField.layer.borderWidth = 1
        emailField.autocapitalizationType = .none
        emailField.layer.borderColor = UIColor.black.cgColor
        emailField.backgroundColor = .white
        emailField.leftViewMode = .always
        emailField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return emailField
    }()
    
    private let passwordField: UITextField = {
        let passField = UITextField()
        passField.placeholder = "Password Address"
        passField.layer.borderWidth = 1
        passField.isSecureTextEntry = true
        passField.layer.borderColor = UIColor.black.cgColor
        passField.backgroundColor = .white
        passField.leftViewMode = .always
        passField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 5, height: 0))
        return passField
    }()
    
    private let button: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        return button
    }()
    
    
    private let signOutButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = .systemGreen
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Log Out", for: .normal)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(label)
        view.addSubview(emailField)
        view.addSubview(passwordField)
        view.addSubview(button)
        filmebuton.isHidden = true
        siteewbbuton.isHidden = true
        videobuton.isHidden = true
        view.backgroundColor = .systemPurple
        button.addTarget(self, action: #selector(didTapButton), for: .touchUpInside)
        
        let center = UNUserNotificationCenter.current()
        
        center.requestAuthorization(options: [.alert, .sound])
        {
            (granted, error) in
            
        }
        
        let content = UNMutableNotificationContent()
        content.title = "notificare 1"
        content.body = "notificare 2"
        
        let date = Date().addingTimeInterval(5)
        
        let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute, .second], from: date)
        
        let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
        
        let uuidString = UUID().uuidString
        
        let request = UNNotificationRequest(identifier: uuidString, content: content, trigger: trigger)
        
        center.add(request){ (error) in
            
        }
        
        
        if FirebaseAuth.Auth.auth().currentUser != nil {
            label.isHidden = true
            button.isHidden = true
            emailField.isHidden = true
            passwordField.isHidden = true
            filmebuton.isHidden = false
            siteewbbuton.isHidden = false
            videobuton.isHidden = false
            view.addSubview(signOutButton)
            signOutButton.frame = CGRect(x: 20, y: 150, width: view.frame.size.width-40, height: 52)
            signOutButton.addTarget(self, action: #selector(logOutTapped), for: .touchUpInside)
        }
    }

    
    @objc private func logOutTapped() {
        do {
            try FirebaseAuth.Auth.auth().signOut()
            
            label.isHidden = false
            button.isHidden = false
            emailField.isHidden = false
            passwordField.isHidden = false
            filmebuton.isHidden = true
            siteewbbuton.isHidden = true
            videobuton.isHidden = true
            signOutButton.removeFromSuperview()
        }
        catch {
            print("An error occurred")
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        label.frame = CGRect(x: 0, y:100, width: view.frame.size.width, height: 80)
        
        emailField.frame = CGRect(x: 20,
                                  y: label.frame.origin.y+label.frame.size.height+10,
                                  width: view.frame.size.width-40,
                                  height: 50)
        
        passwordField.frame = CGRect(x: 20,
                                     y: emailField.frame.origin.y+emailField.frame.size.height+10,
                                     width: view.frame.size.width-40,
                                     height: 50)
        
        button.frame = CGRect(x: 20,
                              y: passwordField.frame.origin.y+passwordField.frame.size.height+30,
                              width: view.frame.size.width-40,
                              height: 52)
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if FirebaseAuth.Auth.auth().currentUser == nil {
            emailField.becomeFirstResponder()
        }
        emailField.becomeFirstResponder()
    }

    @objc private func didTapButton() {
        print("Continue button tapped")
        guard let email = emailField.text, !email.isEmpty,
              let password = passwordField.text, !password.isEmpty else {
            print("Missing field data")
                return
        }
        
        // Get auth instance
        // attempt sign in
        // if failure, present alert to create account
        // if user continues, create account
        
        // check sign in on app launch
        // allow user to sign out with button
        
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard let strongSelf = self else {
                return
            }
            
            guard error == nil else {
                // show account creation
                strongSelf.showCreateAccount(email: email, password: password)
                return
            }
            
            print("You have signed in")
            strongSelf.label.isHidden = true
            strongSelf.emailField.isHidden = true
            strongSelf.passwordField.isHidden = true
            strongSelf.button.isHidden = true
            strongSelf.filmebuton.isHidden = false
            strongSelf.siteewbbuton.isHidden = false
            strongSelf.videobuton.isHidden = false
            strongSelf.emailField.resignFirstResponder()
            strongSelf.passwordField.resignFirstResponder()
        } )

    }
    
    func showCreateAccount(email: String, password: String) {
            let alert = UIAlertController(title: "Create Account",
                                          message: "Would you like to create an account",
                                          preferredStyle: .alert)
            alert.addAction(UIAlertAction(title:"Continue",
                                          style: .default,
                                          handler: {_ in
                
                FirebaseAuth.Auth.auth().createUser(withEmail: email, password: password, completion: { [weak self] result, error in
                
                    guard let strongSelf = self else {
                        return
                    }
                    
                    guard error == nil else {
                        // show account creation
                        print("Account cvreation failed")
                        return
                    }
                    
                    print("You have signed in")
                    strongSelf.label.isHidden = true
                    strongSelf.emailField.isHidden = true
                    strongSelf.passwordField.isHidden = true
                    strongSelf.button.isHidden = true
                    strongSelf.filmebuton.isHidden = false
                    strongSelf.siteewbbuton.isHidden = false
                    strongSelf.videobuton.isHidden = false
                    strongSelf.emailField.resignFirstResponder()
                    strongSelf.passwordField.resignFirstResponder()                })
                
            }))
            alert.addAction(UIAlertAction(title:"Cancel",
                                          style: .cancel,
                                          handler: {_ in
                                         
            }))
        
            present(alert, animated: true)
        }
        
    
}

