//
//  FamousSalonCell.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit
class NewSalonTableViewCell: UITableViewCell {
    let collectionview: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let collection = UICollectionView(frame: CGRect(x: 0, y: 0, width: 0, height: 0), collectionViewLayout: layout)
        layout.scrollDirection = .horizontal
        collection.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        collection.showsHorizontalScrollIndicator = false
        collection.showsVerticalScrollIndicator = false
        return collection
    }()
    var array = [Salons]()
    var networkDataFetcher = NetworkDataFetcher()
    let url = "http://zp.jgroup.kz/rest/v1/salon/getRecentlyAdded"
    var delegate:cellPressed?
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        // Initialization code
        backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        self.collectionview.dataSource = self
        self.collectionview.delegate = self
        collectionview.register(NewSalonCollectionViewCell.self, forCellWithReuseIdentifier: "NewSalonCollectionCell")
        addSubview(collectionview)
        collectionview.snp.makeConstraints { (make) in
            make.top.equalToSuperview()
            make.left.equalToSuperview()
            make.right.equalToSuperview()
            make.height.equalToSuperview()
        }
        getJson()
            
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func getJson() {
        networkDataFetcher.fetchData(urlString: url) { (value) in
            guard let result = value?.salons else {return}
            self.array = result
            DispatchQueue.main.async {
                self.collectionview.reloadData()
            }
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
extension NewSalonTableViewCell:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return array.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "NewSalonCollectionCell", for: indexPath) as! NewSalonCollectionViewCell
        cell.label.text = array[indexPath.row].type
        cell.nameLabel.text = array[indexPath.row].name
        let urlString = "http://zp.jgroup.kz\(array[indexPath.row].pictureUrl)"
        guard let url = URL(string: urlString) else {
            return cell
        }
        let gueue = DispatchQueue.global(qos: .utility)
        gueue.async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    cell.imageview.image = UIImage(data: data)
                }
            }
        }
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.size.width * 0.45, height: collectionView.frame.size.height * 0.9)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.pushVC(id: array[indexPath.row].id)
    }
    
}
