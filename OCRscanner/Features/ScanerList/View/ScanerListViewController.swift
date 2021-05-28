//
//  ScanerListViewController.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class ScanerListViewController: UITableViewController {
    var viewModel: ScannerListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        let addScanButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScanTapped))
        navigationItem.rightBarButtonItem = addScanButton
        viewModel.reloadCallback = { [tableView] in
            tableView?.reloadData()
        }
    }
    
    @objc private func addScanTapped() {
        viewModel.addScan()
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.data(for: indexPath)
        return cell
    }
}
