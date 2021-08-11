//
//  RouteInfoCellViewModel.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteInfoCellViewModel: NSObject {
    
    private var routeInfoArray = [RouteInfo]()
    private var routeInfoCellViewModels = [RouteInfoCellDetailViewModel]()
    private var apiService = APIService()
    private var selectedCellIndex = IndexPath()

}

extension RouteInfoCellViewModel {
    
    func updateRouteInfo(with routeInfoModel: RouteDetail?) {
        guard let routeInfoModel = routeInfoModel else { return }
        routeInfoArray = routeInfoModel.routeInfo ?? []
    }
    
    func apiCallforRouteInfo(completion: @escaping() -> Void) {
        apiService.fetchRouteDetails { (result) in
            self.updateRouteInfo(with: result)
            completion()
        }
    }
    
    func numberOfItemsInSection() -> Int {
        routeInfoCellViewModels = routeInfoArray.map { RouteInfoCellDetailViewModel(with: $0) }
        return routeInfoArray.count
    }
    
    func getRouteInfoCellModel(indexPath: IndexPath) -> RouteInfoCellDetailViewModel {
        return RouteInfoCellDetailViewModel(with: routeInfoArray[indexPath.row])
    }
    
    public func getMidCellRouteID() -> String {
        let centerIndex = self.numberOfItemsInSection() / 2
        return routeInfoArray[centerIndex].id ?? ""
    }
        
    public func selectCell(at indexPath: IndexPath) {
        selectedCellIndex = indexPath
    }
        
    public func getSelectedCellIndex() -> IndexPath? {
        if selectedCellIndex.isEmpty {
            return nil
       }
        return selectedCellIndex
    }
}
