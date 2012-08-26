//
//  History.m
//  DirectDialing
//
//  Created by Itai Ram on 3/12/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "History.h"

@implementation History

@synthesize tblSimpleTable;
//@synthesize product;
//@synthesize brand;
@synthesize dataDict;
@synthesize listOfItems;
@synthesize namesArray;
@synthesize urlArray;
//@synthesize directNumbersArray;
//@synthesize directNamesArray;
//@synthesize callDatesArray;
//@synthesize fullNumber;
//@synthesize defaults;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
//        product = [[NSString alloc] init];
//        brand = [[NSString alloc] init];
        namesArray = [[NSMutableArray alloc] initWithObjects:nil];
        urlArray = [[NSMutableArray alloc] initWithObjects:nil];
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];    
    
    //NAV TITLE
    self.navigationItem.title = NSLocalizedString(@"Record History", nil);

    //NAV ITEMS
//    UIBarButtonItem *rightButton = [[UIBarButtonItem alloc] initWithTitle:@"Edit" style:UIBarButtonItemStylePlain target:self action:@selector(editTable:)];      
    //self.navigationItem.rightBarButtonItem = self.editButtonItem;
    self.navigationItem.rightBarButtonItem = nil;
    
    //CREATING THE TABLE 
    tblSimpleTable = [[UITableView alloc]  initWithFrame:CGRectMake(0, 0, 320, 420) style:UITableViewStylePlain ];
    tblSimpleTable.dataSource = self;
    tblSimpleTable.delegate = self;
    [self.view addSubview:tblSimpleTable];
    
    //TABLE DATA MANAGEMENT
    namesArray = [NSMutableArray arrayWithObjects:nil];
    urlArray = [NSMutableArray arrayWithObjects:nil];
    //    directNumbersArray = [NSMutableArray arrayWithObjects:nil];
    //    directNamesArray = [NSMutableArray arrayWithObjects:nil];
    
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    NSData *archivedHistoryURLData = [[NSData alloc] init];
    NSData *archivedHistoryRecordNameData = [[NSData alloc] init];
    archivedHistoryRecordNameData = [defaults dataForKey:@"historyRecordName"];
    archivedHistoryURLData = [defaults dataForKey:@"historyURL"];
    urlArray = [NSKeyedUnarchiver unarchiveObjectWithData:archivedHistoryURLData];
    namesArray = [NSKeyedUnarchiver unarchiveObjectWithData:archivedHistoryRecordNameData];

//    namesArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:@"historyURL"]];
//    urlArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:@"historyRecordName"]];
    //    directNumbersArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:@"historyDirectNumbers"]];
    //    directNamesArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:@"historyDirectNumberNames"]];
    //    callDatesArray = [[NSMutableArray alloc] initWithArray:[defaults arrayForKey:@"historyCallDates"]];
    
    //    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:accessNamessArray,@"AccessNames",directNamesArray,@"DirectNames",nil];
    dataDict = [[NSDictionary alloc] initWithObjectsAndKeys:namesArray, @"Names", urlArray, @"URLs", nil];
    
    NSLog(@"dataDict AccessNames %@", [dataDict objectForKey:@"Names"]);
    NSLog(@"dataDict DirectNames %@", [dataDict objectForKey:@"URLs"]);
    
    listOfItems = [[NSMutableArray alloc] init];
    [tblSimpleTable reloadData];
    
    NSLog(@"namesArray is %@", namesArray);
    NSLog(@"urlArray is %@", urlArray);
    
    //DONT SHOW EDIT BUTTON ON NAV BAR IF THERE ARE NO RECORDS
    if ([namesArray count] == 0 )
    {
        self.navigationItem.rightBarButtonItem = nil;
    }
    else
    {
        self.navigationItem.rightBarButtonItem = self.editButtonItem;
    }

}

-(void)viewWillAppear:(BOOL)animated {
 
    [super viewWillAppear:animated];
    NSLog(@"viewWillAppear ");

}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [self getCellContentView:CellIdentifier];
    }
        
    NSString *cellValue = [[NSString alloc] init];
    cellValue = [namesArray objectAtIndex:indexPath.row];
    //cell.textLabel.numberOfLines = 2;
    NSLog(@"cellValue  %@", cellValue);

    NSString *subCellValue = [[NSString alloc] init];
    subCellValue = [namesArray objectAtIndex:indexPath.row];
    NSLog(@"subCellValue  %@", subCellValue);

//    NSString *dateCellValue = [[NSString alloc] init];
//    dateCellValue = [namesArray objectAtIndex:indexPath.row];

    UILabel *lblTemp1 = (UILabel *)[cell viewWithTag:1];
	UILabel *lblTemp2 = (UILabel *)[cell viewWithTag:2];
//    UILabel *lblTemp3 = (UILabel *)[cell viewWithTag:3];

    
    lblTemp1.text = cellValue;
    lblTemp2.text = subCellValue;
//    lblTemp3.text = dateCellValue;

    
    
    //    cell.textLabel.text = cellValue;
    //    cell.detailTextLabel.text = subCellValue;
    
    return cell;
}

- (UITableViewCell *) getCellContentView:(NSString *)cellIdentifier {
	
    //	CGRect CellFrame = CGRectMake(0, 0, 300, 60);
	CGRect Label1Frame = CGRectMake(10, 10, 220, 25);
	CGRect Label2Frame = CGRectMake(10, 33, 220, 25);
//    CGRect Label3Frame = CGRectMake(250, 17.5, 80, 25);

	UILabel *lblTemp;
    UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIdentifier ];
	
	//Initialize Label with tag 1.
	lblTemp = [[UILabel alloc] initWithFrame:Label1Frame];
	lblTemp.tag = 1;
    lblTemp.font = [UIFont systemFontOfSize:20];
	[cell.contentView addSubview:lblTemp];
	
	//Initialize Label with tag 2.
	lblTemp = [[UILabel alloc] initWithFrame:Label2Frame];
	lblTemp.tag = 2;
	lblTemp.font = [UIFont boldSystemFontOfSize:12];
	lblTemp.textColor = [UIColor lightGrayColor];
	[cell.contentView addSubview:lblTemp];
	
//    //Initialize Label with tag 3.
//	lblTemp = [[UILabel alloc] initWithFrame:Label3Frame];
//	lblTemp.tag = 3;
//    lblTemp.font = [UIFont systemFontOfSize:16];
//    lblTemp.textColor = [UIColor colorWithRed:7.0/255.0 green:119.0/255.0 blue:1 alpha:1.0];
//    //lblTemp.textColor = [UIColor colorWithRed:.196 green:0.3098 blue:0.52 alpha:1.0];
//	[cell.contentView addSubview:lblTemp];
    
	return cell;
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath {
    return UITableViewCellEditingStyleDelete;
}

- (void)tableView:(UITableView *)aTableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
	    
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        [namesArray removeObjectAtIndex:indexPath.row];
        [urlArray removeObjectAtIndex:indexPath.row];
//        [directNumbersArray removeObjectAtIndex:indexPath.row];
//        [directNamesArray removeObjectAtIndex:indexPath.row];
//        [callDatesArray removeObjectAtIndex:indexPath.row];
        
        [tblSimpleTable deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        
        NSLog(@"indexPath.row is %d", indexPath.row);
        NSLog(@"namesArray is %@", namesArray);
        NSLog(@"section2 is %@", urlArray);
    //    NSLog(@"section3 is %@", callDatesArray);
        
        if ([namesArray count] == 0)
        {
            tblSimpleTable.editing = NO;
            [self setEditing:NO animated:YES];
            [self.navigationItem setRightBarButtonItem:nil animated:YES];
        }
        
        
        //UPDATING/SAVING USERS DEFAULTS
        NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
        NSData *data1 = [NSKeyedArchiver archivedDataWithRootObject:namesArray];
        NSData *data2 = [NSKeyedArchiver archivedDataWithRootObject:urlArray];
        
        [defaults setObject:data1 forKey:@"historyRecordName"];
        [defaults setObject:data2 forKey:@"historyURL"];
        
        [defaults synchronize];

//        [defaults setObject:namesArray forKey:@"historyURL"];    
//        [defaults setObject:urlArray forKey:@"historyRecordName"];  
//        [defaults setObject:directNumbersArray forKey:@"historyDirectNumbers"];
//        [defaults setObject:directNamesArray forKey:@"historyDirectNumberNames"];  
//        [defaults setObject:callDatesArray forKey:@"historyCallDates"];  
    }
    //Inserting an element to the table 
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        //        NSMutableArray * section = [listOfItems objectAtIndex:indexPath.section];    
        //        [section addObject:@"mac mini"];
        //        [tblSimpleTable insertRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationRight];
        // 		[tblSimpleTable reloadData];
    }
    
    [tblSimpleTable reloadData];
    
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {    
        return YES;
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated {
    [super setEditing:editing animated:animated];
    [tblSimpleTable setEditing:editing animated:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //    return [listOfItems count];    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    NSArray *array = [dataDict objectForKey:@"Names"];
    NSLog(@"number of rows: %d", [array count]);
    return [array count];
}

- (void)tableView:(UITableView *)tableView didEndEditingRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView reloadData];
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {   
    
//    fullNumber = [NSString stringWithFormat:@"%@%@%@%@", @"tel:", [namesArray objectAtIndex:indexPath.row], @",", [directNumbersArray objectAtIndex:indexPath.row]];
//    NSString *myMessage = [NSString stringWithFormat:NSLocalizedString(@"DialingConfirmation", nil), [directNumbersArray objectAtIndex:indexPath.row] , [namesArray objectAtIndex:indexPath.row]];
//
//    NSLog(@"access num is %@, and direct num is %@", [namesArray objectAtIndex:indexPath.row], [directNumbersArray objectAtIndex:indexPath.row]);
//    
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleDisplayName"] 
//                                       message:myMessage
//                                      delegate:self 
//                             cancelButtonTitle:NSLocalizedString(@"Cancel", nil) 
//                             otherButtonTitles:NSLocalizedString(@"Dial", nil), nil];
//    
//    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];     
//    BOOL dialAlertSwitch = [defaults boolForKey:@"DialNotificationAlertState"];
//
//    if (dialAlertSwitch == 1){
//        [alert show];
//    }
//    else {
//        NSURL *url = [NSURL URLWithString:fullNumber];
//        [[UIApplication sharedApplication] openURL:url];
//    }
    return nil;
}

- (void)alertView:(UIAlertView *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex {
    
//    if (buttonIndex == 0)
//    {       
//        NSLog(@"cancel");
//    }
//    else
//    {
//        NSLog(@"ok");
//        NSURL *url = [NSURL URLWithString:fullNumber];
//        [[UIApplication sharedApplication] openURL:url];
//        //     [self dismissModalViewControllerAnimated:YES];    
//        
//    }
}


- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath{
    return NSLocalizedString(@"Delete", nil);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}


/*
 
 - (UITableViewCellAccessoryType)tableView:(UITableView *)tableView accessoryTypeForRowWithIndexPath:(NSIndexPath *)indexPath {
 
 //return UITableViewCellAccessoryDetailDisclosureButton;
 return UITableViewCellAccessoryDisclosureIndicator;
 }
 */

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
//    return @"My past access numbers";
    return nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation{
    return interfaceOrientation == UIInterfaceOrientationPortrait || interfaceOrientation == UIInterfaceOrientationPortraitUpsideDown ;
}

@end
