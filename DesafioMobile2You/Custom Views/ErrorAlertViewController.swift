//
//  ErrorAlertViewController.swift
//  DesafioMobile2You
//
//  Created by Ricardo H. T. N. Brancaglion on 16/08/20.
//  Copyright © 2020 Ricardo H. T. N. Brancaglion. All rights reserved.
//

import UIKit

class ErrorAlertViewController: UIViewController {
        
    private lazy var containerView: UIView = .errorAlertContainer()
    
    private lazy var titleLabel: UILabel = .titleLabel(
        with: "Ops! Ocorreu algum erro",
        font: UIFont.systemFont(ofSize: 20, weight: .bold),
        textAlignment: .center
    )
    
    private lazy var messageLabel: UILabel = .bodyLabel(
        with: "Tente novamente mais tarde.",
        textAlignment: .center
    )
    
    private lazy var actionButton: UIButton = .errorAlertButton(
        with: .systemBlue,
        title: "Ok"
    )

    let padding: CGFloat = 20
    
    init(title: String, message: String, buttonTitle: String) {
        super.init(nibName: nil, bundle: nil)
        titleLabel.text = title
        messageLabel.text = message
        actionButton.setTitle(buttonTitle, for: .normal)
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.75)
        
        configure()
    }
    
    func configure() {
        view.add(containerView, then: {
            let containerView: UIView = $0
            
            NSLayoutConstraint.activate([
                containerView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
                containerView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
                containerView.widthAnchor.constraint(equalToConstant: 280),
                containerView.heightAnchor.constraint(equalToConstant: 220)
            ])
            
            view.add(titleLabel, then: {
                let titleLabel: UILabel = $0
                
                NSLayoutConstraint.activate([
                    titleLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: padding),
                    titleLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                    titleLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                    titleLabel.heightAnchor.constraint(equalToConstant: 28)
                ])
                
                view.add(actionButton, then: {
                    let actionButton: UIButton = $0
                    
                    actionButton.addTarget(self, action: #selector(dismissVC), for: .touchUpInside)
                    
                    NSLayoutConstraint.activate([
                        actionButton.bottomAnchor.constraint(equalTo: containerView.bottomAnchor, constant: -padding),
                        actionButton.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                        actionButton.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                        actionButton.heightAnchor.constraint(equalToConstant: 44)
                    ])
                    
                    view.add(messageLabel, then: {
                        let messageLabel: UILabel = $0
                        
                        NSLayoutConstraint.activate([
                            messageLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
                            messageLabel.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: padding),
                            messageLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -padding),
                            messageLabel.bottomAnchor.constraint(equalTo: actionButton.topAnchor, constant: -12)
                        ])
                    })
                })
            })
        })
    }
        
    @objc func dismissVC() {
        dismiss(animated: true)
    }
}
