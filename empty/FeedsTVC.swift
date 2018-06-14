//
//  FeedsTVC.swift
//  empty
//
//  Created by demylia on 29.08.17.
//  Copyright © 2017 Dmitry.Tihonov. All rights reserved.
//

import UIKit

class FeedsTVC: UITableViewController {

    let model = FeedModel()
    let startDate = "2016-09-26T17:47:48"
    var endDate = "2016-09-26T17:47:48"
    lazy var refControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        refreshControl.tintColor = .gray
        return refreshControl
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        loadData()
    }
    
    func configureVC(title: String) {
        self.title = title
    }
    
    @objc private func loadData(){
        
        refreshControl?.endRefreshing()
        model.loadData(path: endDate) { state in
            
            if state == .error {
                //TODO: show error
            } else {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc private func refresh(){
        model.feedData = nil
        endDate = startDate
        loadData()
    }


    deinit {
        Logger.log(type: .release, className: self.description)
    }
    
    private func setup(){
        
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.tableFooterView = UIView()
        tableView.register(FeedCell.nib, forCellReuseIdentifier: FeedCell.identifier)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.identifier)
        
        refreshControl = refControl
        self.clearsSelectionOnViewWillAppear = true
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return model.countOfRows
    }

    let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: FeedCell.identifier, for: indexPath) as! FeedCell
        
        if indexPath.row == model.countOfRows - 1 || model.countOfRows == 1 {
            let cell  = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.identifier, for: indexPath)
            activityIndicator.center = cell.contentView.center
            activityIndicator.startAnimating()
            cell.contentView.addSubview(activityIndicator)
            
            //hide last separator
            let rect = UIScreen.main.bounds.size
            cell.separatorInset = UIEdgeInsetsMake(0, max(rect.height, rect.width), 0, 0)
            return cell
        }
        if let item = model.publicationAtIndex(indexPath.row) {
            cell.reload(item: item)
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        if (indexPath.row == model.countOfRows - 1
            && model.feedData?.hasMore == true),
            let createdAt = model.publicationAtIndex(indexPath.row)?.createdAt {
            endDate = createdAt
            loadData()
        } else if let feed = model.feedData, feed.hasMore != true {
            activityIndicator.stopAnimating()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let publication = model.publicationAtIndex(indexPath.row) {
            let vc = ContentTVC()
            vc.publication = publication
            navigationController?.pushViewController(vc, animated: true)
        }
        
    }
}
