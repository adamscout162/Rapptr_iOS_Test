//
//  AnimationViewController.swift
//  iOSTest
//
//  Copyright © 2020 Rapptr Labs. All rights reserved.

import UIKit

class AnimationViewController: UIViewController, HeaderViewDelegate {
    
    /**
     * =========================================================================================
     * INSTRUCTIONS
     * =========================================================================================
     * 1) Make the UI look like it does in the mock-up.
     *
     * 2) Logo should fade out or fade in when the user hits the Fade In or Fade Out button
     *
     * 3) User should be able to drag the logo around the screen with his/her fingers
     *
     * 4) Add a bonus to make yourself stick out. Music, color, fireworks, explosions!!! Have Swift experience? Why not write the Animation 
     *    section in Swfit to show off your skills. Anything your heart desires!
     *
     **/
    
    private let headerTitle = "Animation"
    @IBOutlet weak var logoView: UIImageView!
    
    // MARK: - Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        title = headerTitle
        
        setupViews()
    }
    
    // MARK: - Actions
    func backButtonPressed(headerView: HeaderView) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func didPressFade(_ sender: Any) {
        if logoView.alpha == 1.0 {
            UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseOut, animations: {
                self.logoView.alpha = 0.0
            })
        } else {
            UIView.animate(withDuration: 3.0, delay: 0, options: .curveEaseIn, animations: {
                self.logoView.alpha = 1.0
            })
        }
    }
    
    @objc func handlePan(recognizer:UIPanGestureRecognizer) {
        
        let translation = recognizer.translation(in: self.view)
        if let view = recognizer.view {
            view.center = CGPoint(x:view.center.x + translation.x,
                                  y:view.center.y + translation.y)
        }
        recognizer.setTranslation(CGPoint.zero, in: self.view)
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
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePan))
        logoView.addGestureRecognizer(panGesture)
    }
}
