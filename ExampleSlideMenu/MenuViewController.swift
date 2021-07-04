//
//  MenuViewController.swift
//  ExampleSlideMenu
//
//  Created by talgat on 7/4/21.
//

import UIKit

protocol MenuViewControllerDelegate: AnyObject {
    func didSelect(menuItem: MenuViewController.MenuOption )
}

class MenuViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    
    weak var delegate: MenuViewControllerDelegate?
    
    enum MenuOption: String, CaseIterable {
        case home = "Home"
        case info = "Information"
        case appRating = "App rating"
        case shareApp = "Share App"
        case setting = "Setting"
        
        var imageName: String {
            switch self {
            
            case .home:
                return "house"
            case .info:
                return "airplane"
            case .appRating:
                return "star"
            case .shareApp:
                 return "message"
            case .setting:
                return "gear"
            }
        }
    }
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        tableView.backgroundColor = .orange
        return tableView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = CGRect(x: 0, y: view.safeAreaInsets.top, width: view.bounds.size.width, height: view.bounds.size.height)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(tableView)
        view.backgroundColor = .orange
        
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MenuOption.allCases.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = MenuOption.allCases[indexPath.row].rawValue
        cell.backgroundColor = .orange
        cell.contentView.backgroundColor = .orange
        cell.textLabel?.textColor = .white
        cell.imageView?.tintColor = .white
        cell.imageView?.image = UIImage(systemName: MenuOption.allCases[indexPath.row].imageName)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath , animated: true)
        let item = MenuOption.allCases[indexPath.row]
        delegate?.didSelect(menuItem: item)
    }
}
