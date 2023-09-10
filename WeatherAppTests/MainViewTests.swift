//
//  MainViewTests.swift
//  WeatherAppTests
//
//  Created by Thore Brehmer on 07.09.23.
//

import XCTest
@testable import WeatherApp //import for structs

final class MainViewTests: XCTestCase {

    func testSuccessfulPositiveAbs1() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = -10
        let testSing = Vorzeichen.positiv
        
        //When (Act)
        let res = try tested.abs(num: testNum, sign: testSing)
        
        //Then (Assert)
        XCTAssertEqual(res, 10)
    }
    
    func testSuccessfulPositiveAbs2() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = 10
        let testSing = Vorzeichen.positiv
        
        //When (Act)
        let res = try tested.abs(num: testNum, sign: testSing)
        
        //Then (Assert)
        XCTAssertEqual(res, 10)
    }
    
    func testSuccessfulNegativeAbs1() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = -10
        let testSing = Vorzeichen.negative
        
        //When (Act)
        let res = try tested.abs(num: testNum, sign: testSing)
        
        //Then (Assert)
        XCTAssertEqual(res, -10)
    }
    
    func testSuccessfulNegativeAbs2() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = 10
        let testSing = Vorzeichen.negative
        
        //When (Act)
        let res = try tested.abs(num: testNum, sign: testSing)
        
        //Then (Assert)
        XCTAssertEqual(res, -10)
    }
    
    func testThrowsError() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = 0
        let testSing = Vorzeichen.negative
        
        //When (Act)
        let res = {try tested.abs(num: testNum, sign: testSing)}
        
        //Then (Assert)
        XCTAssertThrowsError(try res())
    }
    
    func testReturnsNil() throws {
        //Given (Arrange)
        let tested = ForUnitTestOnly()
        let testNum = -1
        let testSing = Vorzeichen.negative
        
        //When (Act)
        let res = try tested.abs(num: testNum, sign: testSing)
        
        //Then (Assert)
        XCTAssertNil(res)
    }

}
