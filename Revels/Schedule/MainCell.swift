//
//  MainCell.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var data = [ScheduleEvent]()
    var screenHeight: CGFloat = 200
    var scheduleController: ScheduleController?
    
    
    fileprivate let cellId = "cellId"
    fileprivate let loaderCellId = "loaderCellId"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        tableView.register(EventCell.self, forCellReuseIdentifier: cellId)
        tableView.register(LoaderTVCell.self, forCellReuseIdentifier: loaderCellId)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(tableView)
        _ = tableView.anchor(topAnchor, left: leftAnchor, bottom: bottomAnchor, right: rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 0)
    }
    override func prepareForReuse() {
        print("reusing cell")
        print(data)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if data.count == 0{
            return 1
        }else{
            return data.count
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if data.count == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: loaderCellId, for: indexPath) as! LoaderTVCell
            cell.selectionStyle = .none
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventCell
            cell.selectionStyle = .none
            cell.titleLabel.text = data[indexPath.row].returnName()
            cell.dateLabel.text = data[indexPath.row].event?.short_desc
            guard let time = data[indexPath.row].eventTime, let venue = data[indexPath.row].eventVenue else{
                cell.locationLabel.text = "NULL"
                return cell
            }
            cell.locationLabel.text = venue + "\n" + time
            
            if indexPath.row % 2 == 1{
                cell.backgroundCard.backgroundColor = #colorLiteral(red: 0.9256157279, green: 0.9040682912, blue: 0.9992395043, alpha: 1)
                cell.titleLabel.textColor = #colorLiteral(red: 0.3722749352, green: 0.1826122403, blue: 0.8808652759, alpha: 1)
                cell.dateLabel.textColor = #colorLiteral(red: 0.3722749352, green: 0.1826122403, blue: 0.8808652759, alpha: 0.6326474472)
                cell.locationLabel.textColor = #colorLiteral(red: 0.3722749352, green: 0.1826122403, blue: 0.8808652759, alpha: 1)
            }else{
                cell.backgroundCard.backgroundColor = #colorLiteral(red: 1, green: 0.9375504851, blue: 0.9077358842, alpha: 1)
                cell.titleLabel.textColor = #colorLiteral(red: 0.928189218, green: 0.6127285361, blue: 0.426661849, alpha: 1)
                cell.dateLabel.textColor = #colorLiteral(red: 0.928189218, green: 0.6127285361, blue: 0.426661849, alpha: 0.6366087148)
                cell.locationLabel.textColor = #colorLiteral(red: 0.928189218, green: 0.6127285361, blue: 0.426661849, alpha: 1)
            }
            return cell
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if data.count == 0 {
            return screenHeight
        }
        return 200
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if data.count == 0 {
            return
        }else{
            scheduleController?.presentEventCard(event: data[indexPath.row])
        }
    }
}
