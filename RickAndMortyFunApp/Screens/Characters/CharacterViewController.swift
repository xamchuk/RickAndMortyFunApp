//
//  CharacterViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit
import Alamofire

class CharacterViewController: UIViewController {

    // MARK: - Views

    var characterTableView = UITableView()
    var refreshControll = UIRefreshControl()

    // MARK: - Properties

    var viewModel: ViewModel<ItemsResponse<Character>>

    // MARK: - Init

    init(viewModel: ViewModel<ItemsResponse<Character>> = .init()) {
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
            self?.setFooterView(for: state)
            self?.characterTableView.reloadData()
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
        let request = RickAndMortyRouter.getCharacters(page: page)
        viewModel.load(request: request, page: page)
    }

    private func setFooterView(for state: State<Character>) {
        let footer = FooterView<Character>()
        footer.tableView = characterTableView
        footer.setFooterView(for: state)
    }

    private func setupTableView() {
        view.addSubview(characterTableView)
        characterTableView.fillSuperview()
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.refreshControl = refreshControll
        characterTableView.register(CharacterCell.self)
    }

    private func setupRefreshControll() {
        refreshControll.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        refreshControll.backgroundColor = .gray
        refreshControll.tintColor = .green
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        cell.character = viewModel.items[indexPath.row]

        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == viewModel.items.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        let character = viewModel.items[indexPath.row]
        vc.character = character
        show(vc, sender: nil)
    }
}
