//
//  RouteInfoCollectionViewCell.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteInfoCollectionViewCell: UICollectionViewCell {
    
    
    private var containerView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    public var routeID: String = ""
    
    private var routeNameLabel: UILabel = {
        let routeNameLabel = UILabel()
        routeNameLabel.translatesAutoresizingMaskIntoConstraints = false
        routeNameLabel.font = UIFont.boldSystemFont(ofSize: 24)
        routeNameLabel.textColor = .black
        return routeNameLabel
    }()
        
    private var sourceDestinationNameLabel: UILabel = {
        let nameLabel = UILabel()
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        nameLabel.font = UIFont.boldSystemFont(ofSize: 20)
        nameLabel.textColor = .black
        return nameLabel
    }()
        
    private var timeDurationLabel: UILabel = {
        let totalDuration = UILabel()
        totalDuration.translatesAutoresizingMaskIntoConstraints = false
        totalDuration.font = UIFont.boldSystemFont(ofSize: 18)
        totalDuration.textColor = .black
        return totalDuration
    }()
    
    override var isSelected: Bool {
        didSet{
            if isSelected == false {
                self.containerView.backgroundColor = .systemTeal
            } else {
                self.containerView.backgroundColor = .green
            }
        }
    }
        
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupCellView()
    }
        
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RouteInfoCollectionViewCell {
    
    private func setupCellView() {
        
        contentView.addSubview(containerView)
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
        
        styleContainerView()
        
        addSubview(routeNameLabel)
        NSLayoutConstraint.activate([
            routeNameLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            routeNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
         ])
            
        addSubview(sourceDestinationNameLabel)
        NSLayoutConstraint.activate([
            sourceDestinationNameLabel.topAnchor.constraint(equalTo: routeNameLabel.bottomAnchor, constant: 8),
            sourceDestinationNameLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
         ])
        
        addSubview(timeDurationLabel)
        NSLayoutConstraint.activate([
            timeDurationLabel.topAnchor.constraint(equalTo: sourceDestinationNameLabel.bottomAnchor, constant: 8),
            timeDurationLabel.centerXAnchor.constraint(equalTo: containerView.centerXAnchor)
         ])
    }
        
    private func styleContainerView() {
        containerView.backgroundColor = .systemTeal
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = 16
        containerView.layer.borderWidth = 2
    }
        
    public func configure(viewModel: RouteInfoCellDetailViewModel) {
        routeID = viewModel.routeID ?? ""
        routeNameLabel.text = viewModel.routeNameLabel
        sourceDestinationNameLabel.text = "\(viewModel.sourceStationLabel ?? "")-\(viewModel.destinationNameLabel ?? "")"
        timeDurationLabel.text = viewModel.totalDuration
    }
        
}

