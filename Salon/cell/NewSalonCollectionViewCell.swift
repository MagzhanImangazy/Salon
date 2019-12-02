//
//  NewSalonCollectionViewCell.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/2/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit

class NewSalonCollectionViewCell: UICollectionViewCell {
    
    let view:UIView = {
        let view = UIView()
        view.layer.cornerRadius = 5
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowRadius = 5
        view.layer.shadowOpacity = 0.1
        view.backgroundColor = .white
        view.layer.shadowOffset = CGSize(width: 0, height: 0)
        return view
    }()
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let nameLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    let imageview:UIImageView = {
        let image = UIImageView()
        return image
    }()
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        addSubview(view)
        view.addSubview(nameLabel)
        view.addSubview(imageview)
        view.addSubview(label)
        setupConstaints()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupConstaints() {
        view.snp.makeConstraints { (make) in
            make.top.bottom.equalToSuperview()
            make.left.equalToSuperview().offset(8)
            make.right.equalToSuperview().offset(-8)
        }
        label.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalTo(view.snp.left).offset(16)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(imageview.snp.bottom).offset(10)
            make.left.equalTo(label.snp.left)
        }
        imageview.snp.makeConstraints { (make) in
            make.top.equalTo(view.snp.top).offset(16)
            make.left.equalTo(label.snp.left)
            make.right.equalTo(view.snp.right).offset(-16)
            make.height.equalTo(view.snp.height).multipliedBy(0.5)
        }
    }
    
}
