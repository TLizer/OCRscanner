//
//  ScanerListViewController.swift
//  OCRscanner
//
//  Created by Tomasz Lizer on 28/05/2021.
//

import UIKit

final class ScanerListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    private let tableView = UITableView()
    private let indicatorContainer = UIView()
    private lazy var activityIndicator = UIActivityIndicatorView(style: .whiteLarge)
    
    var viewModel: ScannerListViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
        bindViewModel()
    }
    
    // MARK: - UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfRows()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.reuseIdentifier, for: indexPath)
        cell.textLabel?.text = viewModel.data(for: indexPath)
        return cell
    }
    
    // MARK: - UITableViewDelegate
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(
            style: .destructive,
            title: "DELETE") { [viewModel] _, _, _ in
            viewModel?.deleteScan(at: indexPath)
        }
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        viewModel.displayDetails(for: indexPath)
    }
    
    // MARK: - Private
    
    private func setupViews() {
        title = "OCRscanner"
        view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.reuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(indicatorContainer)
        indicatorContainer.frame = view.bounds
        indicatorContainer.backgroundColor = UIColor.black.withAlphaComponent(0.2)
        indicatorContainer.addSubview(activityIndicator)
        activityIndicator.center = indicatorContainer.center
        indicatorContainer.isHidden = true
        
        let addScanButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addScanTapped))
        navigationItem.rightBarButtonItem = addScanButton
    }
    
    @objc private func addScanTapped() {
        viewModel.addScan()
    }
    
    private func bindViewModel() {
        viewModel.reloadTableView = { [tableView] in
            tableView.reloadData()
        }
        viewModel.isLoading = { [activityIndicator, indicatorContainer] isLoading in
            if isLoading {
                indicatorContainer.isHidden = false
                activityIndicator.startAnimating()
            } else {
                indicatorContainer.isHidden = true
                activityIndicator.stopAnimating()
            }
        }
    }
}
