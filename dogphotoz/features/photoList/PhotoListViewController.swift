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
    let limit = 3
    var viewModel = PhotoListViewModel()
    
    /// cells to register for use
    let cellViewModels = [PhotoTableCellViewModel()]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = viewModel.screenName
        registerCells()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadData()
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
        for vm: CellViewModelProtocol in cellViewModels {
            let cellIdentifier = vm.identifier()
            let nib = UINib(nibName: cellIdentifier, bundle: nil)
            self.tableView.register(nib, forCellReuseIdentifier: cellIdentifier)
        }
    }
    
    func loadData() {
        viewModel.fetchPhotos(limit).done { [weak self] _ in
            guard let self = self else { return }
            self.tableView.reloadData()
        }.catch { err in
            self.showError(err)
        }
    }
    
    @IBAction func sort() {
        guard let sortOrder = SortOrder.init(rawValue: sortButton.title ?? "") else { return }
        viewModel.lifeSpanSortIn(sortOrder) {
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
        let cell = tableView.dequeueReusableCell(withIdentifier: cellViewModel.identifier(), for: indexPath) as! PhotoTableViewCell
        cell.viewModel = cellViewModel
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.photoList().count
    }
}

