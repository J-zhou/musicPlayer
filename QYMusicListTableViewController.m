//
//  QYMusicListTableViewController.m
//  musicPlayer
//
//  Created by qingyun_zhoujin on 14-5-7.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYMusicListTableViewController.h"

static NSString *kCellIndentifier = @"cellIndentify";
static NSString *kMusicNameKey = @"musicNameKey";
static NSString *kSingerNameKey = @"singerNameKey";


@interface QYTableViewCell : UITableViewCell

@end
@implementation QYTableViewCell


- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    return [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier];
}
@end

@interface QYMusicListTableViewController ()

@property (nonatomic,copy) NSArray *dataSource;
@property (nonatomic,retain) NSString *musicNameStr;
@end

@implementation QYMusicListTableViewController

- (void)viewWillAppear:(BOOL)animated
{
    UIImageView *imageView = [[UIImageView alloc]initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"3820321_1_wallpages_201405_-320x568.jpg"];
    imageView.alpha = 0.5;
    self.tableView.backgroundView = imageView;
    
//    self.tableView.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"3820321_1_wallpages_201405_-320x568.jpg"]];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.title = @"歌曲列表";
    
    self.dataSource = @[
                        @{kMusicNameKey : @"小星星",
                          kSingerNameKey : @"王心凌"
                          },
                        @{kMusicNameKey : @"赤裸裸",
                          kSingerNameKey : @"郑钧"
                          },
                        @{kMusicNameKey : @"Better In Time",
                          kSingerNameKey : @"Leona Lewis"
                          },
                        @{kMusicNameKey : @"Let It Go",
                          kSingerNameKey : @"Idina Menzel"
                          },
                        @{kMusicNameKey : @"Ready To Go",
                          kSingerNameKey : @"Republica"
                          },
                        @{kMusicNameKey : @"发现爱",
                          kSingerNameKey : @"林俊杰"
                          },
                        @{kMusicNameKey : @"那年夏天宁静的海",
                          kSingerNameKey : @"王心凌"
                          },
                        @{kMusicNameKey : @"情非得已",
                          kSingerNameKey : @"庾澄庆"
                          },
                        @{kMusicNameKey : @"私奔",
                          kSingerNameKey : @"郑钧"
                          },
                        @{kMusicNameKey : @"外婆桥",
                          kSingerNameKey : @"洛天伊"
                          },
                        @{kMusicNameKey : @"万万没想到",
                          kSingerNameKey : @"王大锤"
                          },
                        @{kMusicNameKey : @"我爱洗澡",
                          kSingerNameKey : @"小仙女"
                          },
                        @{kMusicNameKey : @"心语",
                          kSingerNameKey : @"韩红"
                          },
                        @{kMusicNameKey : @"夜光",
                          kSingerNameKey : @"齐柒柒"
                          },
                        ];
    
    [self.tableView registerClass:[QYTableViewCell class] forCellReuseIdentifier:kCellIndentifier];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{

    return self.dataSource.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kCellIndentifier forIndexPath:indexPath];
    
    cell.textLabel.text = [self.dataSource[indexPath.row] objectForKey:kMusicNameKey];
    cell.detailTextLabel.text = [self.dataSource[indexPath.row] objectForKey:kSingerNameKey];
    
    cell.backgroundColor = [UIColor clearColor];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.musicNameStr =[self.dataSource[indexPath.row] objectForKey:kMusicNameKey];
   
    [self.navigationController popToRootViewControllerAnimated:YES];
    
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


/*
#pragma mark - Table view delegate

// In a xib-based application, navigation from a table can be handled in -tableView:didSelectRowAtIndexPath:
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Navigation logic may go here, for example:
    // Create the next view controller.
     *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:<#@"Nib name"#> bundle:nil];
    
    // Pass the selected object to the new view controller.
    
    // Push the view controller.
    [self.navigationController pushViewController:detailViewController animated:YES];
}
*/

@end
