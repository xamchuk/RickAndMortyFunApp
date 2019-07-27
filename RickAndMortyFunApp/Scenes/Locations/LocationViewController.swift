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
    var tableView = UITableView()
    var navImage: UIImage!

    // MARK: - Properties
    var viewModel: LocationViewModel

    // MARK: - Init
    init(viewModel: LocationViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .black
        setupNavifationConroller()
        setupTableView()
        loadPage(1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.stateUpdated = { [weak self] state in
            self?.setFooterView(for: state)
            self?.tableView.reloadData()
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
    private func setFooterView(for state: State<Location>) {
        switch state {
        case .error(let error):
            let errorView: ErrorView = .fromNib()
            tableView.tableFooterView = errorView
            errorView.errorLabel.text = error.localizedDescription
        case .loading, .paging:
            let loadingView: LoadingView = .fromNib()
            tableView.tableFooterView = loadingView
        case .empty:
            let emptyView: EmptyView = .fromNib()
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        }
    }

    private func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getLocation(page: page)
        viewModel.load(request: request, page: page)
    }
// MARK: - Setup UI
    fileprivate func setupNavifationConroller() {
        guard let navigationBar = navigationController?.navigationBar else { return }
               navigationBar.prefersLargeTitles = true
               navigationBar.barStyle = .black
               navigationBar.largeTitleTextAttributes = [
                           NSAttributedString.Key.foregroundColor: UIColor.white
                       ]
               navigationBar.titleTextAttributes = [
                           NSAttributedString.Key.foregroundColor: UIColor.white
                       ]

               navigationBar.setBackgroundImage(navImage, for: UIBarMetrics.default)
               navigationBar.shadowImage = navImage
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.backgroundColor = #colorLiteral(red: 0.1058690622, green: 0.1058908626, blue: 0.105864279, alpha: 1)
        tableView.anchor(top: view.topAnchor,
                                 leading: view.safeAreaLayoutGuide.leadingAnchor,
                                 bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                 trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(LocationCell.self)
    }
}

// MARK: - UITableViewDataSource
extension LocationViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: LocationCell = tableView.dequeueReusableCell(for: indexPath)
        cell.configure(with: viewModel.items[indexPath.row])
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
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = LocationDetailsViewController()
        vc.item = viewModel.location(for: indexPath)
        show(vc, sender: nil)
    }
}
