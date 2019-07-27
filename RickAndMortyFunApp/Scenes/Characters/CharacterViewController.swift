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
    var navImage: UIImage!

// MARK: - Properties
    var viewModel: CharacterViewModel
    var pointX: CGFloat!
    var pointY: CGFloat!
    var selectedFrame: CGRect?
    var selectedImage: UIImage?
    var alpha: CGFloat!

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
        navImage = navigationController?.navigationBar.backgroundImage(for: .default)
        setupTableView()
        viewModel.loadPage(1)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNavigationBar()
// TODO: - for some reason cell doesnt deselect automaticly. I dont know why:(
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
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

    private func setupNavigationBar() {
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
        navigationController?.show(vc, sender: nil)
    }
}
