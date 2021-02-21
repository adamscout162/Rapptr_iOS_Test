//
//  LoginViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class LoginViewController: UIViewController, HeaderViewDelegate {
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Take email and password input from the user
     *
     * 3) Use the endpoint and paramters provided in LoginClient.m to perform the log in
     *
     * 4) Calculate how long the API call took in milliseconds
     *
     * 5) If the response is an error display the error in a UIAlertController
     *
     * 6) If the response is successful display the success message AND how long the API call took in milliseconds in a UIAlertController
     *
     * 7) When login is successful, tapping 'OK' in the UIAlertController should bring you back to the main menu.
     **/
    
    // MARK: - Properties
    private var client: LoginClient?
    private let headerTitle = "Login"
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = headerTitle
        setupViews()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Actions
    
    func backButtonPressed(headerView: HeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let startDate = Date()
        
        LoginClient().login(withEmail: emailTextField.text, password: passwordTextField.text) { (returnDictionary) in // [AnyHashable: Any]?
            let executionTime = Date().timeIntervalSince(startDate)
            let executionTimeInSeconds = Double(executionTime.truncatingRemainder(dividingBy: 60))
            print("Execution Time: \(executionTimeInSeconds)")
            let statusCode = returnDictionary?["status code"]
            if let statusCode = statusCode, statusCode as? Int == 200 {
                print("status code: \(statusCode)")
                self.showAlert(message: "Logged In! \n Login took: \(String(format: "%.3f", executionTimeInSeconds)) seconds")
            } else if let error = returnDictionary?["error"] {
                self.showAlert(message: "There was an error logging in, please retry later. \n Error: \(error)")
            } else {
                self.showAlert(message: "Unknown Error occurred, please retry later.")
            }
        }
    }
    
    func showAlert(message: String) {
        let alertController = UIAlertController(title: "Login Result", message: message, preferredStyle: .alert)
        let okayAction = UIAlertAction(title: "OK", style: .cancel) { _ in
            self.navigationController?.popViewController(animated: true)
        }
        
        alertController.addAction(okayAction)
        
        DispatchQueue.main.async {
            self.present(alertController, animated: true, completion: nil)
        }
    }
    
    func setupViews() {
        let header = HeaderView(title: headerTitle, showBackButton: true)
        header.delegate = self
        view.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.topMargin).offset(64)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let emailPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 55))
        emailTextField.leftView = emailPaddingView
        emailTextField.leftViewMode = .always
        emailTextField.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 0.8)
        emailTextField.alpha = 0.8
        
        let passwordPaddingView = UIView(frame: CGRect(x: 0, y: 0, width: 24, height: 55))
        passwordTextField.leftView = passwordPaddingView
        passwordTextField.leftViewMode = .always
        passwordTextField.backgroundColor = #colorLiteral(red: 0.9764705882, green: 0.9764705882, blue: 0.9764705882, alpha: 0.8)
        passwordTextField.alpha = 0.8
        
        let background = UIImage(named: "img_login")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = background
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
        
        emailTextField.layer.cornerRadius = 8
        passwordTextField.layer.cornerRadius = 8
    }
}
