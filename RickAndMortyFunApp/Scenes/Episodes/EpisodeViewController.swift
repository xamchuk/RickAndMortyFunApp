//
//  EpisodeViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

struct Section<T> {
    let title: String?
    let rows: [T]
}

class EpisodeViewController: UIViewController {

    // MARK: - Views

    var tableView = UITableView()

    // MARK: - Properties

    var viewModel: EpisodeViewModel

    // MARK: - Init

    init(viewModel: EpisodeViewModel = .init()) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - Life cycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        navigationController?.navigationBar.prefersLargeTitles = true
        setupTableView()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        loadPage(1)

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

    private func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getEpisode(page: page)
        viewModel.load(request: request, page: page)
    }

    private func setFooterView(for state: State<Episode>) {
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

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.dataSource = self
        tableView.register(EpisodeCell.self)
    }
}

// MARK: - UITableViewDataSource
extension EpisodeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return viewModel.sections[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel.sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EpisodeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.episode = viewModel.sections[indexPath.section].rows[indexPath.row]
        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == viewModel.sections[indexPath.section].rows.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}
