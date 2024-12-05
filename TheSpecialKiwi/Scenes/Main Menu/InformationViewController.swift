//
//  InformationViewController.swift
//  TheSpecialKiwi
//
//  Created by Muhammad Afif Fadhlurrahman on 20/08/24.
//

import UIKit

class InformationViewController: UIViewController {
    let scrollView = UIScrollView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(named: "ColorSecondary")
        
        addBackgroundImage()
    }
    
    func addBackgroundImage(){
        // Create a UIImageView
        let imageView = UIImageView()
        
        // Set the image
        imageView.image = UIImage(named: "InformationBackground")
        
        // Set content mode
        imageView.contentMode = .scaleAspectFit
        
        // Enable Auto Layout
        imageView.translatesAutoresizingMaskIntoConstraints = false
        
        // Add imageView to the view
        self.view.addSubview(imageView)
        
        // Set up Auto Layout constraints for imageView
        NSLayoutConstraint.activate([
            imageView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            imageView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor),
            imageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.85),
            imageView.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 0.9)
        ])
        
        // Add a green border (stroke) to the imageView
        imageView.layer.borderColor = UIColor(named: "ColorBackgroundAccents")?.cgColor
        imageView.layer.borderWidth = 4.0
        imageView.layer.cornerRadius = 10.0
        
        // Create a UIImageView
        let informationHeader = UIImageView()
        informationHeader.image = UIImage(named: "InformationHeader")
        informationHeader.contentMode = .scaleAspectFit
        informationHeader.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(informationHeader)
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            informationHeader.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -175),
            informationHeader.topAnchor.constraint(equalTo: imageView.topAnchor, constant: -30),
            informationHeader.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            informationHeader.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.7),
            informationHeader.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.4)
        ])
        
        // Add Sentences
        // Create a UIScrollView
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(scrollView)
        
        // Create a UILabel to display the long text
        let textLabel = UILabel()
        textLabel.text = """
                The Special Kiwi is an educational series of mini-games, created to teach students on how to interact with their autistic friends.
                
                This project is researched and developed by Tim Luar Biasa, consisting of Ariq, Afif, James, Justin, Josefany, and Stanley.
                """
        textLabel.numberOfLines = 0
        //textLabel.font = UIFont.systemFont(ofSize: 13)
        textLabel.font = UIFont(name: "Sora", size: 13)
        textLabel.translatesAutoresizingMaskIntoConstraints = false
        
        // Add the label to the scroll view
        scrollView.addSubview(textLabel)
        
        // Set up Auto Layout constraints for scrollView inside the image
        NSLayoutConstraint.activate([
            scrollView.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -70),
            scrollView.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 100),
            scrollView.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            scrollView.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.3),
            scrollView.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.8)
        ])
        
        // Set up constraints for textLabel inside scrollView
        NSLayoutConstraint.activate([
            textLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            textLabel.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor),
            textLabel.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor),
            textLabel.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor),
            textLabel.widthAnchor.constraint(equalTo: scrollView.widthAnchor)
        ])
        
        // Create a UIImageView
        let imageView1 = UIImageView()
        imageView1.image = UIImage(named: "InformationCharacter")
        imageView1.contentMode = .scaleAspectFit
        imageView1.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(imageView1)
        
        // Set up Auto Layout constraints
        NSLayoutConstraint.activate([
            imageView1.trailingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: -350),
            imageView1.topAnchor.constraint(equalTo: imageView.topAnchor, constant: 70),
            imageView1.centerYAnchor.constraint(equalTo: imageView.centerYAnchor),
            imageView1.widthAnchor.constraint(equalTo: imageView.widthAnchor, multiplier: 0.4),
            imageView1.heightAnchor.constraint(equalTo: imageView.heightAnchor, multiplier: 0.8)
        ])
    }
    
    func addLabel(){
       // change to here!
    }
}

