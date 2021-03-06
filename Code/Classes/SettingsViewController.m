/*******************************************************************************
 * Copyright (c) 2009 Kåre Morstøl (NotTooBad Software).
 * All rights reserved. This program and the accompanying materials
 * are made available under the terms of the Eclipse Public License v1.0
 * which accompanies this distribution, and is available at
 * http://www.eclipse.org/legal/epl-v10.html
 *
 * Contributors:
 *    Kåre Morstøl (NotTooBad Software) - initial API and implementation
 *******************************************************************************/ 

#import "SettingsViewController.h"
#import "SettingsCell.h"
#import "SettingsEditorViewController.h"

@implementation SettingsViewController

@synthesize ibDelegate, settingsdatasource;

- (void) setup {
	self.title = settingsdatasource.title;
	settingsdatasource.viewcontroller = self;
	
	/* NB: selectors are fake*/
	/*	self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:settingsdatasource action:@selector(save:)];
	 
	 self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:settingsdatasource action:@selector(save:)];
	 */
}

- (id)initWithCoder:(NSCoder *)decoder {
    if (self = [super initWithCoder:decoder]) {
        settingsdatasource = [[SettingsMetadataSource alloc] initWithConfigFile:[[NSBundle mainBundle] pathForResource:@"Root" ofType:@"plist"]];
        [self setup];
    }
    return self;
}

- (id) initWithConfigFile:(NSString *)configfile {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		settingsdatasource = [[SettingsMetadataSource alloc] initWithConfigFile:configfile];
		[self setup];
	}
	return self;
}

- (id) initWithConfigFile:(NSString *)configfile andSettings:(NSObject *)newsettings {
	if (self = [super initWithStyle:UITableViewStyleGrouped]) {
		settingsdatasource = [[SettingsMetadataSource alloc] initWithConfigFile:configfile andSettings:newsettings];
		[self setup];
	}
	return self;	
}

- (void) dealloc {
	[super dealloc];
	[settingsdatasource release];
}

- (NSObject *) settings {
	return settingsdatasource.settings;
}

#pragma mark View

- (void) viewDidLoad {
   [super viewDidLoad];
	self.tableView.delegate = settingsdatasource;
	self.tableView.dataSource = settingsdatasource;
	
    // Assign ibDelegate as data source's delegate if extant
    if (ibDelegate != nil)
        settingsdatasource.delegate = ibDelegate;
    
	// Uncomment the following line to display an Edit button in the navigation bar for this view controller.
	// self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

/*
 - (void)viewWillAppear:(BOOL)animated {
 [super viewWillAppear:animated];
 }
 */

/*
 - (void)viewDidAppear:(BOOL)animated {
 [super viewDidAppear:animated];
 }
 */
/*
 - (void)viewWillDisappear:(BOOL)animated {
 [super viewWillDisappear:animated];
 }
 */

- (void) viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[settingsdatasource save];
}

/*
 - (void)didReceiveMemoryWarning {
 [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
 // Release anything that's not essential, such as cached data
 }
 */


@end

