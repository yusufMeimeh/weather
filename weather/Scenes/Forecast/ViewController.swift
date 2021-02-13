//
//  ViewController.swift
//  weather
//
//  Created by Yusuf Meimeh on 2/6/21.
//

import UIKit

class ViewController: UIViewController {
    
    let viewModel = HomeViewModel()
    @IBOutlet private weak var activityIndicator : UIActivityIndicatorView!
    @IBOutlet private weak var tableView : UITableView!
    @IBOutlet private weak var cityButtonItem : UIBarButtonItem!
    
    @IBOutlet private weak var cityNameLabel : UILabel!
    @IBOutlet private weak var tempLabel : UILabel!
    @IBOutlet private weak var hLabel : UILabel!
    @IBOutlet private weak var lLabel : UILabel!
    @IBOutlet private weak var iconImageView : UIImageView!
    @IBOutlet private weak var weatherStatusLabel : UILabel!
    
    @IBOutlet private weak var sourceSwitch : UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        checkSelectedCity()
        bindViewModel()
        registerNibs()
    }
    
    private func registerNibs(){
        tableView.register(reusable: DayTableViewCell.self, estimated: 130)
    }
    
    
    private func bindViewModel(){
        viewModel.reloadData = {[weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.isHidden = false
                self.fillCityInfo()
            }
        }
        
        viewModel.showLoading = {[weak self] show in
            guard let self = self else { return }
            DispatchQueue.main.async {
                show ? self.activityIndicator.startAnimating() : self.activityIndicator.stopAnimating()
            }
        }
        
        viewModel.handelErrorMessage = { [weak self] msg in
            guard let self = self else { return }
            if let msg = msg , !msg.isEmpty{
                self.showAlert(with: "Error!", message: msg)
            }
        }
    }
    
    private func fillCityInfo(){
        guard let object = viewModel.displayedObject else {
            self.tableView.isHidden = true
            return
        }
        self.tableView.isHidden = false
        
        cityNameLabel.text = object.city.name
        if let first = object.list.first{
            tempLabel.text = first.main.getTempValue()
            hLabel.text = "\(first.main.humidity)"
            lLabel.text = "\(first.main.grndLevel)"
            
            if let weather = first.weather.first{
                iconImageView.image = UIImage(named: weather.icon ?? "")
                weatherStatusLabel.text = weather.main
            }
        }
    }
    private func checkSelectedCity(){
        if let city = Utils.getSelectedCity(){
            viewModel.getForecast()
            cityButtonItem.title = city.name
        }else{
            cityButtonItem.title = "Select City"
            changeCity()
        }
    }
    
    @IBAction private func sourceChanged(){
        viewModel.isFromLocalFile = sourceSwitch.isOn
    }
    
    @IBAction private func changeCity(){
        Navigation.showPicker(from: self, selectedCity: Utils.getSelectedCity()) { [weak self] (city) in
            guard let self = self else {return}
            Utils.setSelectedCity(city: city)
            if let city = city{
                self.cityButtonItem.title = city.name
                self.viewModel.getForecast()
            }
        }
    }
    
}


extension ViewController : UITableViewDelegate , UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfItems
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: DayTableViewCell.identifier, for: indexPath) as! DayTableViewCell
        
        cell.group = viewModel.group(at: indexPath.row)
        
        return cell
    }
}
