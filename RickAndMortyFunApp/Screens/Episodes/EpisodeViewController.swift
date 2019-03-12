//
//  EpisodeViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

class EpisodeViewController: UIViewController {

    // MARK: - Views

    var episodeTableView = UITableView()
    var refreshControll = UIRefreshControl()

    // MARK: - Properties
    var itemsGrouped: [[Episode]] = []
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
        setupRefreshControll()
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
        refreshControll.endRefreshing()
    }

    // MARK: - Private

    private func loadPage(_ page: Int) {
        let request = RickAndMortyRouter.getEpisode(page: page)
        viewModel.load(request: request, page: page)
    }

    private func makeSectionsAndRowsArray() {
        itemsGrouped = Dictionary(grouping: viewModel.items) { $0.season }
            .sorted { $0.key < $1.key }
            .map { $0.value }
    }

    private func setFooterView(for state: State<Episode>) {
        let footer = FooterView<Episode>()
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
        episodeTableView.delegate = self
        episodeTableView.refreshControl = refreshControll
        episodeTableView.register(EpisodeCell.self)
    }

    private func setupRefreshControll() {
        refreshControll.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        refreshControll.backgroundColor = .gray
        refreshControll.tintColor = .green
    }
}

// MARK: - UITableViewDataSource
extension EpisodeViewController: UITableViewDataSource {

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return itemsGrouped[section].first?.season
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return itemsGrouped.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itemsGrouped[section].count//viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: EpisodeCell = tableView.dequeueReusableCell(for: indexPath)
        cell.episode = itemsGrouped[indexPath.section][indexPath.row]//viewModel.items[indexPath.row]

        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == itemsGrouped[indexPath.section].count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension EpisodeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //        let vc = DetailsViewController()
        //        let location = viewModel.items[indexPath.row]
        //        vc.location = location
        //        show(vc, sender: nil)
    }
}
