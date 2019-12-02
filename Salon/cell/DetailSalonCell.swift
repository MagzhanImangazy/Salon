//
//  RecommendedSalonCell.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit
protocol imagePressed {
    func showMapVC()
}
class DetailSalonCell: UITableViewCell {
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
    let locationLabel: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.numberOfLines = 0
        return label
    }()
    let locationImage:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "pointer")
        image.isUserInteractionEnabled = true
        return image
    }()
    let instagramImage:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "instagram")
        return image
    }()
    let poneImage:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "apple")
        return image
    }()
    let lineview:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.lightGray
        return view
    }()
    
    let ratingImage:UIImageView = {
        let image = UIImageView()
        image.image = #imageLiteral(resourceName: "redstar")
        return image
    }()
    let reviewCountLabel: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.systemFont(ofSize: 16)
        return label
    }()
    let ratingCount: UILabel = {
        let label = UILabel()
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    var delegate:imagePressed?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        backgroundColor = .clear
        addSubview(nameLabel)
        addSubview(label)
        addSubview(poneImage)
        addSubview(instagramImage)
        addSubview(reviewCountLabel)
        addSubview(ratingImage)
        addSubview(locationImage)
        addSubview(lineview)
        addSubview(locationLabel)
        addSubview(ratingCount)
        setupContaints()
        let tap = UITapGestureRecognizer(target: self, action: #selector(showMap))
        locationImage.addGestureRecognizer(tap)
    }
    private func setupContaints() {
        label.snp.makeConstraints { (make) in
            make.top.left.equalToSuperview().offset(16)
        }
        nameLabel.snp.makeConstraints { (make) in
            make.top.equalTo(label.snp.bottom).offset(16)
            make.left.equalTo(label.snp.left)
        }
        locationImage.snp.makeConstraints { (make) in
            make.top.equalTo(nameLabel.snp.bottom).offset(16)
            make.left.equalTo(label.snp.left)
            make.width.height.equalTo(18)
        }
        locationLabel.snp.makeConstraints { (make) in
            make.top.equalTo(locationImage.snp.top)
            make.left.equalTo(locationImage.snp.right).offset(8).priority(.high)
            make.right.equalTo(instagramImage.snp.right).offset(-16)
        }
        poneImage.snp.makeConstraints { (make) in
            make.top.equalTo(locationImage.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(18)
        }
        instagramImage.snp.makeConstraints { (make) in
            make.top.equalTo(locationImage.snp.top)
            make.right.equalTo(poneImage.snp.left).offset(-8)
            make.width.height.equalTo(18)
        }
        lineview.snp.makeConstraints { (make) in
            make.top.equalTo(locationLabel.snp.bottom).offset(16)
            make.left.equalTo(nameLabel.snp.left)
            make.right.equalTo(poneImage.snp.right)
            make.height.equalTo(1)
        }
        reviewCountLabel.snp.makeConstraints { (make) in
            make.top.equalTo(lineview.snp.bottom).offset(16)
            make.left.equalTo(lineview.snp.left)
        }
        ratingImage.snp.makeConstraints { (make) in
            make.top.equalTo(reviewCountLabel.snp.top)
            make.right.equalToSuperview().offset(-16)
            make.width.height.equalTo(18)
        }
        ratingCount.snp.makeConstraints { (make) in
            make.top.equalTo(ratingImage.snp.top)
            make.right.equalTo(ratingImage.snp.left).offset(-4)
        }

    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc func showMap() {
        delegate?.showMapVC()
        print("Mako")
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
