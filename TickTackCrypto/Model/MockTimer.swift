//
//  MockTimer.swift
//  TickTackCrypto
//
//  Created by Maciej Mejer on 18/09/2022.
//

import Foundation

class MockTimer: Timer {
    
    var block: ((Timer) -> Void)!
    
    static var currentTimer: MockTimer!
    
    override func fire() {
        block(self)
    }
    
    override open class func scheduledTimer(withTimeInterval interval: TimeInterval, repeats: Bool, block: @escaping (Timer) -> Void) -> Timer {
        let mockTimer = MockTimer()
        mockTimer.block = block
        
        MockTimer.currentTimer = mockTimer
        
        return mockTimer
    }
}
