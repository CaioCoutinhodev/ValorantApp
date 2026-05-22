//
//  ValorantView.swift
//  ValorantApp
//
//  Created by Jonatas Coutinho de Faria on 23/04/26.
//

import UIKit

protocol HomeListAgentsViewDelegate: AnyObject {
    func didSelectAgent(id: String)
}

class HomeListAgentsView: UIView {
    
    var viewModel: ValorantAgentsViewModel? {
        didSet {
            setupViewData()
        }
    }
    
    weak var delegate: HomeListAgentsViewDelegate?
    
    private func setupViewData() {
        tableView.reloadData()
    }
    
    private let chartersTitle: UILabel = {
        let title = UILabel()
        title.text = "Personagens"
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
    
    var isSearched = false
    
    var filteredCharters: [AgentModel] = []
    
    private let tableView = UITableView()
    
    func update(with agents: [AgentModel]) {
        self.filteredCharters = agents
        tableView.reloadData()
    }
    
    private func setupTableView(){
        self.tableView.dataSource = self
        self.tableView.delegate = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: CustomCell.identifier)
    }
    
    init() {
        super.init(frame: .zero)
        setupView()
        searchBar.delegate = self
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    
    private func setupView() {
        setupTableView()
        addSubview(tableView)
        addSubview(chartersTitle)
        tableView.tableHeaderView = searchBar
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            chartersTitle.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
            chartersTitle.leftAnchor.constraint(equalTo: safeAreaLayoutGuide.leftAnchor, constant: 5),
            chartersTitle.rightAnchor.constraint(equalTo: safeAreaLayoutGuide.rightAnchor, constant: 20),
            
            tableView.topAnchor.constraint(equalTo: chartersTitle.bottomAnchor, constant: 10),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10)
        ])
    }
}

extension HomeListAgentsView: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let agents = isSearched ? filteredCharters : (viewModel?.agents ?? [])
            return agents.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CustomCell.identifier,
            for: indexPath
        ) as? CustomCell else {
            return UITableViewCell()
        }
        let agents = isSearched ? filteredCharters : (viewModel?.agents ?? [])
        
        guard indexPath.row < agents.count else {
                return UITableViewCell()
            }
        
        
         let agent = agents[indexPath.row]
        
        cell.configure(name: agent.displayName, imageUrl: agent.displayIcon)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let agents = isSearched ? filteredCharters : (viewModel?.agents ?? [])
        
        delegate?.didSelectAgent(id: agents[indexPath.row].uuid)
    }
}

extension HomeListAgentsView: UISearchBarDelegate {
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        
        let agents = viewModel?.agents ?? []

        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            isSearched = false
            filteredCharters = agents
        } else {
            isSearched = true
            
            filteredCharters = agents.filter { agent in
                agent.displayName
                    .lowercased()
                    .contains(searchText.lowercased())
            }

        }
        tableView.reloadData()
    }
}
