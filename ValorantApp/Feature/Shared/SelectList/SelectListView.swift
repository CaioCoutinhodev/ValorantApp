//
//  ValorantView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

protocol SelectListViewDelegate: AnyObject {
    func didSelectAgent(id: String)
    func favorite(id: String)
}

class SelectListView: UIView {
    
    var favoriteKey: FavoriteKey?
    
    var viewModel: SelectListViewModel? {
        didSet {
            setupViewData()
        }
    }
    
    weak var delegate: SelectListViewDelegate?
    
    private func setupViewData() {
        guard let viewModel = viewModel else {
            return
        }
        
        
        tableView.allowsSelection = viewModel.canSelectList
        tableView.reloadData()
    }
    
    let title: UILabel = {
        let title = UILabel()
        title.font = .systemFont(ofSize: 35)
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()
    
    let searchBar: UISearchBar = {
        let search = UISearchBar(frame: CGRect(x: 0, y: 0, width: 0, height: 40))
        search.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "pesquisar"
        )
        search.barTintColor = Utils.AppColors.BackgroundColor
        return search
    }()
    
    private let tableView = UITableView()
    
    var isSearched = false
    
    var filtered: [SelectListItem] = []

    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    init(title: String) {
        self.title.text = title
        super.init(frame: .zero)
        setupView()
        searchBar.delegate = self
        print()
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    private func setupView() {
        setupTableView()
        addSubview(tableView)
        addSubview(title)
        tableView.tableHeaderView = searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            title.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            title.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
}

extension SelectListView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let items = isSearched ? filtered : (viewModel?.listItems ?? [])
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomCell.identifier,
            for: indexPath
        ) as? CustomCell else {
            return UITableViewCell()
        }
        
        let items = isSearched ? filtered : (viewModel?.listItems ?? [])
        
        guard indexPath.row < items.count else {
            return UITableViewCell()
        }
        
        let item = items[indexPath.row]
        
        var isFavorite = false
        
        if let key = favoriteKey {
            isFavorite = FavoriteService.favorites(key: key).contains(item.id)
        }
        
        cell.configure(
            name: item.title,
            imageUrl: item.icon,
            isFavorite: isFavorite
        )
        cell.delegate = self
        cell.backgroundColor = Utils.AppColors.BackgroundColor
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        cell?.selectionStyle = .none
        
        let ItemSelected = isSearched ? filtered : (viewModel?.listItems ?? [])
        
        delegate?.didSelectAgent(id: ItemSelected[indexPath.row].id)
    }
    
    func tableView(_ tableView: UITableView,
                   leadingSwipeActionsConfigurationForRowAt indexPath: IndexPath)
    -> UISwipeActionsConfiguration? {
        
        let items = isSearched ? filtered : (viewModel?.listItems ?? [])
        
        guard indexPath.row < items.count else {
            return nil
        }
        
        let item = items[indexPath.row]
        
        var isFavorite = false
        
        if let key = favoriteKey {
            isFavorite = FavoriteService.favorites(key: key).contains(item.id)
        }
        
        let favoriteAction = UIContextualAction(
            style: .normal,
            title: isFavorite ? "Remover" : "Favoritar"
        ) { [weak self] _, _, completion in
            
            guard let self = self else {
                completion(false)
                return
            }
            
            self.delegate?.favorite(id: item.id)
            
            completion(true)
        }
        
        favoriteAction.backgroundColor = .systemYellow
        favoriteAction.image = UIImage(systemName: isFavorite ? "star.slash.fill" : "star.fill")
        
        return UISwipeActionsConfiguration(actions: [favoriteAction])
    }
}

extension SelectListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let items = viewModel?.listItems ?? []
        
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            isSearched = false
            filtered = items
        } else {
            isSearched = true
            
            filtered = items.filter { item in
                item.title
                    .lowercased()
                    .contains(searchText.lowercased())
            }
            
            if let key = favoriteKey {
                let favorites = FavoriteService.favorites(key: key)
                
                filtered.sort { first, second in
                    let firstFavorite = favorites.contains(first.id)
                    let secondFavorite = favorites.contains(second.id)
                    
                    if firstFavorite == secondFavorite {
                        return first.title < second.title
                    }
                    
                    return firstFavorite
                }
            }
        }
        
        tableView.reloadData()
    }
}
extension SelectListView: CustomCellDelegate {

    func didTapFavorite(in cell: CustomCell) {
        guard let indexPath = tableView.indexPath(for: cell) else { return }

        let items = isSearched ? filtered : (viewModel?.listItems ?? [])
        let item = items[indexPath.row]

        delegate?.favorite(id: item.id)
    }
}
