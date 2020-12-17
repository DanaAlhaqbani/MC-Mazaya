//
//  GooglePlace.swift
//  MC Mazaya
//
//  Created by Alhanouf alabdullah on 26/04/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
import CoreLocation

struct GPlace {
    var name: String?
    var address: String?
    var imgUrl: String?
    var coordinates: (lat: Double, lng: Double)?
    var trademark: Trademark?
    }
