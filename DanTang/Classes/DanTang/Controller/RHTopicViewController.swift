//
//  RHTopicViewController.swift
//  DanTang
//
//  Created by river on 2018/1/23.
//  Copyright © 2018年 richinfo. All rights reserved.
//

import UIKit
let homeCellID = "homeCellID"

class RHTopicViewController: UITableViewController {
    
    var type = Int()
    
    var items = [RHHomeItem]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = RHGlobalColor()
        setupTableView()
        refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(loadHomeData), for:.valueChanged)
        tableView.addSubview(refreshControl!)
        // 获取首页数据
        loadHomeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // MARK: - pravite
    func setupTableView(){
        
        tableView.rowHeight = 160
        tableView.contentInset = UIEdgeInsetsMake(kTitlesViewH, 0, tabBarController!.tabBar.height, 0)
        tableView.scrollIndicatorInsets = tableView.contentInset
        tableView.separatorStyle = .none
        let nib = UINib(nibName: String(describing: RHHomeCell.self), bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: homeCellID)
    }
    
    @objc func loadHomeData() {
        // 获取首页数据
        weak var weakSelf = self
        RHNetworkTool.shareNetworkTool.loadHomeInfo(id: type) { (homeItems) in
            weakSelf!.items = homeItems
            weakSelf!.tableView!.reloadData()
            weakSelf!.refreshControl?.endRefreshing()
        }
        print("loadHomeData")
    }
    // MARK: - UITableViewDataSource
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellID) as! RHHomeCell
        cell.selectionStyle = .none
        cell.homeItem = items[indexPath.row]
        return cell
    }
    



}
