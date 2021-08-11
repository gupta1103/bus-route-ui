//
//  RouteTimingCellViewModel.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteTimingCellViewModel: NSObject {
    
    private var apiService = APIService()
    private var routeTimingList = [String: [RouteTiming]]()
    private var routeTimingCellViewModel = [RouteTimingCellDetailViewModel]()
    private var routeTimingArray = [RouteTiming]()
}

extension RouteTimingCellViewModel {
    
    func updateRouteTiming(with routeTimingModel: RouteDetail?) {
        guard let routeTimingModel = routeTimingModel else { return }
        self.routeTimingList = routeTimingModel.routeTimings ?? [:]
    }
    
    func apiCallforRouteTiming(completion: @escaping() -> Void) {
        apiService.fetchRouteDetails { (result) in
            self.updateRouteTiming(with: result)
            completion()
        }
    }
        
    func numberOfRowsInSection() -> Int {
        routeTimingCellViewModel = routeTimingArray.map { RouteTimingCellDetailViewModel(with: $0) }
        return routeTimingArray.count
    }
    
    func getRouteTimingCellViewModel(indexPath: IndexPath) -> RouteTimingCellDetailViewModel {
        return RouteTimingCellDetailViewModel(with: routeTimingArray[indexPath.row])
    }
    
    public func isEmpty() -> Bool {
            return routeTimingArray.count == 0
        }
        
    public func removeAllPresentRouteTimings() {
        if routeTimingArray.count > 0 {
            routeTimingArray.removeAll()
        }
        return
    }
        
    public func addRouteTimings(routeID: String) {
        let routes = routeTimingList.filter{ $0.key == routeID }.map{ $0.value }
        for routeTimingArray in routes.map({ $0 }) {
            self.routeTimingArray = routeTimingArray
                
        }
        
    }
    
}
