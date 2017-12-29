//
//  PageThree.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

//
//  PageTwo.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

class PageFour: UIViewController, UIWebViewDelegate {


    var countryURL: String?
    
    var bottomConstraint: NSLayoutConstraint?
    
    let navigationView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(red: 226/255, green: 240/255, blue: 218/255, alpha: 1)
        return view
    }()
    
    let navigationTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "List"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor.black
        return label
    }()
    let navigationBackButton: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        let image = UIImage(named: "left")?.withRenderingMode(.alwaysTemplate)
        btn.setImage(image, for: UIControlState.normal)
        btn.backgroundColor =  UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        btn.tintColor = UIColor.black
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
        btn.addTarget(self, action: #selector(handlePop), for: .touchUpInside)
        return btn
    }()

    let navigationDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()

    @objc func handlePop() {
        self.dismiss(animated: true, completion: nil)
        memoTextView.text = ""
    }

    func setupNavigationViews() {
        navigationView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        navigationView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        navigationView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        navigationView.heightAnchor.constraint(equalToConstant: 50).isActive = true
        navigationView.addSubview(navigationTitle)
        navigationTitle.centerXAnchor.constraint(equalTo: navigationView.centerXAnchor).isActive = true
        navigationTitle.centerYAnchor.constraint(equalTo: navigationView.centerYAnchor).isActive = true
        navigationView.addSubview(navigationBackButton)
        navigationBackButton.leftAnchor.constraint(equalTo: navigationView.leftAnchor, constant: 5).isActive = true
        navigationBackButton.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor, constant: -5).isActive = true
        navigationBackButton.widthAnchor.constraint(equalToConstant: 40).isActive = true
        navigationBackButton.heightAnchor.constraint(equalToConstant: 40).isActive = true
        navigationView.addSubview(navigationDivider)
        navigationDivider.leftAnchor.constraint(equalTo: navigationView.leftAnchor).isActive = true
        navigationDivider.bottomAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        navigationDivider.widthAnchor.constraint(equalTo: navigationView.widthAnchor, constant: 1).isActive = true
        navigationDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
    

    let webView: UIWebView = {
        let view = UIWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let webViewDivider: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let memoView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor.white
        return view
    }()
    
    let memoLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Memo"
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    let saveButton: UIButton = {
       let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Save", for: UIControlState.normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        button.setTitleColor(UIColor.black, for: UIControlState.normal)
        button.backgroundColor = UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        button.setTitleColor(UIColor.white, for: UIControlState.highlighted)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        button.addTarget(self, action: #selector(handleSave), for: .touchUpInside)
        return button
    }()
    
    @objc private func handleSave() {
        UserDefaults.standard.set(memoTextView.text, forKey:navigationTitle.text!)
        bottomConstraint?.constant = 0
        UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        memoTextView.endEditing(true)
    }
    
    
    let memoTextView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.backgroundColor = UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        textView.font = UIFont.systemFont(ofSize: 17)
        textView.layer.borderWidth = 1
        textView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return textView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(navigationView)
        setupNavigationViews()
        view.backgroundColor = UIColor.white
        view.addSubview(memoView)
        view.addSubview(webViewDivider)
        view.addSubview(webView)
        setupLayout()
        
        webView.delegate = self
        let url = URL(string: countryURL!)
        let request = URLRequest(url: url!)
        webView.loadRequest(request)

        let memoText = UserDefaults.standard.object(forKey: navigationTitle.text!)
        if let memo = memoText as? String {
            memoTextView.text = memo
        }
        
        bottomConstraint = NSLayoutConstraint(item: memoView, attribute: NSLayoutAttribute.bottom, relatedBy: NSLayoutRelation.equal, toItem: view, attribute: NSLayoutAttribute.bottom, multiplier: 1, constant: 0)
        view.addConstraint(bottomConstraint!)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlePop))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    @objc private func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = (userInfo[UIKeyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue
            let isKeyBoardShowing = notification.name == NSNotification.Name.UIKeyboardWillShow
            
            bottomConstraint?.constant = isKeyBoardShowing ?  -keyboardFrame!.height : 0
            UIView.animate(withDuration: 0, delay: 0, options: UIViewAnimationOptions.curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    private func setupLayout() {
        webViewDivider.topAnchor.constraint(equalTo: webView.bottomAnchor).isActive = true
        webViewDivider.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webViewDivider.heightAnchor.constraint(equalToConstant: 1).isActive = true
        webViewDivider.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        memoView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        memoView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        memoView.heightAnchor.constraint(equalToConstant: 100).isActive = true
        memoView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 1).isActive = true
        memoView.addSubview(memoTextView)
        memoTextView.bottomAnchor.constraint(equalTo: memoView.bottomAnchor, constant: -5).isActive = true
        memoTextView.rightAnchor.constraint(equalTo: memoView.rightAnchor, constant: -5).isActive = true
        memoTextView.heightAnchor.constraint(equalToConstant: 100 - 27).isActive = true
        memoTextView.widthAnchor.constraint(equalTo: memoView.widthAnchor, constant: -10).isActive = true
        memoView.addSubview(memoLabel)
        memoLabel.leftAnchor.constraint(equalTo: memoTextView.leftAnchor).isActive = true
        memoLabel.bottomAnchor.constraint(equalTo: memoTextView.topAnchor, constant: -5).isActive = true
        memoLabel.topAnchor.constraint(equalTo: memoView.topAnchor, constant: 5).isActive = true
        memoView.addSubview(saveButton)
        saveButton.rightAnchor.constraint(equalTo: memoTextView.rightAnchor).isActive = true
        saveButton.bottomAnchor.constraint(equalTo: memoTextView.topAnchor, constant: -5).isActive = true
        saveButton.heightAnchor.constraint(equalToConstant: 12).isActive = true
        saveButton.widthAnchor.constraint(equalToConstant: 70).isActive = true
        
        webView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        webView.topAnchor.constraint(equalTo: navigationView.bottomAnchor).isActive = true
        webView.bottomAnchor.constraint(equalTo: memoView.topAnchor).isActive = true
        webView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
    }
    
    
    
    
}



