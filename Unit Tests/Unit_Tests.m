//
//  Unit_Tests.m
//  Unit Tests
//
//  Created by Sven Resch on 2015-11-22.
//  Copyright © 2015 Logicopolis Technology Inc. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "ChangeAPIManager.h"

@interface Unit_Tests : XCTestCase

@property (nonatomic, strong) XCTestExpectation *expectation1;
@property (nonatomic, strong) XCTestExpectation *expectation2;

@end

@implementation Unit_Tests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testChange
{
    self.expectation1 = [self expectationWithDescription:@"Change step 1 asynchronous request"];
    self.expectation2 = [self expectationWithDescription:@"Change step 2 asynchronous request"];

    [self startChangeStep1];
    
    [self waitForExpectationsWithTimeout:10.0 handler:nil];
}


- (void)startChangeStep1
{
    ChangeAPIManager *mgr = [ChangeAPIManager sharedManager];
    
    PetitionUrlRequestModel *model = [[PetitionUrlRequestModel alloc] init];
    model.petitionUrlStr = @"https://www.change.org/p/el-presidente-this-is-just-a-test-petition-description";

    NSURLSessionDataTask *task = [mgr petitionIdWithPetitionUrlRequestModel:model
                                                                    success:
                                  ^(PetitionIdResponseModel *responseModel)
                                  {
                                      NSLog(@"Change step 1 response: %ld", responseModel.petitionId.integerValue);
                                      [self startChangeStep2:responseModel.petitionId];
                                      [self.expectation1 fulfill];
                                  }
                                                                    failure:^(NSError *error)
                                  {
                                      XCTAssertNil(error, @"Change step 1 error %@", error);
                                  }];
}

- (void)startChangeStep2:(NSNumber *)petitionId
{
    ChangeAPIManager *mgr = [ChangeAPIManager sharedManager];
    
    PetitionIdRequestModel *model = [[PetitionIdRequestModel alloc] init];
    model.petitionId = petitionId;
    
    NSURLSessionDataTask *task = [mgr petitionWithPetitionIdRequestModel:model
                                                                 success:
                                  ^(PetitionResponseModel *responseModel) {
                                      NSLog(@"Change step 2 response: %@", responseModel.title);
                                      [self.expectation2 fulfill];
                                  } failure:^(NSError *error) {
                                      XCTAssertNil(error, @"Change step 2 error %@", error);
                                  }];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
