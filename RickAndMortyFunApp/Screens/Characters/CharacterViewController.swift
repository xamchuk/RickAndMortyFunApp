//
//  CharacterViewController.swift
//  RickAndMortyFunApp
//
//  Created by Rusłan Chamski on 24/02/2019.
//  Copyright © 2019 Rusłan Chamski. All rights reserved.
//

import UIKit

enum State {
    case loading
    case populated([Character])
    case paging([Character], next: Int)
    case empty
    case error(Error)

    var currentCharacters: [Character] {
        switch self {
        case .paging(let character, _):
            return character
        case .populated(let characters):
            return characters
        default:
            return []
        }
    }
}

class CharacterViewController: UIViewController {

    var tableView = UITableView()
    var refreshControll = UIRefreshControl()
    var networkService: NetworkService
    var state = State.loading {
        didSet {
            setFooterView()
            tableView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
        loadCharacters()
    }

    init(networkService: NetworkService) {
        self.networkService = networkService
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc func loadCharacters() {
        state = .loading
        loadPage(1)
    }

    @objc func refreshTableView() {
        loadCharacters()
        refreshControll.endRefreshing()
    }

    func loadPage(_ page: Int) {
        networkService.loadCharacters(page: page ) { [weak self] response in
            guard let `self` = self else {
                return
            }
            self.update(response: response)
        }
    }

    func update(response: CharactersResult) {
        if let error = response.error {
            state = .error(error)
            return
        }
        guard let newCharacters = response.characters?.results,
            !newCharacters.isEmpty else {
                state = .empty
                return
        }
        var allCharacters = state.currentCharacters
        allCharacters.append(contentsOf: newCharacters)
        if response.hasMorePages {
            state = .paging(allCharacters, next: response.nextPage)
        } else {
            state = .populated(allCharacters)
        }
    }
    
    func setFooterView() {
        switch state {
        case .error(let error):
            let errorView = ErrorView()
            tableView.tableFooterView = errorView
            errorView.fillSuperview()
            errorView.errorLabel.text = error.localizedDescription
        case .loading:
            let loadingView = LoadingView()
            tableView.tableFooterView = loadingView
        case .paging:
            let loadingView = LoadingView()
            tableView.tableFooterView = loadingView
        case .empty:
            let emptyView = EmptyView()
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        }
    }

    fileprivate func setupTableView() {
        view.addSubview(tableView)
        tableView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.safeAreaLayoutGuide.leadingAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, trailing: view.safeAreaLayoutGuide.trailingAnchor)
        tableView.dataSource = self
        tableView.delegate = self
        refreshControll.addTarget(self, action: #selector(refreshTableView), for: .valueChanged)
        refreshControll.backgroundColor = .gray
        refreshControll.tintColor = .green
        tableView.refreshControl = refreshControll
        tableView.register(CharacterCell.self)
    }
}

extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return state.currentCharacters.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        let character = state.currentCharacters[indexPath.row]
        cell.character = character

        if case .paging(_, let nextPage) = state,
            indexPath.row == state.currentCharacters.count - 1 {
            loadPage(nextPage)
        }
        return cell
    }
}

extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        let character = state.currentCharacters[indexPath.row]
        vc.character = character
        show(vc, sender: nil)
    }
}
