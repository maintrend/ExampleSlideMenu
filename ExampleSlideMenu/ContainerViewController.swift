//
//  ContainerViewController.swift
//  ExampleSlideMenu
//
//  Created by talgat on 7/4/21.
//


import UIKit


class ContainerViewController: UIViewController {
    
    enum MenuState {
        case opened
        case closed
    }
    
    private var menuState: MenuState = .closed
    let menuVC = MenuViewController()
    let homeVC = HomeViewController()
    var navVC: UINavigationController?
    lazy var infoVC = InfoViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addChildsVC()
    }
    
    private func addChildsVC() {
        
        menuVC.delegate = self
        
       addChild(menuVC)
        view.addSubview(menuVC.view)
        menuVC.didMove(toParent: self)
        
        homeVC.delegate = self
        let navVC = UINavigationController(rootViewController: homeVC)
        addChild(navVC)
        view.addSubview(navVC.view)
        navVC.didMove(toParent: self)
        self.navVC = navVC
    }
}

extension ContainerViewController: HomeViewControllerDelegate {
    func didTapButtonMenu() {
       toggleMenu(completion: nil)
    }
    
    func toggleMenu(completion: (() -> Void)?) {
        switch menuState {
        case .closed:
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.navVC?.view.frame.origin.x = self.homeVC.view.frame.size.width - 100
                
            } completion: { [weak self] (done) in
                if done {
                    self?.menuState = .opened
                }
            }

        case .opened:
            
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 0, options: .curveEaseOut) {
                
                self.navVC?.view.frame.origin.x = 0
                
            } completion: { [weak self] (done) in
                if done {
                    self?.menuState = .closed
                    DispatchQueue.main.async {
                        completion?()
                    }
                }
            }
            
            break
       
        }
    }
}


extension ContainerViewController: MenuViewControllerDelegate {
    
    func didSelect(menuItem: MenuViewController.MenuOption) {
       
        toggleMenu(completion: nil)
        
        switch menuItem {
        
        case .home:
            self.resetToHome()
        case .info:
            self.addInfo()
        case .appRating:
            break
        case .shareApp:
            break
        case .setting:
            break
  
        }
    }
        
        func addInfo() {
            let vc = infoVC
            homeVC.addChild(vc)
            homeVC.view.addSubview(vc.view)
            vc.view.frame = view.frame
            vc.didMove(toParent: homeVC)
            homeVC.title = vc.title
        }
    
    func resetToHome() {
        infoVC.view.removeFromSuperview()
        infoVC.didMove(toParent: nil)
        homeVC.title = "Home"
    }
    
}
