//
//  ValorantView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

protocol SelectListViewDelegate: AnyObject {
    func didSelectAgent(id: String)
}

class SelectListView: UIView {
    
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
    
    private let title: UILabel = {
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
        return search
    }()
    
    private let tableView = UITableView()
    
    var isSearched = false
    
    var filtered: [SelectListItem] = []

    func update(with Item: [SelectListItem]) {
        self.filtered = Item
        tableView.reloadData()
    }
    
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
        
        cell.configure(name: item.title, imageUrl: item.icon)
        
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
}

extension SelectListView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let ItemFilter = viewModel?.listItems ?? []
        
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            isSearched = false
            filtered = ItemFilter
        } else {
            isSearched = true
            
            filtered = ItemFilter.filter { agent in
                agent.title
                    .lowercased()
                    .contains(searchText.lowercased())
            }
            
        }
        tableView.reloadData()
    }
}
