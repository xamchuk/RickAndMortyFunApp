//
//  LocationViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//
import UIKit

class LocationViewController: UIViewController {

    // MARK: - Views

    var locationTableView = UITableView()

    // MARK: - Properties

    var viewModel: ViewModel<ItemsResponse<Location>>

    // MARK: - Init

    init(viewModel: ViewModel<ItemsResponse<Location>> = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPage(1)

        viewModel.stateUpdated = { [weak self] state in
            self?.setFooterView(for: state)
            self?.locationTableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stateUpdated = nil
    }

    // MARK: - Actions

    @objc private func refreshTableView() {
        loadPage(1)
    }

    // MARK: - Private

    private func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getLocation(page: page)
        viewModel.load(request: request, page: page)
    }

    private func setFooterView(for state: State<Location>) {
        let footer = Footer()
//        footer.tableView = locationTableView
//        footer.setFooterView(for: state)
    }

    private func setupTableView() {
        view.addSubview(locationTableView)
        locationTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                 leading: view.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 trailing: view.safeAreaLayoutGuide.trailingAnchor)
        locationTableView.dataSource = self
        locationTableView.delegate = self
        locationTableView.register(LocationCell.self)
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.location = viewModel.items[indexPath.row]

        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == viewModel.items.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension LocationViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let vc = DetailsViewController()
//        let location = viewModel.items[indexPath.row]
//        vc.location = location
//        show(vc, sender: nil)
    }
}
