//
//  HomeweaponsView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 22/05/26.
//


import UIKit

protocol HomeWeaponsViewDelegate: AnyObject {
    func didSelectWeapons(id: String)
}

class HomeWeaponsView: UIView {
    
    var viewModel: HomeWeaponsViewModel? {
        didSet {
            setupViewData()
        }
    }
    
    private let weaponsTitle: UILabel = {
        let title = UILabel()
        title.text = "Armas"
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
    
    var delegate: HomeWeaponsViewDelegate?
    
    var tableView = UITableView()
    
    var isSearched = false
    var filteredWeapons: [WeaponsModel] = []
    
    init(){
        super.init(frame: .zero)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViewData(){
        tableView.reloadData()
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    private func setupView() {
        setupTableView()
        addSubview(tableView)
        addSubview(weaponsTitle)
        tableView.tableHeaderView = searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            weaponsTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            weaponsTitle.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            weaponsTitle.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: weaponsTitle.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
}
extension HomeWeaponsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let weapons = isSearched ? filteredWeapons : (viewModel?.weapons ?? [])
        return weapons.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomCell.identifier,
            for: indexPath
        ) as? CustomCell else {
            return UITableViewCell()
        }
        let weapons = isSearched ? filteredWeapons : (viewModel?.weapons ?? [])
        
        guard indexPath.row < weapons.count else {
                return UITableViewCell()
            }
        
        
         let weapon = weapons[indexPath.row]
        
        cell.configure(name: weapon.displayName, imageUrl: weapon.displayIcon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let weapons = isSearched ? filteredWeapons : (viewModel?.weapons ?? [])
        
        delegate?.didSelectWeapons(id: weapons[indexPath.row].uuid)
    }
}

extension HomeWeaponsView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let weapons = viewModel?.weapons ?? []

        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            isSearched = false
            filteredWeapons = weapons
        } else {
            isSearched = true
            
            filteredWeapons = weapons.filter { agent in
                agent.displayName
                    .lowercased()
                    .contains(searchText.lowercased())
            }

        }
        tableView.reloadData()
    }
}

