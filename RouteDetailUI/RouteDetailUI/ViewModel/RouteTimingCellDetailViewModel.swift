//
//  RouteTimingCellDetailViewModel.swift
//  RouteDetailUI
//
//  Created by Akanksha Gupta on 06/08/21.
//

import UIKit

class RouteTimingCellDetailViewModel: NSObject {
    
    let totalSeats: Int?
    let availableSeats: Int?
    let tripStartTime: String?
        
    init(with model: RouteTiming?) {
        self.totalSeats = model?.totalSeats
        self.availableSeats = model?.avaiable
        self.tripStartTime = model?.tripStartTime
    }
}
