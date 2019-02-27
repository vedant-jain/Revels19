//
//  ResultsController.swift
//  Revels
//
//  Created by Vedant Jain on 16/01/19.
//  Copyright © 2019 Naman Jain. All rights reserved.
//

import UIKit

class ResultsController: UITableViewController {
    
    private let cellID = "cellID"
    
    private var resultsArray = [ResultsStruct]()
    private var sectionArray = [SectionState]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ResultsCell.self, forCellReuseIdentifier: cellID)
        
        tableView.backgroundColor = .white
        
        self.title = "Results"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        networking()
        
        tableView.dataSource = self;
        tableView.delegate = self;
    }
    
    fileprivate func networking() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        let jsonURLString: String = "http://api.mitrevels.in/results"
        guard let url:URL = URL(string: jsonURLString) else {return}
        
        URLSession.shared.dataTask(with: url) { (data, response, err) in
            
            //check for error?
            if let err = err {
                print("Failed to get data from url", err)
                return
            }
            guard let data = data else {return}
            
            do {
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
                        self.sectionArray.append(SectionState(isExpanded: true, eventID: ele.event, count: 1, results: [ele]))
                    }
                }
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    LoadingOverlay.shared.hideOverlayView()
                }
                
            }
            catch let jsonErr {
                print("Error serializing json: ", jsonErr)
            }
            
            }.resume()
        
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
                button.setTitle(sectionArray[section].isExpanded ? "Show Less" : "Show More", for: .normal)
                button.tag = section
                button.addTarget(self, action: #selector(handleExpandClose), for: .touchUpInside)
                return button
            }()

            let eventLabel: UILabel = {
                let label = UILabel()
                label.text = "Event: " + String(sectionArray[section].eventID)
                label.font = UIFont.boldSystemFont(ofSize: 28)
                return label
            }()

            view.backgroundColor = .white
            view.addSubview(collapseButton)
            view.addSubview(eventLabel)
            
            eventLabel.frame = CGRect(x: 16, y: 16, width: view.frame.width-128, height: view.frame.height-32)
            collapseButton.frame = CGRect(x: view.frame.width-128, y: 16, width: 128, height: view.frame.height-32)

//            eventLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
//            eventLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16).isActive = true
//            eventLabel.trailingAnchor.constraint(equalTo: collapseButton.leadingAnchor, constant: -8).isActive = true
//            eventLabel.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
//
//            collapseButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
//            collapseButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 16).isActive = true
//            collapseButton.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 8).isActive = true
//            collapseButton.widthAnchor.constraint(equalToConstant: 40).isActive = true

            return view
        }()

        return view
        
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "Event: " + String(sectionArray[section].eventID)
    }
    
    
    
    @objc func handleExpandClose(button: UIButton) {
        // close section by deleting the rows in that section
        let section = button.tag
        let isExpanded = sectionArray[section].isExpanded
        var indexPaths: [IndexPath] = []
        for row in 3 ..< sectionArray[section].count-1 {
            let indexPath = IndexPath(row: row, section: section)
            indexPaths.append(indexPath)
        }
        sectionArray[section].isExpanded = !isExpanded
        
        button.setTitle(isExpanded ? "Show More" : "Show Less", for: .normal)
        
        if isExpanded {
            tableView.deleteRows(at: indexPaths, with: .fade)
        }
        else {
            tableView.insertRows(at: indexPaths, with: .fade)
        }
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultsCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ResultsCell
        let result = sectionArray[indexPath.section].results[indexPath.item]
        cell.label.text = "\tRound " + String(result.round) + "\t\t\t\t" + String(result.position) + "\t\t\t\t" + String(result.teamid)
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if sectionArray[section].isExpanded {
            return sectionArray[section].count - 1
        }
        else {
            return 3
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-42)/2, height: 214)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
}
