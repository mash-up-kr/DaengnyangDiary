//
//  MainViewController.swift
//  DaengnyangDiary
//
//  Created by Ethan on 2021/10/02.
//

import UIKit

class MainViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
    }
    
    
    // MARK: - Func
    private func registerCells() {
        tableView.registerNibCell(MainHeaderTableViewCell.self)
        tableView.registerNibCell(MainCovercardTableViewCell.self)
    }
}

extension MainViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0 {
            let cell = tableView.dequeueReusable(MainHeaderTableViewCell.self, for: indexPath)
            return cell
        } else if indexPath.row == 1 {
            let cell = tableView.dequeueReusable(MainCovercardTableViewCell.self, for: indexPath)
            return cell
        }
        return UITableViewCell()
    }
}
