//
//  History.h
//  DirectDialing
//
//  Created by Itai Ram on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface History : UIViewController <UITableViewDelegate, UITableViewDataSource> {
    
    IBOutlet UITableView *tblSimpleTable;
//    NSString *product;
//    NSString *brand;
    NSDictionary *dataDict;
    NSMutableArray *listOfItems;
    NSMutableArray *namesArray;
    NSMutableArray *urlArray;
//    NSMutableArray *directNumbersArray;
//    NSMutableArray *directNamesArray;
//    NSMutableArray *callDatesArray;
//    NSString *fullNumber;
   // NSUserDefaults *defaults;
    
}

@property (nonatomic, retain) IBOutlet UITableView *tblSimpleTable;
//@property (nonatomic, retain) NSString *product;
//@property (nonatomic, retain) NSString *brand;
@property (nonatomic, retain) NSDictionary *dataDict;
@property (nonatomic, retain) NSMutableArray *listOfItems;
@property (nonatomic, retain) NSMutableArray *namesArray;
@property (nonatomic, retain) NSMutableArray *urlArray;
//@property (nonatomic, retain) NSMutableArray *directNumbersArray;
//@property (nonatomic, retain) NSMutableArray *directNamesArray;
//@property (nonatomic, retain) NSMutableArray *callDatesArray;
//@property (nonatomic, retain) NSString *fullNumber;
//@property (nonatomic, retain) NSUserDefaults *defaults;

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier;


@end
