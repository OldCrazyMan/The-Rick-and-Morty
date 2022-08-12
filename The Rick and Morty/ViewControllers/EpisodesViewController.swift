//
//  EpisodesViewController.swift
//  The Rick and Morty
//
//  Created by Тимур Ахметов on 01.08.2022.
//

import UIKit

final class EpisodesViewController: UIViewController {
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.rowHeight = 120
        tableView.backgroundColor = .specialCellBackground
        tableView.separatorColor = .specialBlueLabel
        tableView.showsVerticalScrollIndicator = false
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    private var characterCount = 0
    private var page = 1
    private var nextPage = true
    private var isFiltred = false
    private let idTableViewCell = "idTableViewCell"
    private var searchController = UISearchController()
    
    private var searchedText = String()
    private var characters: PagedEpisode?
    private var resultsArray = [Episode]()
    private var filtredArray = [Episode]()
    
    //MARK: - Override
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fetchCharacters(page: page)
        navigationBarSettings()
        setupViews()
        setupDelegate()
        setConstraints()
        
        tableView.register(EpisodesTableViewCell.self, forCellReuseIdentifier: idTableViewCell)
    }
    
    //MARK: - Setups
    
    private func setupViews() {
        view.backgroundColor = .specialCellBackground
        view.addSubview(tableView)
    }
    
    private func setupDelegate() {
        tableView.delegate = self
        tableView.dataSource = self
        
        searchController.searchBar.delegate = self
    }
    
    private func navigationBarSettings() {
        
        if let navController = navigationController {
            navController.navigationBar.barStyle = .black
            navController.navigationBar.tintColor = .specialYellow
            searchController = UISearchController(searchResultsController: nil)
            searchController.obscuresBackgroundDuringPresentation = false
            searchController.searchBar.returnKeyType = .done
            searchController.searchBar.placeholder = "Search episode..."
            navigationItem.searchController = searchController
            definesPresentationContext = true
            navigationItem.hidesSearchBarWhenScrolling = false
            searchController.isActive = true
        }
    }
    private func refreshData() {
        filtredArray.removeAll()
        isFiltred = false
        tableView.reloadData()
    }
    
    //MARK: - Filtring
    
    private func filtringEpisodes(text: String) {
        for character in resultsArray {
            if character.name.lowercased().contains(text.lowercased())  {
                filtredArray.append(character)
            }
        }
    }
}

extension EpisodesViewController: UISearchBarDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        refreshData()
        return true
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let text = searchBar.text else { return }
        filtredArray = [Episode]()
        filtringEpisodes(text: text)
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        refreshData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        filtredArray = [Episode]()
        isFiltred = (searchText.count > 0 ? true : false)
        filtringEpisodes(text: searchText)
        self.searchedText = searchText
        tableView.reloadData()
    }
}

//MARK: - UITableViewDataSource

extension EpisodesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        isFiltred ? filtredArray.count : resultsArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: idTableViewCell, for: indexPath) as! EpisodesTableViewCell
        let characterModel = isFiltred ? filtredArray[indexPath.row] : resultsArray[indexPath.row]
        cell.cellConfigure(model: characterModel)
        cell.setHiglightToLable(searchText: self.searchedText, text: characterModel.name)
        return cell
    }
}

//MARK: - UITableViewDelegate

extension EpisodesViewController: UITableViewDelegate {
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        let height = scrollView.frame.size.height
        let contentOffset = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        
        if contentOffset > contentHeight - height {
            guard nextPage else { return }
            page += 1
            fetchCharacters(page: page)
        }
    }
}

//MARK: - FetchCharacters

extension EpisodesViewController {
    
    func fetchCharacters(page: Int) {
        NetworkManager.shared.getEpisodes(page: page, name: nil) { [weak self] (episodes) in
            guard let self = self else {return}
            let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: true)
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.5)  {
                self.resultsArray += episodes
                self.tableView.reloadData()
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.1)  {
                    let _ = ActivityIndicator.shared.customActivityIndicatory(self.view, startAnimate: false)
                }
            }
        }
    }
}
//MARK: - SetConstraints

extension EpisodesViewController {
    
    private func setConstraints() {
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    }
}
