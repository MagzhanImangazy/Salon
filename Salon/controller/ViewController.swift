//
//  ViewController.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit
import SnapKit
class ViewController: UIViewController {
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.register(FamousSalonCell.self, forCellReuseIdentifier: "famous")
        tableview.register(RecommendedTableViewCell.self, forCellReuseIdentifier: "recommended")
        tableview.register(NewSalonTableViewCell.self, forCellReuseIdentifier: "newSalon")
        tableview.separatorStyle = .none
        return tableview
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Салоны"
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        self.view.addSubview(tableview)
        setupConstaints()
        
        // Do any additional setup after loading the view.
    }
    private func setupConstaints() {
        tableview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }
    
}
extension ViewController:UITableViewDelegate,UITableViewDataSource {
    public func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "famous", for: indexPath) as! FamousSalonCell
            cell.delegate = self
            return cell
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "recommended", for: indexPath) as! RecommendedTableViewCell
            cell.delegate = self
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "newSalon", for: indexPath) as! NewSalonTableViewCell
            cell.delegate = self
            return cell
        }
    }
    public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 2 {
            let height = self.view.frame.size.height * 0.35
            return height
        } else {
            let height = self.view.frame.size.height * 0.55
            return height
        }
        
    }
    public func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0 {
            return "Популярное"
        } else if section == 1 {
            return "Рекомендуемые"
        } else {
            return "Новые салоны"
        }
    }
}
extension ViewController:cellPressed {
    func pushVC(id: Int) {
        let vc = DetailViewController()
        vc.id = id
        self.show(vc, sender: self)
    }
    
    
}
