//
//  ViewController.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

class PageOne: UIViewController {

    let btnGotoList: UIButton = {
        let btn = UIButton()
        btn.translatesAutoresizingMaskIntoConstraints = false
        btn.backgroundColor = UIColor(red: 218/255, green: 227/255, blue: 242/255, alpha: 1)
        btn.setTitle("Go To List", for: .normal)
        btn.titleLabel?.font = UIFont.systemFont(ofSize: 17)
        btn.layer.borderWidth = 1
        btn.layer.borderColor = UIColor(red: 96/255, green: 96/255, blue: 96/255, alpha: 1).cgColor
        btn.setTitleColor(UIColor.black, for: .normal)
        btn.addTarget(self, action: #selector(handleGoToList), for: .touchUpInside)
        return btn
    }();
    
    @objc func handleGoToList() {
        let layout = UICollectionViewFlowLayout()
        let pageTwo = PageTwo(collectionViewLayout: layout)
        present(pageTwo, animated: true, completion: nil)

//        navigationController?.pushViewController(pageTwo, animated: true)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        setupView()
    }
    
    private func setupView() {
        view.addSubview(btnGotoList)
        btnGotoList.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        btnGotoList.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        btnGotoList.widthAnchor.constraint(equalToConstant: 150).isActive = true
        btnGotoList.heightAnchor.constraint(equalToConstant: 50).isActive = true
    }
}

