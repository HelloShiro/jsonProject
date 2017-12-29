//
//  PageTwo.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit

class PageTwo: UICollectionViewController, UICollectionViewDelegateFlowLayout  {
    
    let cellId = "cellId"
    var countryCount: Int = 0
    
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

    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView?.backgroundColor = UIColor.white
        collectionView?.register(PrefectureCell.self, forCellWithReuseIdentifier: cellId)
        collectionView?.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        collectionView?.scrollIndicatorInsets = UIEdgeInsetsMake(50, 0, 0, 0)
        view.addSubview(navigationView)
        
        setupNavigationViews()
        
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handlePop))
        swipeLeft.direction = UISwipeGestureRecognizerDirection.left
        self.view.addGestureRecognizer(swipeLeft)
    }
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary {
                    
                    let regionArrays = jsonResult["regions"] as? NSArray
                    if regionArrays != nil {
                        countryCount =  (regionArrays?.count)!
                    }else {
                        countryCount = 0
                    }
                }
            }catch let err {
                print(err)
            }
        }
        return countryCount
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PrefectureCell
        
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary {
                    
                    let regionArrays = jsonResult["regions"] as? NSArray
                    let regionDics = regionArrays![indexPath.item] as? NSDictionary
                    cell.labelPrefecture.text = regionDics!["name"] as? String
                    cell.labelHIRAGANA.text = regionDics!["hiragana"] as? String
                    let imageUrl = URL(string: regionDics!["image"] as! String)
                    let imageRequest  = URLRequest(url: imageUrl!)
                    let task = URLSession.shared.dataTask(with: imageRequest, completionHandler: { (data, response, error) in
                        if error != nil {
                            print(error!)
                        }else {
                            if let imageData = data {
                                DispatchQueue.main.async {
                                    cell.imagePrefecture.image = UIImage(data: imageData)
                                }
                            }
                        }
                    })
                    task.resume()
                }
            }catch let err {
                print(err)
            }
        }

        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: 65)
    }
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let layout = UICollectionViewFlowLayout()
        let pageThree = PageThree(collectionViewLayout: layout)
        if let path = Bundle.main.path(forResource: "test", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path))
                if let jsonResult = try JSONSerialization.jsonObject(with: data, options: .mutableLeaves) as? NSDictionary {
                    let regionArrays = jsonResult["regions"] as? NSArray
                    let selectedDics = regionArrays![indexPath.item] as? NSDictionary
                    pageThree.countryName = selectedDics!["name"] as? String
                    pageThree.index = indexPath.item
                    let selectedPrefectureDics = selectedDics!["prefecture"] as? NSArray
                    if selectedPrefectureDics != nil {
                        pageThree.totalIndex = (selectedPrefectureDics?.count)!
                    }else {
                        pageThree.totalIndex = 0
                    }
                }
            }catch let err {
                print(err)
            }
        }
        
        present(pageThree, animated: true, completion: nil)
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
}

