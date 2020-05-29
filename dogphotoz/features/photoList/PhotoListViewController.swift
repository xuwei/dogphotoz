//
//  ViewController.swift
//  dogphotoz
//
//  Created by Xuwei Liang on 29/5/20.
//  Copyright © 2020 Wisetree Solutions Pty Ltd. All rights reserved.
//

import UIKit
import PromiseKit

class PhotoListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var sortButton: UIBarButtonItem!
    var viewModel = PhotoListViewModel()
    
    /// cell identifiers to register for use
    /// if we want to register more cells to re-use, add to this array
    let identifiers = [PhotoTableCellViewModel.identifier()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "\(SortOrder.ascending.rawValue) order"
        setupTable()
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData() { }
    }
    
    func setupTable() {
        guard self.tableView != nil else { return }
        
        /// using automatic cell height, will calculate by intrinsic value
        self.tableView.estimatedRowHeight = 1
        self.tableView.rowHeight = UITableView.automaticDimension
        self.tableView.separatorStyle = .none
        
        /// delegate is set programmatically, less maintenance on storyboard
        self.tableView.delegate = self
        self.tableView.dataSource = self
        
    }
    
    func registerCells() {
        guard self.tableView != nil else { return }
        for cellIdentifier in identifiers {
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    func loadData(_ completionHandler: @escaping ()->Void?) {
        viewModel.fetchPhotos(AppData.shared.limit).done { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
            completionHandler()
        }.catch { err in
            self.showError(err)
        }
    }
    
    /// sort method called when user clicks on sort button, sort functionality alternates between
    /// Ascending/Descending
    @IBAction func sort() {
        guard let sortOrder = SortOrder.init(rawValue: sortButton.title ?? "") else { return }
        viewModel.lifeSpanSortIn(sortOrder) {
            self.title = "\(sortOrder.rawValue) order"
            self.sortButton.title = sortOrder.reverse().rawValue
            self.tableView.reloadData()
        }
    }
}

extension PhotoListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let photoList = viewModel.photoList()
        guard photoList.count > indexPath.row else { return UITableViewCell() }
        let cellViewModel: PhotoTableCellViewModel = photoList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: PhotoTableCellViewModel.identifier(), for: indexPath) as! PhotoTableViewCell
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photoList().count
    }
}

