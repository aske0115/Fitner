//
//  HomeViewController.swift
//  Fitner
//
//  Created by Aske on 2022/12/17.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private lazy var collectionView: UICollectionView = {
        var layout = UICollectionViewFlowLayout()
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(ProgramCollectionViewCell.self, forCellWithReuseIdentifier: "ProgramCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        initSubviews()
        // Do any additional setup after loading the view.
    }
    
    private func initSubviews() {
        setupNavigationBar()
        makeCollectionView()
    }
    
    private func makeCollectionView() {
        self.view.addSubview(collectionView)
        collectionView.snp.makeConstraints { make in
            make.edges.equalTo(self.view)
        }
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

extension HomeViewController : UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell  = collectionView.dequeueReusableCell(withReuseIdentifier: "ProgramCell", for: indexPath) as! ProgramCollectionViewCell
        cell.configure("asglaskndgls")
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
}
