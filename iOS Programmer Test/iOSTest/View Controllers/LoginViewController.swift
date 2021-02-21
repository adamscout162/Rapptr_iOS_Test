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
    }
    
    func setupViews() {
        let header = HeaderView(title: headerTitle, showBackButton: true)
        header.delegate = self
        view.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let background = UIImage(named: "img_login")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = background
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
