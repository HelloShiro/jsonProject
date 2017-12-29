//
//  PrefectureCell.swift
//  ITI Project
//
//  Created by SnoopyKing on 2017/12/20.
//  Copyright © 2017年 SnoopyKing. All rights reserved.
//

import UIKit
class PrefectureCell: BaseCell {
    
//    var prefecture: Prefecture? {
//        didSet {
//            labelPrefecture.text = prefecture?.prefectureName
//
//        }
//    }
//    
    
    
    let imagePrefecture: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
//        imageView.backgroundColor = .blue
        imageView.contentMode = .scaleAspectFit
        imageView.layer.borderWidth = 0.5
        imageView.layer.borderColor = UIColor(white: 0.5, alpha: 0.5).cgColor
        return imageView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = UIColor(white: 0.5, alpha: 0.5)
        return view
    }()
    
    let labelHIRAGANA : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "hiragana"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 8)
        return label
    }()
    
    let labelPrefecture : UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
//        label.text = "prefecture"
        label.textColor = UIColor.red
        label.font = UIFont.systemFont(ofSize: 17)
        return label
    }()
    
    override func setupCellViews() {
        addSubview(imagePrefecture)
        imagePrefecture.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 5).isActive = true
        imagePrefecture.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        imagePrefecture.heightAnchor.constraint(equalToConstant: 55).isActive = true
        imagePrefecture.widthAnchor.constraint(equalToConstant: 55).isActive = true
        
        let containerView =  UIView()
        containerView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(containerView)
        containerView.leftAnchor.constraint(equalTo: imagePrefecture.rightAnchor, constant: 10).isActive = true
        containerView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -5).isActive = true
        containerView.addSubview(labelHIRAGANA)
        containerView.addSubview(labelPrefecture)
        addSubview(dividerLineView)
        
        labelPrefecture.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: 0).isActive = true
        labelPrefecture.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        labelPrefecture.heightAnchor.constraint(equalToConstant: 30).isActive = true
        labelPrefecture.widthAnchor.constraint(equalTo: containerView.widthAnchor, multiplier: 1).isActive = true
        
        labelHIRAGANA.leftAnchor.constraint(equalTo: containerView.leftAnchor, constant: 0).isActive = true
        labelHIRAGANA.bottomAnchor.constraint(equalTo: labelPrefecture.topAnchor, constant: 5).isActive = true
        labelHIRAGANA.widthAnchor.constraint(equalTo: containerView.widthAnchor, constant: 0).isActive = true
        labelHIRAGANA.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 0).isActive = true
        
        dividerLineView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 0).isActive = true
        dividerLineView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: 0).isActive = true
        dividerLineView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: 0).isActive = true
        dividerLineView.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCellViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func setupCellViews() {
        backgroundColor = UIColor.blue
    }
}
