//
//  ViewController.swift
//  3-MitsuPrevention
//
//  Created by 吉川椛 on 2020/04/10.
//  Copyright © 2020 com.litech. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let name: UILabel = {
       let text = UILabel()
        text.translatesAutoresizingMaskIntoConstraints = false
        text.font = UIFont(name: "Avenir-Heavy", size: 50)
        text.text = "Face AI"
        text.textColor = .label
        return text
        
    }()
    
    let faceDetection: BtnPleinLarge = {
        let button = BtnPleinLarge()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(buttonToFaceDetection(_:)), for: .touchUpInside)
        button.setTitle("Face detection", for: .normal)
        let icon = UIImage(systemName: "person.3.fill")?.resized(newSize: CGSize(width: 50, height: 25))
        button.addRightImage(image: icon!, offset: 30)
        button.backgroundColor = .systemOrange
        button.layer.borderColor = UIColor.systemOrange.cgColor
        button.layer.shadowOpacity = 0.3
        button.layer.shadowColor = UIColor.systemOrange.cgColor
        
        return button
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        setupTabBar()
        setupLabel()
        setupButtons()
    }
    
    func setupTabBar() {
        navigationController?.navigationBar.prefersLargeTitles = true
        self.navigationItem.title = "Face AI"
        if #available(iOS 13.0, *) {
            self.navigationController?.navigationBar.barTintColor = .systemBackground
             navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            self.navigationController?.navigationBar.barTintColor = .lightText
            navigationController?.navigationBar.titleTextAttributes = [.foregroundColor : UIColor.black]
        }
        self.navigationController?.navigationBar.isHidden = false
        self.setNeedsStatusBarAppearanceUpdate()
        self.navigationItem.largeTitleDisplayMode = .automatic
        self.navigationController?.navigationBar.barStyle = .default
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.label]
        } else {
            navigationController?.navigationBar.largeTitleTextAttributes = [.foregroundColor : UIColor.black]
        }
        if #available(iOS 13.0, *) {
            navigationController?.navigationBar.backgroundColor = .systemBackground
        } else {
            navigationController?.navigationBar.backgroundColor = .white
        }
        self.tabBarController?.tabBar.isHidden = false
    }
    
    private func setupLabel() {
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        name.heightAnchor.constraint(equalToConstant: 100).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        name.numberOfLines = 1
    }
    
    private func setupButtons() {
        
        view.addSubview(faceDetection)
        
        faceDetection.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        faceDetection.widthAnchor.constraint(equalToConstant: view.frame.width - 40).isActive = true
        faceDetection.heightAnchor.constraint(equalToConstant: 70).isActive = true
    }
    
    @objc func buttonToFaceDetection(_ sender: BtnPleinLarge) {
           
       let controller = FaceDetectionViewController()

       let navController = UINavigationController(rootViewController: controller)
       
       self.present(navController, animated: true, completion: nil)
    }

}

