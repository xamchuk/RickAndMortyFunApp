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
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.loadPage(1)

        viewModel.stateUpdated = { [weak self] state in

            self?.viewModel.footer = {
                [weak self] footer in
                footer.tableView = self?.characterTableView
                footer.setFooterView(for: state)
            }
            self?.characterTableView.reloadData()
        }
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        viewModel.stateUpdated = nil
    }

    // MARK: - Private

    private func setupTableView() {
        view.addSubview(characterTableView)
        characterTableView.fillSuperview()
        characterTableView.dataSource = self
        characterTableView.delegate = self
        characterTableView.register(CharacterCell.self)
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
        cell.character = characters[indexPath.row]

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
        let character = viewModel.items[indexPath.row]
        vc.character = character
        show(vc, sender: nil)
    }
}
