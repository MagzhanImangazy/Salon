//
//  DetailViewController.swift
//  zapis
//
//  Created by Magzhan Imangazin on 12/1/19.
//  Copyright © 2019 Magzhan Imangazin. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    let tableview:UITableView = {
        let tableview = UITableView()
        tableview.register(CarouselTableViewCell.self, forCellReuseIdentifier: "carousel")
        tableview.register(DetailSalonCell.self, forCellReuseIdentifier: "detail")
        tableview.register(SpaceTableViewCell.self, forCellReuseIdentifier: "space1")
        tableview.register(TimeCell.self, forCellReuseIdentifier: "timecell")
        tableview.register(SpaceTableViewCell.self, forCellReuseIdentifier: "space2")
        tableview.register(MastersTableViewCell.self, forCellReuseIdentifier: "masters")
        tableview.separatorStyle = .none
        tableview.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        return tableview
    }()
    var id:Int?
    var network = NetworkDataFetcher()
    let url = "http://zp.jgroup.kz/rest/v1/salon/page?id="
    var detailArray = [Salon]()
    var mastersArray = [Masters]()
    var startDateString = ""
    var endDateString = ""
    var latutude:Double?
    var longitude:Double?
    var avatarUrl = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Описания"
        view.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        tableview.delegate = self
        tableview.dataSource = self
        tableview.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.968627451, blue: 0.9764705882, alpha: 1)
        self.view.addSubview(tableview)
        setupConstaints()
        if let salonID = id {
            getJsonData(id: salonID)
        }
        // Do any additional setup after loading the view.
    }
    private func getJsonData(id:Int) {
        let urlString = "\(url)\(id)"
        network.fetchDetailData(urlString:urlString ) { (value) in
            guard let result = value else {return}
            self.detailArray.append(result)
            self.startDateString = result.workStartTime
            self.endDateString = result.workEndTime
            self.avatarUrl = result.avatarUrl
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }
        }
        network.fetchMastersData(urlString: urlString) { (value) in
            guard let result = value else {return}
            self.mastersArray = result.masters
            DispatchQueue.main.async {
                self.tableview.reloadData()
            }

        }
        network.fetchLocation(urlString: urlString) { (value) in
            guard let result = value else {return}
            self.latutude = result.markerY
            self.longitude = result.markerX
        }
    }
    
    func setupConstaints() {
        tableview.snp.makeConstraints { (make) in
            make.edges.equalTo(self.view)
        }
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension DetailViewController:UITableViewDataSource,UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 6
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 1 {
            return detailArray.count
        } else if section == 5 {
            return mastersArray.count
        } else {
            return 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "carousel", for: indexPath) as! CarouselTableViewCell
            let urlString = "http://zp.jgroup.kz\(avatarUrl)"
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
        } else if indexPath.section == 1 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "detail", for: indexPath) as! DetailSalonCell
            cell.label.text = detailArray[0].category
            cell.nameLabel.text = detailArray[0].name
            cell.locationLabel.text = detailArray[0].address
            cell.reviewCountLabel.text = "\(detailArray[0].reviewCount) отзывов"
            cell.ratingCount.text = String(detailArray[0].averageRating)
            cell.delegate = self
            return cell
        } else if indexPath.section == 2 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: "space1",for: indexPath)
            cell.backgroundColor = .groupTableViewBackground
            return cell
        } else if indexPath.section == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "timecell", for: indexPath) as! TimeCell
            cell.backgroundColor = .white
            cell.DateLabel.text = "\(startDateString.dropFirst(10)) - \(endDateString.dropFirst(10))"
            cell.label.text = "Расписания"
            return cell
        } else if indexPath.section == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "space2", for: indexPath) as! SpaceTableViewCell
            cell.backgroundColor = .groupTableViewBackground
            cell.label.text = "Мастера"
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "masters", for: indexPath) as! MastersTableViewCell
            cell.backgroundColor = .white
            cell.nameLabel.text = mastersArray[indexPath.row].name
            cell.professionLabel.text = mastersArray[indexPath.row].profession
            cell.accessoryType = .disclosureIndicator
            return cell
        }
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if indexPath.section == 0 {
            let height = self.view.frame.size.height * 0.45
            return height
        } else if indexPath.section == 1 {
            let height = self.view.frame.size.height * 0.3
            return height
        } else if indexPath.section == 2 {
            return 30
        } else if indexPath.section == 3 {
            return 40
        } else if indexPath.section == 5 {
            return 60
        } else {
            return 50
    }
    
}
}
extension DetailViewController:imagePressed {
    func showMapVC() {
        let vc = MapViewController()
        vc.latitude = self.latutude
        vc.longitude = self.longitude
        self.show(vc, sender: self)
    }
    
    
}
