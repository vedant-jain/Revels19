//
//  MainCell.swift
//  Revels
//
//  Created by Naman Jain on 19/12/18.
//  Copyright © 2018 Naman Jain. All rights reserved.
//

import UIKit

class MainCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {
    
    var data = [Event]()
    
    
    fileprivate let cellId = "cellId"
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.delegate = self
        tableView.dataSource = self
        tableView.contentInset = .init(top: 8, left: 0, bottom: 8, right: 0)
        tableView.register(EventCell.self, forCellReuseIdentifier: cellId)
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        let refreshControl = UIRefreshControl()
        tableView.refreshControl = refreshControl
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
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! EventCell
        cell.titleLabel.text = data[indexPath.row].returnName()
        cell.bodyLabel.text = "Hello"
        cell.dateLabel.text = "Insert Data here"
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
