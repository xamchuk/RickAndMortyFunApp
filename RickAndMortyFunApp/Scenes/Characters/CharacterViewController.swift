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

    var tableView = UITableView()

    // MARK: - Properties

    var viewModel: CharacterViewModel

    // MARK: - Init

    init(viewModel: CharacterViewModel = .init()) {
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
        setUpTheming()
        viewModel.loadPage(1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        themeProvider.nextTheme()
        viewModel.stateUpdated = { [weak self] state in
            self?.setFooterView(for: state)
            self?.tableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stateUpdated = nil
    }

    // MARK: - Private
    private func setFooterView(for state: State<CharacterOfShow>) {
        switch state {
        case .error(let error):
            let errorView: ErrorView = .fromNib()
            // add var error trouth didSet //
            tableView.tableFooterView = errorView
            errorView.errorLabel.text = error.localizedDescription
        case .loading, .paging:
            let loadingView: LoadingView = .fromNib()
            tableView.tableFooterView = loadingView
        case .empty:
            let emptyView: ErrorView = .fromNib()
            emptyView.errorLabel.text = "No results! Try searching for something different."
            tableView.tableFooterView = emptyView
        case .populated:
            tableView.tableFooterView = nil
        }
    }

    private func setupTableView() {
        view.addSubview(tableView)
        tableView.fillSuperview()
        tableView.separatorStyle = .none
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(CharacterCell.self)
    }
}

// MARK: - UITableViewDataSource
extension CharacterViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: CharacterCell = tableView.dequeueReusableCell(for: indexPath)
        let characters = viewModel.items
        cell.configure(with: characters[indexPath.row])

        if case .paging(_, let nextPage) = viewModel.state,
            indexPath.row == viewModel.items.count - 1 {
            viewModel.loadPage(nextPage)
        }
        return cell
    }
}

// MARK: - UITableViewDelegate
extension CharacterViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = DetailsViewController()
        let character = viewModel.character(for: indexPath)
        vc.character = character
        show(vc, sender: nil)
    }
}

extension CharacterViewController: Themed {
    func applyTheme(_ theme: AppTheme) {
        tableView.backgroundColor = theme.cellBorderColor
        view.backgroundColor = theme.cellBorderColor
    }
}
