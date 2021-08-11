//
//  RouteInfoTableViewCell.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteTimingTableViewCell: UITableViewCell {
    
    private lazy var containerView: UIView = {
        let myContainerView = UIView()
        myContainerView.translatesAutoresizingMaskIntoConstraints = false
        return myContainerView
    }()
    
    private var tripStartTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    private var availableSeatsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = .black
        return label
    }()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupCellView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension RouteTimingTableViewCell {
    private func setupCellView() {
        contentView.addSubview(containerView)
       
        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8),
            containerView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8),
            containerView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8),
            containerView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8)
        ])
        styleContainerView()
        
        addSubview(tripStartTime)
        NSLayoutConstraint.activate([
            tripStartTime.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            tripStartTime.leadingAnchor.constraint(equalTo: containerView.leadingAnchor, constant: 8),
            tripStartTime.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
        
        addSubview(availableSeatsLabel)
        NSLayoutConstraint.activate([
            availableSeatsLabel.topAnchor.constraint(equalTo: containerView.topAnchor, constant: 8),
            availableSeatsLabel.trailingAnchor.constraint(equalTo: containerView.trailingAnchor, constant: -8),
            availableSeatsLabel.centerYAnchor.constraint(equalTo: containerView.centerYAnchor)
        ])
    }
    
    private func styleContainerView() {
        containerView.backgroundColor = .systemTeal
        containerView.clipsToBounds = true
        containerView.layer.cornerRadius = contentView.frame.height / 8
    }
    
    public func configure(viewModel: RouteTimingCellDetailViewModel) {
        tripStartTime.text = "StartTime: \(viewModel.tripStartTime ?? "")"
        availableSeatsLabel.text = "AvailableSeats: \(viewModel.availableSeats ?? 0)/\(viewModel.totalSeats ?? 0)"
    }
}

