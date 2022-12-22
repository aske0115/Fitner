//
//  HomeViewController.swift
//  Fitner
//
//  Created by Aske on 2022/12/17.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .red
        initSubviews()
        // Do any additional setup after loading the view.
    }
    
    private func initSubviews() {
        setupNavigationBar()
    }
    
    private func setupNavigationBar() {
        self.navigationItem.title = "FitStrap"
        let  settingButton = UIBarButtonItem(image: UIImage(systemName: "gearshape.fill"), style: .plain, target: self, action: #selector(self.pressSettingButton))
        navigationItem.rightBarButtonItem = settingButton
    }

    
    @objc func pressSettingButton() {
        print("press Setting Button")
    }
}

