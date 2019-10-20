//
//  EmployeeListViewController.swift
//  ME Bank
//
//  Created by Wael Saad on 19/10/19.
//  Copyright © 2019 Wael Saad. All rights reserved.
//

import UIKit

class EmployeeListViewController: UIViewController {
    
    var cellHeights: [CGFloat] = []
    
    lazy var centeredLoader: UIActivityIndicatorView = {
        let loader = UIActivityIndicatorView(style: .whiteLarge)
        loader.color = UIColor.black
        loader.hidesWhenStopped = true
        return loader
    }()
    
    // MARK: Experimenting with different approaches of loading the UITableView - Both Approaches work
    
//    lazy var tableView: UITableView = {
//        let tableView = UITableView()
//        tableView.delegate = self
//        tableView.dataSource = self
//        tableView.isAccessibilityElement = true
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = Constants.closeCellHeight
//        tableView.registerCell(EmployeeItemTableViewCell.self)
//        tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background.jpeg"))
//        tableView.accessibilityIdentifier = Constants.tableViewAccessibilityIdentifier
//        tableView.contentInset = UIEdgeInsets(top: Constants.tableTopMargin, left: 0, bottom: 0, right: 0);
//        return tableView
//    }()
    
    @IBOutlet var tableView: UITableView! {
        didSet {
            tableView.isHidden = true
            tableView.delegate = self
            tableView.dataSource = self
            tableView.showsVerticalScrollIndicator = false
            tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background.jpeg"))
            tableView.rowHeight = UITableView.automaticDimension
            tableView.registerCell(EmployeeItemTableViewCell.self)
            tableView.estimatedRowHeight = Constants.closeCellHeight
            //tableView.refreshControl = UIRefreshControl()
            //tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
            //tableView.backgroundColor = .backgroundColor
            tableView.isAccessibilityElement = true
            tableView.accessibilityIdentifier = Constants.tableViewAccessibilityIdentifier
            tableView.contentInset = UIEdgeInsets(top: Constants.tableTopMargin, left: 0, bottom: 0, right: 0);
        }
    }
    
    // MARK: Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        showCenteredLoading()
        configureNavigationBar()
        getUsers(pageNumber: 1)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.attachToScrollView(tableView)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.reset()
    }
    
    private func configureNavigationBar() {
        guard let navigationBar = navigationController?.navigationBar else { return }
        navigationBar.barColor = .navBarColor
        //Theme.applyAppearance(for: navigationBar, theme: .overview)
    }
    
    func getUsers(pageNumber: Int) {
        self.viewModel.getUsers(pageNumber: pageNumber,
                                completion: { (result: Result<Employees, APIError>) in
                                    switch result {
                                    case .success:
                                        DispatchQueue.main.async {
                                            self.setup()
                                            self.showTableView()
                                            self.hideCenteredLoading()
                                            self.tableView.reloadData()
                                        }
                                    case let .failure (error):
                                        DispatchQueue.main.async {
                                            self.viewModel.displayError(error: error)
                                        }
                                    }
        })
    }
    
    func setup() {
        //tableView.tableFooterView = UIView()
        //tableView.addScalableCover(with: #imageLiteral(resourceName: "MeBank"))
        cellHeights = Array(repeating: Constants.closeCellHeight, count: viewModel.data.count)
    }
    
    private func showTableView() {
        tableView.isHidden = false
//        view.addSubview(self.tableView)
//        tableView.translatesAutoresizingMaskIntoConstraints = false
//        tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor).isActive = true
//        tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor).isActive = true
//        tableView.topAnchor.constraint(equalTo: self.view.topAnchor).isActive = true
//        tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    private func showCenteredLoading() {
        centeredLoader.startAnimating()
        view.addSubview(self.centeredLoader)
        centeredLoader.backgroundColor = .clear
        centeredLoader.translatesAutoresizingMaskIntoConstraints = false
        centeredLoader.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        centeredLoader.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
    }
    
    private func hideCenteredLoading() {
        centeredLoader.stopAnimating()
        centeredLoader.removeConstraints(self.centeredLoader.constraints)
        centeredLoader.removeFromSuperview()
    }
    
    // MARK: Actions
    
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
    
    // MARK: - Private Properties
    
    var viewModel: EmployeeListViewModel = EmployeeListViewModel()
}

// MARK: - UITableViewDataSource

extension EmployeeListViewController: UITableViewDataSource {
    
    func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EmployeeItemTableViewCell = tableView.dequeueReusableCell(withClass: EmployeeItemTableViewCell.self)
        let durations: [TimeInterval] = [0.26, 0.2, 0.2]
        cell.durationsForExpandedState = durations
        cell.durationsForCollapsedState = durations
        cell.configure(with: viewModel.data[indexPath.item])
        cell.isAccessibilityElement = true
        return cell
    }
}

// MARK: - UITableViewDelegate

extension EmployeeListViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as EmployeeItemTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Constants.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Constants.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Constants.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = Constants.durationForCollapsedCell
        } else {
            cellHeights[indexPath.row] = Constants.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = Constants.durationForExpandedCell
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
}


extension EmployeeListViewController {
    struct Constants {
        static let durationForExpandedCell = 0.8
        static let durationForCollapsedCell = 0.5
        
        static let openCellHeight: CGFloat = 488
        static let tableTopMargin: CGFloat = 70
        static let closeCellHeight: CGFloat = 179

        static let previousButtonWidth = 22
        static let previousButtonHeight = 16
        static let defaultCellHeight: CGFloat = 151.5
        static let estimatedHeaderRowHeight: CGFloat = 0.0
        
        static let tableViewAccessibilityIdentifier = "UserListTableView"
    }
}
