//
//  SearchViewController.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/12/21.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet private var tableView : UITableView!
    @IBOutlet private var emptyView : UIView!
    @IBOutlet weak var searchBar : UISearchBar!
    var selectedCity : City?
    let viewModel = SearchViewModel()
    var handler: ((City?) -> Void)?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        buildTableView()
        bindViewModel()
        viewModel.viewDidLoad()
        
    }
    
    private func bindViewModel(){
        viewModel.reloadData = {[weak self] in
            guard let self = self else { return }
            self.tableView.reloadData()
            self.tableView.isHidden = self.viewModel.numberOfItems == 0
            self.emptyView.isHidden = self.viewModel.numberOfItems != 0
        }
        
        
    }
    
    private func buildTableView(){
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    @IBAction private func backAction(_ sender : Any){
        dismiss(animated: true, completion: nil)
    }
}

// MARK: TableView Delegate and DataSource
extension SearchViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let city = viewModel.city(at: indexPath.row)
        cell.textLabel?.text = city.name
        cell.accessoryType = city.id == selectedCity?.id ? .checkmark : .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedCity = viewModel.city(at: indexPath.row)
        tableView.reloadData()
        handler?(selectedCity)
        dismiss(animated: true, completion: nil)
    }
}

// MARK: SearchBar Delegate
extension SearchViewController : UISearchBarDelegate{
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = nil
        viewModel.searchText = nil
        tableView.reloadData()
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.searchText = searchText
    }
}



// MARK: StoryboardInstantiable
extension SearchViewController : StoryboardInstantiable{
    static var storyboardName: String{
        return "Main"
    }
}
