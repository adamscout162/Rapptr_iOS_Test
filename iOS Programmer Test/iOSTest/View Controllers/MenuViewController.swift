//
//  MenuViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import Foundation
import UIKit
import SnapKit

class MenuViewController: UIViewController {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     *
     * 1) UI must work on iOS phones of multiple sizes. Do not worry about iPads.
     *
     * 2) Use Autolayout to make sure all UI works for each resolution
     *
     * 3) Use this starter project as a base and build upon it. It is ok to remove some of the
     *    provided code if necessary. It is ok to add any classes. This is your project now!
     *
     * 4) Read the additional instructions comments throughout the codebase, they will guide you.
     *
     * 5) Please take care of the bug(s) we left for you in the project as well. Happy hunting!
     *
     * Thank you and Good luck. - Rapptr Labs
     * =========================================================================================
     */
    
    // MARK: - Outlets
    @IBOutlet weak var chatButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var animationButton: UIButton!
    
    let headerTitle = "Coding Tasks"
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = headerTitle
        setupViews()
    }
    
    // MARK: - Actions
    @IBAction func didPressChatButton(_ sender: Any) {
        let chatViewController = ChatViewController()
        navigationController?.pushViewController(chatViewController, animated: true)
    }
    
    @IBAction func didPressLoginButton(_ sender: Any) {
        let loginViewController = LoginViewController()
        navigationController?.pushViewController(loginViewController, animated: true)
    }
    
    @IBAction func didPressAnimationButton(_ sender: Any) {
        let animationViewController = AnimationViewController()
        navigationController?.pushViewController(animationViewController, animated: true)
    }
    
    func setupViews() {
        let header = HeaderView(title: headerTitle, showBackButton: false)
        view.addSubview(header)
        
        header.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.height.equalTo(64)
            $0.leading.equalToSuperview()
            $0.trailing.equalToSuperview()
        }
        
        let background = UIImage(named: "bg_home_menu")
        
        let backgroundImage = UIImageView(frame: UIScreen.main.bounds)
        backgroundImage.image = background
        backgroundImage.contentMode = UIView.ContentMode.scaleAspectFill
        view.insertSubview(backgroundImage, at: 0)
    }
}
