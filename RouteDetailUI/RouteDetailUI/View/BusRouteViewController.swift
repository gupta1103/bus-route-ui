//
//  ViewController.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class BusRouteViewController: UIViewController {
    
    private var routeInfoCellViewModel = RouteInfoCellViewModel()
    private var routeTimingCellViewModel = RouteTimingCellViewModel()
    
    private var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: 280, height: 120)
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        let myCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        myCollectionView.translatesAutoresizingMaskIntoConstraints = false
        return myCollectionView
    }()
    
    private var tableView: UITableView = {
        let myTableView = UITableView()
        myTableView.translatesAutoresizingMaskIntoConstraints = false
        myTableView.backgroundColor = .systemGray
        return myTableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.register(RouteInfoCollectionViewCell.self, forCellWithReuseIdentifier: String(describing: RouteInfoCollectionViewCell.self))
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.register(RouteTimingTableViewCell.self, forCellReuseIdentifier: String(describing: RouteTimingTableViewCell.self))
        tableView.delegate = self
        tableView.dataSource = self
        
        styleViews()
        
        routeInfoCellViewModel.apiCallforRouteInfo {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
        
        routeTimingCellViewModel.apiCallforRouteTiming {
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
}

extension BusRouteViewController {
    
    private func styleViews() {
        self.view.addSubview(collectionView)
        NSLayoutConstraint.activate([
            collectionView.topAnchor.constraint(equalTo: self.view.topAnchor, constant: 48),
            collectionView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor),
            collectionView.heightAnchor.constraint(equalToConstant: 160)
        ])
        
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 8),
            tableView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: self.view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: self.view.trailingAnchor)
        ])
    }
}

extension BusRouteViewController: UICollectionViewDelegate {
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        if routeTimingCellViewModel.isEmpty(), routeInfoCellViewModel.getSelectedCellIndex() == nil {
            let centerIndex = routeInfoCellViewModel.numberOfItemsInSection() / 2
            let indexPath = IndexPath(item: centerIndex, section: 0)
                
            routeInfoCellViewModel.selectCell(at: indexPath)
                
            let routeID = routeInfoCellViewModel.getMidCellRouteID()
            routeTimingCellViewModel.addRouteTimings(routeID: routeID)

            collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)

            self.tableView.reloadData()
        } else {
            guard let indexPath = routeInfoCellViewModel.getSelectedCellIndex() else { return }
            collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        }
    }
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath) as! RouteInfoCollectionViewCell
        
        routeTimingCellViewModel.removeAllPresentRouteTimings()
        routeTimingCellViewModel.addRouteTimings(routeID: cell.routeID)
    
        routeInfoCellViewModel.selectCell(at: indexPath)
        collectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        self.tableView.reloadData()
    }
}

extension BusRouteViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return routeInfoCellViewModel.numberOfItemsInSection()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: String(describing: RouteInfoCollectionViewCell.self), for: indexPath) as! RouteInfoCollectionViewCell
        cell.configure(viewModel: routeInfoCellViewModel.getRouteInfoCellModel(indexPath: indexPath))
        return cell
    }
}

extension BusRouteViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80.0
    }
}

extension BusRouteViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return routeTimingCellViewModel.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: String(describing: RouteTimingTableViewCell.self), for: indexPath) as! RouteTimingTableViewCell
        cell.configure(viewModel: routeTimingCellViewModel.getRouteTimingCellViewModel(indexPath: indexPath))
        return cell
    }
}
