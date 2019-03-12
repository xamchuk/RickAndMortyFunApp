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

    var episodeTableView = UITableView()

    // MARK: - Properties
    var sections: [Section<Episode>] = []
    var viewModel: ViewModel<ItemsResponse<Episode>>

    // MARK: - Init

    init(viewModel: ViewModel<ItemsResponse<Episode>> = .init()) {
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
            self?.makeSectionsAndRowsArray()
            self?.setFooterView(for: state)
            self?.episodeTableView.reloadData()
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

    private func makeSectionsAndRowsArray() {
        sections = Dictionary(grouping: viewModel.items) { $0.season }
            .sorted { $0.key < $1.key }
            .map { Section(title: $0.value.first?.season, rows: $0.value) }
    }

    private func setFooterView(for state: State<Episode>) {
        let footer = Footer()
        footer.tableView = episodeTableView
        footer.setFooterView(for: state)
    }

    private func setupTableView() {
        view.addSubview(episodeTableView)
        episodeTableView.anchor(top: view.safeAreaLayoutGuide.topAnchor,
                                leading: view.safeAreaLayoutGuide.leadingAnchor,
                                bottom: view.safeAreaLayoutGuide.bottomAnchor,
                                trailing: view.safeAreaLayoutGuide.trailingAnchor)
        episodeTableView.dataSource = self
        episodeTableView.register(EpisodeCell.self)
    }
}

// MARK: - UITableViewDataSource
extension EpisodeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].title
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].rows.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EpisodeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.episode = sections[indexPath.section].rows[indexPath.row]
        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == sections[indexPath.section].rows.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}
