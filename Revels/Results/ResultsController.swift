//
//  ResultsController.swift
//  Revels
//
//  Created by Vedant Jain on 28/02/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit
import Alamofire

class ResultsController: UITableViewController {
    
    private let cellID = "cellID"
    
    private var resultsArray = [ResultsStruct]()
    private var sectionArray = [SectionState]()
    private var eventsArray = [EventStruct]()
    
    private let preset = ["Round #", "Position", "Team ID"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResultsCell.self, forCellReuseIdentifier: cellID)
        
        tableView.backgroundColor = .white
        
        self.title = "Results"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        tableView.separatorStyle = .none
        
        networking()
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    fileprivate func getEvents() {
        Alamofire.request("https://api.mitrevels.in/events", method: .get, parameters: nil).responseJSON{ response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        self.eventsArray = try JSONDecoder().decode(EventContainer.self, from: data).data
                        self.getResults()
                    } catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func getResults() {
        Alamofire.request("https://api.mitrevels.in/results", method: .get, parameters: nil).responseJSON{ response in
            switch response.result {
            case .success:
                if let data = response.data{
                    do{
                        let res = try JSONDecoder().decode(ResultsContainer.self, from: data)
                        self.resultsArray = res.data
                        for ele in self.resultsArray {
                            var present: Int = 0
                            for i in 0 ..< self.sectionArray.count {
                                if ele.event == self.sectionArray[i].eventID {
                                    present = 1
                                    self.sectionArray[i].count = self.sectionArray[i].count + 1
                                    self.sectionArray[i].results.append(ele)
                                }
                            }
                            if present == 0 {
                                for j in self.eventsArray {
                                    if j.id == ele.event {
                                        self.sectionArray.append(SectionState(isExpanded: false, name: j.name, eventID: ele.event, count: 1, results: [ele]))
                                    }
                                }
                            }
                        }
                        
                        DispatchQueue.main.async {
                            self.tableView.reloadData()
                            LoadingOverlay.shared.hideOverlayView()
                        }
                    }catch let error{
                        print(error)
                    }
                }
                break
            case .failure(let error):
                print(error)
            }
        }
    }
    
    fileprivate func networking() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        DispatchQueue.main.async {
            self.getEvents()
        }
        
        getResults()
        
        print("got data")
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return sectionArray.count
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 68
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let view: UIView = {
            let view = UIView(frame: CGRect(x: 0, y: 0, width: tableView.frame.width, height: 64))
            
            let collapseButton: UIButton = {
                let button = UIButton(type: .system)
//                button.setTitle(sectionArray[section].isExpanded ? "Show Less" : "Show More", for: .normal)
                button.tag = section
                button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
                return button
            }()
            
            let border: UIView = {
                let border = UIView(frame: CGRect(x: 0, y: 0, width: 1000, height: 0.3))
                border.backgroundColor = UIColor(r: 211, g: 211, b: 211)
                return border
            }()
            
            let eventLabel: UILabel = {
                let label = UILabel()
                label.text = String(sectionArray[section].name)
//                label.font = UIFont.boldSystemFont(ofSize: 23)
                label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.semibold)
                label.numberOfLines = 2
                label.textAlignment = .left
                return label
            }()
            
            view.backgroundColor = .white
            view.addSubview(collapseButton)
            view.addSubview(eventLabel)
            view.addSubview(border)
            
            
            view.bringSubviewToFront(collapseButton)
            
            eventLabel.frame = CGRect(x: 16, y: 0, width: view.frame.width-16, height: view.frame.height)
            collapseButton.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height)
            border.frame = CGRect(x: 16, y: view.frame.height+3.3, width: 1000, height: 0.3)

            return view
        }()
        
        return view
        
    }
    
    @objc func handleExpandClose(button: UIButton) {
        // close section by deleting the rows in that section
        let section = button.tag
        let isExpanded = sectionArray[section].isExpanded
        var indexPaths: [IndexPath] = []
        for row in 0 ..< sectionArray[section].count + 1 {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        sectionArray[section].isExpanded = !isExpanded
        
//        button.setTitle(isExpanded ? "Show More" : "Show Less", for: .normal)
        
        if isExpanded {
//            button.setImage(UIImage(named: "downarrow"), for: UIControl.State.disabled)
        }
        else {
//            button.setImage(UIImage(named: "uparrow"), for: .normal)
        }
        
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultsCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ResultsCell
        if indexPath.item == 0 {
            cell.roundLabel.text = preset[0]
            cell.positionLabel.text = preset[1]
            cell.teamLabel.text = preset[2]
        }
        else {
            let result = sectionArray[indexPath.section].results[indexPath.item-1]
            cell.roundLabel.text = String(result.round)
            cell.positionLabel.text = String(result.position)
            cell.teamLabel.text = String(result.teamid)
        }
        if indexPath.item % 2 == 0 {
            cell.backgroundColor = UIColor(r: 240, g: 240, b: 240)
        }
        else {
            cell.backgroundColor = UIColor(r: 230, g: 230, b: 230)
        }
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionArray[section].isExpanded {
            return sectionArray[section].count + 1
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-42)/2, height: 214)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
}
