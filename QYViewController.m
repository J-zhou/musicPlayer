//
//  QYViewController.m
//  musicPlayer
//
//  Created by qingyun_zhoujin on 14-5-6.
//  Copyright (c) 2014年 hnqingyun. All rights reserved.
//

#import "QYViewController.h"
#import "QYMusicListTableViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface QYViewController ()
@property (weak, nonatomic) IBOutlet UISlider *sliderVolume;
@property (weak, nonatomic) IBOutlet UISlider *sliderProgress;
@property (weak, nonatomic) IBOutlet UIButton *playOrPauseBtn;
@property (weak, nonatomic) IBOutlet UIButton *voiceVolumeBtn;

@property (weak, nonatomic) IBOutlet UIButton *menubutton;
@property (weak, nonatomic) IBOutlet UIView *upView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *minTimeLabel;

@property (weak, nonatomic) IBOutlet UILabel *maxTimeLabel;

@property (nonatomic,retain) AVAudioPlayer *audioPlayer;

@property (nonatomic,retain) NSArray *nameList;
@property (weak, nonatomic) IBOutlet UITableView *lyricsVIew;

@property (nonatomic,retain) NSString *musicName;

@property (nonatomic,assign) NSInteger index;
@property (nonatomic,retain) QYMusicListTableViewController *musicListCtr ;
@end

@implementation QYViewController



- (void)viewWillAppear:(BOOL)animated
{
    self.navigationController.navigationBarHidden = YES;
    
    [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(onTimer:) userInfo:nil repeats:YES];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    self.musicListCtr = [[QYMusicListTableViewController alloc]init];
    
    [self.musicListCtr addObserver:self forKeyPath:@"musicNameStr" options:NSKeyValueObservingOptionNew |NSKeyValueObservingOptionOld context:nil];
    
    //双击屏幕隐藏音量view
    UITapGestureRecognizer *tap2 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap2:)];
    tap2.numberOfTapsRequired = 2,
    tap2.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap2];
    
    //单击屏幕显示音量view
    UITapGestureRecognizer *tap1 = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(onTap1:)];
    tap1.numberOfTapsRequired = 1;
    tap1.numberOfTouchesRequired = 1;
    [self.view addGestureRecognizer:tap1];

    [tap1 requireGestureRecognizerToFail:tap2];
    
    self.nameList = @[@"小星星",@"赤裸裸",@"Better In Time",@"Let It Go",@"Ready To Go",@"发现爱",@"那年夏天宁静的海",@"情非得已",@"私奔",@"外婆桥",@"万万没想到",@"我爱洗澡",@"心语",@"夜光"];
    
	
}


- (void)onTap1:(UITapGestureRecognizer *)tap
{
    self.upView.hidden = NO;
}
- (void)onTap2:(UITapGestureRecognizer *)tap
{
    self.upView.hidden = YES;
}



-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    

    NSString *musicName = [change valueForKey:NSKeyValueChangeNewKey];
    
    for ( NSString *str in self.nameList) {
        if ([str isEqualToString:musicName]) {
            self.index = [self.nameList indexOfObject:musicName];
        }
        

    }
    
    NSURL *playSound =[[NSBundle mainBundle] URLForResource:self.nameList[self.index] withExtension:@"mp3"] ;
    
    NSError *error = nil;
    
    self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:playSound error:&error];
    if (error != nil) {
        NSLog(@"Init aduioPlayer faile.Error:%@",error);
    }
//    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    [self.playOrPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
    
    self.sliderProgress.minimumValue = 0;
    self.sliderProgress.maximumValue = self.audioPlayer.duration;
    
    self.nameLabel.text = musicName;
    self.nameLabel.textColor = [UIColor yellowColor];
    
    [self nextBtn];
    
}
- (IBAction)onPlayBtn:(UIButton *)sender {
    
    
    if ([self.audioPlayer isPlaying]) {
        
        [self.audioPlayer pause];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:@"play"] forState:UIControlStateNormal];
        
        
    }else
    {
        [self.audioPlayer play];
        [self.playOrPauseBtn setImage:[UIImage imageNamed:@"pause"] forState:UIControlStateNormal];
        
        
    }


}

- (void)onTimer:(NSTimer *)timer
{
    self.sliderProgress.value = self.audioPlayer.currentTime;
    self.minTimeLabel.text = [NSString stringWithFormat:@"%d:%d",(int)self.sliderProgress.value/60,(int)self.sliderProgress.value%60];
    self.maxTimeLabel.text = [NSString stringWithFormat:@"%d:%d",(int)self.audioPlayer.duration/60,(int)self.audioPlayer.duration%60];
}

- (IBAction)aboveBtn:(UIButton *)sender {
    
    if (self.index == 0) {
        self.index = 13;
        
        NSURL *lastSound =[[NSBundle mainBundle] URLForResource:self.nameList[13] withExtension:@"mp3"] ;
        
        
        NSError *error = nil;
        
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:lastSound error:&error];
        if (error != nil) {
            NSLog(@"Init aduioPlayer faile.Error:%@",error);
        }
        self.audioPlayer.numberOfLoops = -1;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        
        self.nameLabel.text = self.nameList[13];
    }else {
        
        NSURL *playSound =[[NSBundle mainBundle] URLForResource:self.nameList[--self.index] withExtension:@"mp3"] ;
    
    
    NSError *error = nil;
    
    self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:playSound error:&error];
    if (error != nil) {
        NSLog(@"Init aduioPlayer faile.Error:%@",error);
    }
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
    
    self.nameLabel.text = self.nameList[self.index];
    
    }
}

- (IBAction)nextBtn:(UIButton *)sender {
    if (self.index == 13) {
        self.index = 0;
        NSURL *firstSound =[[NSBundle mainBundle] URLForResource:self.nameList[0] withExtension:@"mp3"] ;
        
        NSError *error = nil;
        
        self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:firstSound error:&error];
        if (error != nil) {
            NSLog(@"Init aduioPlayer faile.Error:%@",error);
        }
        self.audioPlayer.numberOfLoops = -1;
        [self.audioPlayer prepareToPlay];
        [self.audioPlayer play];
        
        
        self.nameLabel.text = self.nameList[0];
        
    }else{
    
    NSURL *playSound =[[NSBundle mainBundle] URLForResource:self.nameList[++self.index] withExtension:@"mp3"] ;
    
    NSError *error = nil;
    
    self.audioPlayer =[[AVAudioPlayer alloc] initWithContentsOfURL:playSound error:&error];
    if (error != nil) {
        NSLog(@"Init aduioPlayer faile.Error:%@",error);
    }
    self.audioPlayer.numberOfLoops = -1;
    [self.audioPlayer prepareToPlay];
    [self.audioPlayer play];
        
    
    self.nameLabel.text = self.nameList[self.index];
        
    }
}

- (IBAction)onMenuBtn:(UIButton *)sender
{

    [self.navigationController pushViewController:self.musicListCtr animated:YES];
    self.navigationController.navigationBarHidden = NO;
}

- (IBAction)onSliderProgress:(UISlider *)sender {
    self.audioPlayer.currentTime = self.sliderProgress.value;
}

- (IBAction)onVoiceVolumeBtn:(UIButton *)sender {
    
    if (self.audioPlayer.volume != 0 ) {
        [self.voiceVolumeBtn setImage:[UIImage imageNamed:@"aio_group_block_anti@2x"] forState:UIControlStateNormal];
        self.audioPlayer.volume = 0;
    }else if (self.audioPlayer.volume == 0){
        [self.voiceVolumeBtn setImage:[UIImage imageNamed:@"voice_volumeicon_mouseover@2x"] forState:UIControlStateNormal];
        self.audioPlayer.volume = self.sliderVolume.value;
    }

}


- (IBAction)onVolumeSlider:(UISlider *)sender {
    self.audioPlayer.volume = self.sliderVolume.value;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
