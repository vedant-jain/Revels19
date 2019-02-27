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
                print(self.resultsArray)
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
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ResultsCell = tableView.dequeueReusableCell(withIdentifier: cellID, for: indexPath) as! ResultsCell
        return cell
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return resultsArray.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: (view.frame.width-42)/2, height: 214)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 14, left: 14, bottom: 14, right: 14)
    }
    
}
