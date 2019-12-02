//
//  CarouselTableViewCell.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/2/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit

class CarouselTableViewCell: UITableViewCell {
    let imageview:UIImageView = {
        let image = UIImageView()
        return image
    }()
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        addSubview(imageview)
        imageview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
