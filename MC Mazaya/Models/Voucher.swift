//
//  Voucher.swift
//  MC Mazaya
//
//  Created by دانة الحقباني on 16/03/1442 AH.
//  Copyright © 1442 MC. All rights reserved.
//

import Foundation
struct Voucher {
    var BrandImage : String?
    var BrandName : String?
    var Vouchertitle : String?
    var VoucherCode : String?
    var voucherNum : Int?
    var voucherDes : String?
    
    init(BrandImage : String? , BrandName : String?, Vouchertitle : String?, VoucherCode : String? , voucherNum : Int?, voucherDes : String?) {
        self.BrandImage = BrandImage
        self.BrandName = BrandName
        self.Vouchertitle = Vouchertitle
        self.VoucherCode = VoucherCode
        self.voucherNum = voucherNum
        self.voucherDes = voucherDes
    }
    
}
